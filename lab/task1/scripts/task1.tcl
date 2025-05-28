source -echo ../../setup/main_setup.tcl
source -echo ${SetupDir}/design_setup.tcl

create_lib ${ResultsDir}/${DesignLibrary} -technology $TechFile -ref_libs ${RefLib}

report_ref_libs

analyze -format sverilog [glob ${SystemVerilogDir}/*.svh]
analyze -format sverilog [glob ${SystemVerilogDir}/*.sv]

elaborate ${DesignName}
set_top_module ${DesignName}

save_block -as ${DesignName}/rtl_read

compile_fusion -to initial_map

report_timing
report_power
report_area

write_verilog ${ResultsDir}/${DesignName}_initial_synthesis.v

# Cleanup before next step
current_block 
save_block 
save_block -as ${DesignName}/inital_synthesis 
 
get_blocks -all 
list_blocks 
 
save_lib 
# Part 2 

copy_block -from ${DesignName}/rtl_read -to ${DesignName}/compile_flow
open_block ${DesignName}/compile_flow

source -echo ${SetupDir}/technology_setup.tcl
read_sdc -echo ${SdcFile}
source -echo ${SetupDir}/mcmm_setup.tcl

set_lib_cell_purpose -include none {*/*_AO21* */*V2LP*}

set_app_options -name place.coarse.continue_on_missing_scandef -value true 

compile_fusion -check_only

compile_fusion -to initial_map
# echo "Generating reports for the stage: initial_map"
redirect -file ${ReportsDir}/initial_map_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/initial_map_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/initial_map_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/initial_map_report_area.rpt {report_area}
redirect -file ${ReportsDir}/initial_map_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/initial_map_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  initial_map"

compile_fusion -from logic_opto -to logic_opto

# echo "Generating reports for the stage: logic_opto"
redirect -file ${ReportsDir}/logic_opto_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/logic_opto_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/logic_opto_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/logic_opto_report_area.rpt {report_area}
redirect -file ${ReportsDir}/logic_opto_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/logic_opto_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  logic_opto"

compile_fusion -from initial_place -to initial_place

# echo "Generating reports for the stage: initial_place"
redirect -file ${ReportsDir}/initial_place_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/initial_place_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/initial_place_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/initial_place_report_area.rpt {report_area}
redirect -file ${ReportsDir}/initial_place_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/initial_place_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  initial_place"

compile_fusion -from initial_drc -to initial_drc

# echo "Generating reports for the stage: initial_drc"
redirect -file ${ReportsDir}/initial_drc_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/initial_drc_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/initial_drc_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/initial_drc_report_area.rpt {report_area}
redirect -file ${ReportsDir}/initial_drc_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/initial_drc_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  initial_drc"

compile_fusion -from initial_opto -to initial_opto

# echo "Generating reports for the stage: initial_opto"
redirect -file ${ReportsDir}/initial_opto_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/initial_opto_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/initial_opto_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/initial_opto_report_area.rpt {report_area}
redirect -file ${ReportsDir}/initial_opto_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/initial_opto_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  initial_opto"

compile_fusion -from final_place -to final_place

# echo "Generating reports for the stage: final_place"
redirect -file ${ReportsDir}/final_place_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/final_place_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/final_place_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/final_place_report_area.rpt {report_area}
redirect -file ${ReportsDir}/final_place_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/final_place_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  final_place"

compile_fusion -from final_opto -to final_opto

# echo "Generating reports for the stage: final_opto"
redirect -file ${ReportsDir}/final_opto_report_power.rpt {report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/final_opto_report_timing_setup.rpt {report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/final_opto_report_timing_hold.rpt {report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/final_opto_report_area.rpt {report_area}
redirect -file ${ReportsDir}/final_opto_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/final_opto_report_design.rpt {report_design}
# echo "Reports have been generated for the stage:  final_opto"