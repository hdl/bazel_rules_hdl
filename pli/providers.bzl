# Copyright 2025 Antmicro
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Providers for PLI libraries"""

PliInfo = provider(
    doc = "A PLI library info",
    fields = {
        "deps": "Additional dependencies",
        "libs": "Library files",
        "tabs": "PLI .tab files",
    },
)

def _pli_library_impl(ctx):
    """
    Constructs a PliInfo provider.
    """

    pli_info = PliInfo(
        libs = depset(direct = ctx.files.libs),
        tabs = depset(direct = ctx.files.tabs),
        deps = ctx.files.deps,
    )

    return [
        pli_info,
    ]

pli_library = rule(
    doc = "Define a PLI library",
    implementation = _pli_library_impl,
    attrs = {
        "deps": attr.label_list(
            doc = "Other dependencies",
            allow_files = True,
        ),
        "libs": attr.label_list(
            doc = "Library files",
            allow_files = [".a", ".so"],  # TODO: Possibly add non-Linux extensions
        ),
        "tabs": attr.label_list(
            doc = "PLI .tab files",
            allow_files = [".tab"],
        ),
    },
)
