load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")

def map(func, iterable):
    result = []
    for item in iterable:
        result.append(func(item))
    return result

def set(iterable):
    result = []
    for item in iterable:
        if item not in result:
            result = result + [item.strip()]
    return result

def build_openroad(
    name,
    verilog_files = [],
    synth_sources = [],
    macros = [],
    synth_args = [],
    io_constraints = "io.tcl",
    stage_args={},
    mock_abstract=False,
    mock_stage=3
):
    source_folder_name = name

    output_folder_name = source_folder_name

    all_sources = [
        "orfs",
        "private.mk",
        "config.mk",
        "settings.mk"
    ]

    macro_targets = map(lambda m: ":" + m + "_generate_abstract", macros)

    ADDITIONAL_LEFS = ' '.join(map(lambda m: '$(RULEDIR)/build/results/asap7/%s/base/%s.lef' % (m, m), macros))
    ADDITIONAL_LIBS = ' '.join(map(lambda m: '$(RULEDIR)/build/results/asap7/%s/base/%s.lib' % (m, m), macros))
    ADDITIONAL_GDS_FILES = ' '.join(map(lambda m: '$(RULEDIR)/build/results/asap7/%s/base/6_final.gds' % (m), macros))
    macro_config = [
        "'ADDITIONAL_LEFS=" + ADDITIONAL_LEFS + "'",
        "'ADDITIONAL_LIBS=" + ADDITIONAL_LIBS + "'",
        "'ADDITIONAL_GDS_FILES=" + ADDITIONAL_GDS_FILES + "'"] if len(macros) > 0 else []

    base_args = ["DESIGN_NAME=" + name,
    "WORK_HOME=$(RULEDIR)/build", "PRIVATE_DIR=."]

    run_binary(
        name = "%s_synth" %(name),
        tool = ":orfs",
        srcs = macro_targets + synth_sources + all_sources + set(verilog_files),
        args = ["make"] + base_args + [
            "'VERILOG_FILES=" + ' '.join(set(verilog_files)) + "'"] + synth_args +
            ["bazel-synth"] + macro_config,
        outs = [
            "build/results/asap7/%s/base/1_synth.v" %(output_folder_name),
            "build/results/asap7/%s/base/1_synth.sdc" %(output_folder_name)
        ]
    )

    all_stages = ([(1, 'synth'), (2, 'floorplan'), (3, 'place'),
    (4, 'cts'), (5, 'route'), (6, 'final'), (7, 'generate_abstract')])
    stages = [stage for stage in all_stages if not mock_abstract or (stage[0] <= mock_stage or stage[0] >= 7)]
    abstract_source = str(mock_stage) + "_" + all_stages[mock_stage - 1][1]

    reports ={'synth': ['1_1_yosys'],
    'floorplan': ['2_1_floorplan',
        '2_2_floorplan_io',
        '2_3_floorplan_tdms',
        '2_4_floorplan_macro',
        '2_5_floorplan_tapcell',
        '2_6_floorplan_pdn'],
    'place': ['3_1_place_gp_skip_io',
        '3_2_place_iop',
        '3_3_place_gp',
        '3_4_place_resized',
        '3_5_place_dp'],
    'cts': ['4_1_cts'],
    'route': ['5_1_grt',
        '5_2_fillcell',
        '5_3_route'],
    'final': ['6_1_merge',
     '6_report'],
    'generate_abstract': ['generate_abstract']
    }

    [run_binary(
        name = name + "_" + stage,
        tool = ":orfs",
        srcs = macro_targets + all_sources + [name + "_" + previous] +
        (['util.tcl', io_constraints] if io_constraints != None else []),
        args = ["make"] +
        base_args +
             ["bazel-" + stage, "elapsed"] +
         macro_config + (["GND_NETS_VOLTAGES=\"\"",
                            "PWR_NETS_VOLTAGES=\"\""] if stage == "generate_abstract"
                            else []) +
                            (["IO_CONSTRAINTS=" + io_constraints] if io_constraints != None else []) +
        (['ABSTRACT_SOURCE=' + abstract_source] if mock_abstract and i == 7 else []) +
        (['WRITE_ON_FAIL=1'] if stage in ("place", "route") else []) +
        stage_args.get(stage, []) +
        (['GDS_ALLOW_EMPTY="(' + '|'.join(macros) + ')"'] if stage in ("final") and len(macros) > 0 else []) +
        ([] if len(macros) == 0 else ['MIN_ROUTING_LAYER=M2',
        'MAX_ROUTING_LAYER=M9',
        'PDN_TCL=$$(PLATFORM_DIR)/openRoad/pdn/BLOCKS_grid_strategy.tcl']) +       
        ([] if any(map(lambda a: a.startswith('SDC_FILE'), stage_args.get('synth', [])))
          else ['SDC_FILE=constraints.sdc']),
        outs = ([
            "build/results/asap7/%s/base/%s.lib" %(output_folder_name, name),
            "build/results/asap7/%s/base/%s.lef" %(output_folder_name, name),
        ] if stage == "generate_abstract" else [
            "build/results/asap7/%s/base/%s.sdc" %(output_folder_name, str(i) + "_" + stage),
            "build/results/asap7/%s/base/%s.odb" %(output_folder_name, str(i) + "_" + stage),
        ]) + ([
            "build/results/asap7/%s/base/6_final.spef" %(output_folder_name),
            "build/results/asap7/%s/base/6_final.gds" %(output_folder_name)
        ] if stage == "final" else []) +
        (["build/results/asap7/%s/base/%s.ok" %(output_folder_name, stage)] if stage in ("place", "route") else []) +
        ([
            "build/reports/asap7/%s/base/congestion.rpt" %(output_folder_name),
            "build/reports/asap7/%s/base/5_route_drc.rpt" %(output_folder_name)
        ] if stage == "route" else []) +
        list(map(lambda log: "build/logs/asap7/%s/base/%s.log" %(output_folder_name, log), reports[stage]))
    ) for ((j, previous), (i, stage)) in zip(stages, stages[1:])]
