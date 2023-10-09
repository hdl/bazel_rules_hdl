# PDKs (Process Design Kits)

The current PDKs supported by `bazel_rules_hdl` are;
 * [SkyWater 130nm](../dependency_support/com_google_skywater_pdk/)
 * [ASAP7](../dependency_support/org_theopenroadproject_asap7/)

## Adding new PDK

Adding a new PDK involves 3 things;

 1) Adding PDK repository to the `../dependency_support` directory which
    exports the required files via `filegroup` build rules.

 2) Adding `open_road_pdk_configuration` `BUILD` rule(s).

 3) Adding basic tests that confirm the PDK is usable.
  (a) Add synthesis test under `//synthesis/tests`
  (b) Add flow test under `//flows/tests`

### File groups

File groups should be grouped by file usage.

Some groups which might be created are;
 * Simulation
   * `v_XXX` - Verilog models for digital simulation (& logical equivalence).
   * `spice_XXX` - Analog models for spice simulation.

 * Digital place and route
   * `lef_XXX` - Components in LEF format.
   * `lef_tech` - Additional misc LEF cells which are needed for place and route.
   * `lib_XXXX` (or `libgz_XXXX`) - Timing information in (compressed) Liberty
     format (used for synthesis and static timing analysis STA).

 * `gds_XXX` - Actual layouts used for GDS generation and potentially
   parasitics extraction.

 * `lvs_XXX` - Logic verse Schematic (LVS) checking.

`XXX` can be;
 * `cells` - Standard cells
 * `sram` - SRAM blocks


### Cell Library Naming

Cell library naming should be;
 * `<process name>-<cell library name>-<corner>` - examples include;
    * `asap7-rvt-tt`
       * `asap7`: ASAP 7nm predictive PDK.
       * `sc7p5t` : 7.5 track standard cells
       * `tt`: Typical corner.
    * `sky130-hdll-ff_025C_1v50`
       * `sky130`: SkyWater 130nm process technology.
       * `hdll`: High density, low leakage standard cells.
       * `ff_025C_1v50` : Fast corner at 25 degrees C and 1.5 volts.
