# Copyright 2020-2021 Google LLC
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

"""Providers for PDKs to be used by downstream synthesis."""

StandardCellInfo = provider(
    "Contains information about the standard cells used for synthesis",
    fields = {
        "corners": "list of CornerInfos for the PDK",
        "default_corner": "A default corner info defined for the PDK.",
        "tech_lef": "Tech LEF file for the PDK",
        "cell_lef_definitions": "list of Abstract LEFs files for each standard cell.",
        "platform_gds": "list of Platform GDS files.",
        "ha_fa_mapping": "HA/FA techmapping file",
        "parasitic_extraction_benchmark": "Optional calibration file for OpenRCX.",
        "open_road_configuration": "OpenROAD PDK configuration.",
    },
)

CornerInfo = provider(
    "Contains information about standard cells at different corners",
    fields = {
        "liberty": "A file that points to the liberty file for this corner",
        "with_ccsnoise": "boolean Indicates that this is a ccsnoise model.",
        "with_leakage": "boolean Indicates whether leakage is included in model",
        "corner_name": "Name of the process corner",
    },
)

StandardCellOptionsInfo = provider(
    "Provides information about what standard cell options are available",
    fields = {
        "libraries": "A list of available standard cell library names.",
        "vts": "A list of voltage thresholds names.",
        "corners": "A list of valid corners names.",
        "volts": "A list of (normalize) voltage levels names used in timing characterization.",
        "temps": "A list of (normalize) temperature values names used in timing characterization.",
    },
)

def temp_format(i):
    """Format an integer representing degrees celsius.

    Args:
        i: Temperature as integer in degrees celsius.

    Returns:
        A formated string version of input.

    The format is:
        * Always 4 characters long.
        * Always ends in lower case 'c'.
        * Negative values start with lower case `m`.
        * Left padded by zeros.

    The format can represent whole (integer) degrees between (inclusive) 999C to -99C.

    The format is designed to have sort in a decent way as a string.

    >>> voltage_format(30)
    "030c"

    >>> voltage_format(-10)
    "m10c"

    >>> voltage_format(0)
    "000c"

    """
    if i < -99 or i > 999:
        fail("Temperature value {} out side range for formatting (-99 -> 999).".format(i))

    if i < -10:
        s = "m" + str(i)[1:]
    elif i < 0:
        s = "m0" + str(i)[1:]
    elif i < 10:
        s = "00" + str(i)
    elif i < 100:
        s = "0" + str(i)
    else:
        s = str(i)

    return s + "c"

def temp_parse(s):
    """Parse a string representing temperature in degrees celsius into integer.

    Args:
        s: Temperature as string.

    Returns:
        An integer representing temperature in degrees celsius.

    >>> temp_parse("030c")
    30

    >>> temp_parse("000c")
    0

    >>> temp_parse("m35c")
    -35

    >>> temp_parse("n35c")
    -35

    >>> temp_parse("0c")
    0

    >>> temp_parse("m02c")
    -2

    """
    os = s
    s = s.lower().strip()

    # Check string ends in `c` (for degree celsius)
    if s[-1] != "c":
        fail("No `c` character found at end of value {} (input {})".format(s, os))
    s = s[:-1]

    # Convert `m` into negative sign
    if s.startswith("n"):
        s = "m" + s[1:]

    m = 1
    if s.startswith("m"):
        m = -1
        s = s[1:]

    # Trim leading zeros
    if s[:-1].startswith("0"):
        s = s[:-1].lstrip("0") + s[-1]

    return int(s) * m

def temp_normalize(s):
    """Normalize an already existing temperature string into the format provided by `temp_format`.

    Args:
        s: Temperature as string.

    Returns:
        A normalize version of the input string.

    >>> temp_normalize("m2c")
    "m02c"

    >>> temp_normalize("30c")
    "030c"

    >>> voltage_format("0c")
    "000c"

    >>> voltage_format("125c")
    "125c"
    """
    return temp_format(temp_parse(s))

def voltage_format(f):
    """Format a decimal number representing a voltage.

    Args:
        f: Voltage as decimal number (float / int).

    Returns:
        A string version of the input.

    The format is:
        * Always 5 characters long.
        * Has one digit before the decimal point.
        * Has three digital after the decimal point.
        * Uses the character `p` for the decimal point.

    The format can represent voltages between (inclusive) 9.999 volts to 0.000 volts.

    The format is designed to have sort in a decent way as a string.

    >>> voltage_format(7.5)
    "7v500"

    >>> voltage_format(0)
    "0v000"

    >>> voltage_format(-10)
    Failure...

    >>> voltage_format(2)
    Failure...

    """
    if f >= 10 or f <= 0:
        fail("Voltage value {} out side range for formatting (0.000 -> 9.999)".format(f))

    # We really want `"{:1.3f}".format(f)` but starlark doesn't support it
    s = str(f)[:5]
    if len(s) < 5:
        s = s + "0" * (5 - len(s))
    return s.replace(".", "v", 1)

def voltage_normalize(s):
    """Normalize an existing voltage string into the format provided by `voltage_format`.

    Args:
        s: Voltage as string.

    Returns:
        A normalize version of the input string.

    >>> voltage_normalize("7p5v")
    "7v500"

    >>> voltage_normalize("7v5")
    "7v500"

    >>> voltage_normalize("7.5v")
    "7v500"
    """
    return voltage_format(voltage_parse(s))

def voltage_parse(s):
    """Parse a voltage string like that produced by `voltage_format` function.

    Args:
        s: Voltage as string.

    Returns:
        A float version of the input string.

    >>> voltage_parse("7p5")
    7.5

    >>> voltage_parse("7p500")
    7.5

    >>> voltage_parse("0.75v")
    7.5

    >>> voltage_parse("0v75")
    7.5
    """
    s = s.lower().strip()

    if s.endswith("v"):
        s = s[:-1].replace(".", "p")
    if "v" in s:
        s = s.replace("v", "p")

    if "p" not in s:
        fail("No decimal point found in {}".format(s))

    s = s.replace("p", ".")

    return float(s)

def check_for_each_cells_args(kwargs, options):
    """Function for checking the arguments provided to a `for_each_XXX_cells` function are valid.

    Args:
        kwargs: Dictionary of keyword arguments provided to `for_each_XXX_cells` function.
        options: A `StandardCellOptionsInfo` for the PDK.
    """
    #if isinstance(options, StandardCellOptionsInfo):
    #    fail("options should be a `StandardCellOptionsInfo` object.")

    if kwargs["libname"] not in options.libraries:
        fail("Invalid library name: " + kwargs["libname"])

    # Validate the provided voltage threadholds
    if kwargs["include_vts"] in ("all", None):
        kwargs["include_vts"] = options.vts

    for vt in kwargs["include_vts"]:
        if vt not in options.vts:
            fail("Invalid vt: {} (from {})".format(vt, kwargs["include_vts"]))

    # Valid the provided corners
    if kwargs["include_corners"] in ("all", None):
        kwargs["include_corners"] = options.corners

    for corner in kwargs["include_corners"]:
        if corner not in options.corners:
            fail("Invalid corner: {} (from {})".format(corner, kwargs["include_corners"]))

    # Validate and normalize the provided volts values
    if kwargs["include_volts"] in ("all", None):
        kwargs["include_volts"] = list(options.volts)

    for i, voltage in enumerate(kwargs["include_volts"]):
        kwargs["include_volts"][i] = voltage_normalize(voltage)

    for voltage in kwargs["include_volts"]:
        if voltage not in options.volts:
            fail("Invalid volts: {} (from {})".format(voltage, kwargs["include_volts"]))

    # Validate and normalize the provided temperature values
    if kwargs["include_temps"] in ("all", None):
        kwargs["include_temps"] = list(options.temps)

    for i, temp in enumerate(kwargs["include_temps"]):
        kwargs["include_temps"][i] = temp_normalize(temp)

    for temp in kwargs["include_temps"]:
        if temp not in options.temps:
            fail("Invalid temp: {} (from {})".format(temp, kwargs["include_temps"]))
