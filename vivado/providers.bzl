"""Describe Vivado providers."""

VivadoSynthCheckpointInfo = provider(
    doc = "Contains information at output of synthesis.",
    fields = {
        "checkpoint": "A vivado checkpoint.",
    },
)

VivadoPlacementCheckpointInfo = provider(
    doc = "Contains information at output of placement.",
    fields = {
        "checkpoint": "A vivado checkpoint.",
    },
)

VivadoRoutingCheckpointInfo = provider(
    doc = "Contains information at output of routing.",
    fields = {
        "checkpoint": "A vivado checkpoint.",
    },
)

VivadoIPBlockInfo = provider(
    doc = "Info for a vivado ip block",
    fields = {
        "repo": "Repo containing ip block.",
    },
)
