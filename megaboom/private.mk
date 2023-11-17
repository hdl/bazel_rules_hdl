.PHONY: bazel-synth
bazel-synth:
	$(UNSET_AND_MAKE) synth

.PHONY: bazel-floorplan
bazel-floorplan:
	mkdir -p $(LOG_DIR)
	touch $(LOG_DIR)/2_3_floorplan_tdms.log
	$(UNSET_AND_MAKE) do-floorplan

# This target does not produce a non-zero exit code if detailed or global
# placement fails. In this case $(RESULTS_DIR)/3_place.odb and $(RESULTS_DIR)/3_place.sdc
# are produced, such that an artifact can be created for inspection purposes.
#
# The check-place target subsequently will fail if
# placement did not complete successfully, because $(RESULTS_DIR)/place.ok
# is set to 0.
#
# This means that build systems, such as Bazel, that require a non-zero
# exit code and the same artifacts to be produced every time, or it
# will not publish the artifacts, can use this target.
.PHONY: bazel-place
bazel-place:
	mkdir -p $(LOG_DIR) $(REPORTS_DIR)
	touch $(LOG_DIR)/3_1_place_gp_skip_io.log
	touch $(LOG_DIR)/3_2_place_iop.log
	touch $(LOG_DIR)/3_3_place_gp.log
	touch $(LOG_DIR)/3_4_place_resized.log
	touch $(LOG_DIR)/3_5_place_dp.log
	echo >$(RESULTS_DIR)/place.ok 0
	$(UNSET_AND_MAKE) do-3_1_place_gp_skip_io do-3_2_place_iop
	@$(UNSET_VARS); \
	$(SUB_MAKE) do-3_3_place_gp; \
	if [ $$? -ne 0 ]; then \
		cp $(RESULTS_DIR)/3_3_place_gp-failed.odb $(RESULTS_DIR)/3_place.odb ; \
		$(SUB_MAKE) do-3_place.sdc ; \
	else \
		$(SUB_MAKE) do-3_4_place_resized ; \
		$(SUB_MAKE) do-3_5_place_dp ; \
		if [ $$? -ne 0 ]; then \
			cp $(RESULTS_DIR)/3_5_place_dp-failed.odb $(RESULTS_DIR)/3_place.odb ; \
			$(SUB_MAKE) do-3_place.sdc ; \
		else \
			$(SUB_MAKE) do-3_place do-3_place.sdc ; \
			echo >$(RESULTS_DIR)/place.ok 1 ; \
		fi ; \
	fi

.PHONY: check-place
check-place:
	grep -q 1 $(RESULTS_DIR)/place.ok

.PHONY: bazel-cts
bazel-cts:
	$(UNSET_AND_MAKE) check-place do-cts

# Same as do-place, support for build systems that require a non-zero exit code
# and the same artifacts to be produced every time or no artifacts are published
.PHONY: bazel-route
bazel-route:
	mkdir -p $(RESULTS_DIR) $(LOG_DIR) $(REPORTS_DIR)
	mkdir -p $(RESULTS_DIR) $(LOG_DIR) $(REPORTS_DIR)
	echo >$(RESULTS_DIR)/route.ok 0
	touch $(REPORTS_DIR)/congestion.rpt
	touch $(REPORTS_DIR)/5_route_drc.rpt
	touch $(LOG_DIR)/5_1_grt.log
	touch $(LOG_DIR)/5_2_fillcell.log
	touch $(LOG_DIR)/5_3_route.log
	@$(UNSET_VARS); \
	$(SUB_MAKE) do-5_1_grt ; \
	if [ $$? -ne 0 ]; then \
		cp $(RESULTS_DIR)/5_1_grt-failed.odb $(RESULTS_DIR)/5_route.odb ; \
		$(SUB_MAKE) do-5_route.sdc ; \
	else \
		$(SUB_MAKE) do-5_2_fillcell do-5_3_route do-5_route.sdc do-5_route ; \
		echo >$(RESULTS_DIR)/route.ok 1 ; \
	fi

.PHONY: check-route
check-route:
	grep -q 1 $(RESULTS_DIR)/route.ok

.PHONY: bazel-final
bazel-final:
	$(UNSET_AND_MAKE) check-route do-final

.PHONY: bazel-generate_abstract
bazel-generate_abstract:
	$(UNSET_AND_MAKE) do-generate_abstract

