"""Rules for synthesizing (System)Verilog code."""

load(
    ":build_defs.bzl",
    _ExternalSynthesisInfo = "ExternalSynthesisInfo",
    _SdcInfo = "SdcInfo",
    _SynthesisInfo = "SynthesisInfo",
    _UhdmInfo = "UhdmInfo",
    _benchmark_synth = "benchmark_synth",
    _sdc_library = "sdc_library",
    _synthesis_binary = "synthesis_binary",
    _synthesize_rtl = "synthesize_rtl",
)

benchmark_synth = _benchmark_synth
ExternalSynthesisInfo = _ExternalSynthesisInfo
synthesis_binary = _synthesis_binary
SynthesisInfo = _SynthesisInfo
synthesize_rtl = _synthesize_rtl
UhdmInfo = _UhdmInfo
SdcInfo = _SdcInfo
sdc_library = _sdc_library
