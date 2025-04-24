/**
 * @file verilator_copy_tree.cc
 * @brief A tool for copying generated verilator outputs into unique source and header directories.
 */

#include <sys/stat.h>

#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#ifdef _WIN32
#include <direct.h>
#define mkdir(dir, mode) _mkdir(dir)
#else
#include <unistd.h>
#endif

void create_directory(const std::string& path) {
    if (mkdir(path.c_str(), 0700) != 0 && errno != EEXIST) {
        std::cerr << "Error creating directory: " << path << std::endl;
        std::exit(1);
    }
}

void copy_file(const std::string& src, const std::string& dest) {
    std::ifstream src_stream(src, std::ios::binary);
    std::ofstream dest_stream(dest, std::ios::binary);
    if (!src_stream || !dest_stream) {
        std::cerr << "Error copying " << src << " to " << dest << std::endl;
        return;
    }
    dest_stream << src_stream.rdbuf();
}

int main(int argc, char* argv[]) {
    if (argc < 5) {
        std::cerr << "Usage: " << argv[0]
                  << " --src_output=<src_dir> --hdr_output=<hdr_dir> --src="
                     "<file1> ... --hdr=<file2> ..."
                  << std::endl;
        return 1;
    }

    std::string src_output = {};
    std::string hdr_output = {};
    std::vector<std::string> srcs = {};
    std::vector<std::string> hdrs = {};

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        size_t pos = arg.find('=');
        if (pos != std::string::npos) {
            std::string key = arg.substr(0, pos);
            std::string value = arg.substr(pos + 1);
            if (key == "--src_output") {
                src_output = value;
            } else if (key == "--hdr_output") {
                hdr_output = value;
            } else if (key == "--src") {
                srcs.push_back(value);
            } else if (key == "--hdr") {
                hdrs.push_back(value);
            } else {
                std::cerr << "Unexpected argument: " << arg << std::endl;
                return 1;
            }
        } else {
            std::cerr << "Unexpected argument: " << arg << std::endl;
            return 1;
        }
    }

    if (src_output.empty() || hdr_output.empty()) {
        std::cerr << "Both --src_output and --hdr_output must be specified."
                  << std::endl;
        return 1;
    }

    create_directory(src_output);
    create_directory(hdr_output);

    for (const std::string& file : srcs) {
        copy_file(file,
                  src_output + "/" + file.substr(file.find_last_of("/\\") + 1));
    }

    for (const std::string& file : hdrs) {
        copy_file(file,
                  hdr_output + "/" + file.substr(file.find_last_of("/\\") + 1));
    }

    return 0;
}
