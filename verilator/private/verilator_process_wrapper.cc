/**
 * @file verilator_process_wrapper.cc
 * @brief A process wrapper for the `VerilatorCompile` Bazel action.
 */

#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>

#ifdef _WIN32
#include <windows.h>
#else
#include <dirent.h>
#include <unistd.h>
#endif

/**
 * @brief Checks if a filename ends with any of the given suffixes.
 *
 * @param filename The name of the file.
 * @param suffixes A vector of suffixes to match.
 * @return true if the filename ends with any suffix, false otherwise.
 */
bool ends_with_any(const std::string& filename,
                   const std::vector<std::string>& suffixes) {
    for (const auto& suffix : suffixes) {
        if (filename.size() >= suffix.size() &&
            filename.compare(filename.size() - suffix.size(), suffix.size(),
                             suffix) == 0) {
            return true;
        }
    }
    return false;
}

/**
 * @brief Deletes files in the specified directory that match given suffixes.
 *
 * @param dir The directory to scan for matching files.
 * @param suffixes The list of suffixes to check for deletion.
 * * @return A non-zero exit code if any issues occurred.
 */
int delete_matching_files(const std::string& dir,
                          const std::vector<std::string>& suffixes) {
    if (dir.empty()) return 0;

#ifdef _WIN32
    std::string search_path = dir + "\\*";
    WIN32_FIND_DATAA find_data = {};
    HANDLE h_find = FindFirstFileA(search_path.c_str(), &find_data);

    if (h_find != INVALID_HANDLE_VALUE) {
        do {
            std::string filename = find_data.cFileName;
            if (ends_with_any(filename, suffixes)) {
                std::string file_path = dir + "\\" + filename;
                if (!DeleteFileA(file_path.c_str())) {
                    std::cerr << "Error: Failed to delete: " << file_path
                              << std::endl;
                    return 1;
                }
            }
        } while (FindNextFileA(h_find, &find_data) != 0);
        FindClose(h_find);
    }
#else
    DIR* dir_stream = opendir(dir.c_str());
    if (!dir_stream) {
        std::cerr << "Error accessing directory: " << dir << std::endl;
        return 1;
    }

    struct dirent* entry = nullptr;
    while ((entry = readdir(dir_stream)) != nullptr) {
        std::string filename = entry->d_name;
        if (ends_with_any(filename, suffixes)) {
            std::string file_path = dir + "/" + filename;
            int result = remove(file_path.c_str());
            if (result != 0) {
                std::cerr << "Error: Failed to delete: " << file_path
                          << std::endl;
                return result;
            }
        }
    }
    closedir(dir_stream);
#endif
    return 0;
}

int main(int argc, char* argv[]) {
    std::string output_dir{};
    std::vector<std::string> command{};

    // Parse arguments
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];

        command.push_back(arg);

        // Store the output directory value
        if (arg == "--Mdir" && i + 1 < argc) {
            output_dir = argv[i + 1];
        }
    }

    if (command.empty()) {
        std::cerr << "Error: No command provided to execute." << std::endl;
        return 1;
    }

    // Execute verilator command.
    std::string cmd = {};
    for (const std::string& part : command) {
        cmd += part + " ";
    }
    int result = std::system(cmd.c_str());
    if (result != 0) {
        return result;
    }

    // Delete any non-deterministic files.
    if (std::getenv("VERILATOR_AVOID_NONDETERMINISTIC_OUTPUTS") != nullptr) {
        std::vector<std::string> suffixes = {"__verFiles.dat"};
        if (delete_matching_files(output_dir, suffixes)) {
            return 1;
        }
    }

    return 0;
}
