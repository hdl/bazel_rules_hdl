# Hmmm.... PLATFORM can't be passed on the command line as "make PLATFORM=asap7", because
# include of the platform config.mk doesn't see PLATFORM=aspa7.
export PLATFORM=asap7

export WORK_HOME_READ?=$(WORK_HOME)

# Some default values
export CORE_UTILIZATION       ?= 40
export CORE_ASPECT_RATIO      ?= 1
export CORE_MARGIN            ?= 2
export PLACE_DENSITY          ?= 0.30

include bazel.mk
