# execute initial scripts for variables
source  ../../setup/main_setup.tcl
source  ${SetupDir}/design_setup.tcl


# make library of the project
create_lib ${ResultsDir}/${DesignLibrary} -technology $TechFile -ref_libs ${RefLib}
# report_ref_libs


# analyze model
analyze -format sverilog [glob ${SystemVerilogDir}/*.svh]
analyze -format sverilog [glob ${SystemVerilogDir}/*.sv]


# elaborate the whole project
elaborate ${DesignName}


# make project block
set_top_module ${DesignName}

source -echo ${SetupDir}/technology_setup.tcl
source -echo ${SetupDir}/mcmm_setup.tcl

read_sdc -echo ${SdcFile}
set_lib_cell_purpose -include none {*/*_AO21* */*V2LP*}
set_app_options -name place.coarse.continue_on_missing_scandef -value true

compile_fusion -check_only

# generate raports
set StageName initial_map
compile_fusion -to initial_map
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}



set StageName logic_opto
compile_fusion -from logic_opto -to logic_opto
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}

set StageName initial_place
compile_fusion -from initial_place -to initial_place
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}

set StageName initial_drc
compile_fusion -from initial_drc -to initial_drc
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}

set StageName initial_opto
compile_fusion -from initial_opto -to initial_opto
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}

set StageName final_place
compile_fusion -from final_place -to final_place
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}

set StageName final_opto
compile_fusion -from final_opto -to final_opto
redirect -file ${ReportsDir}/${StageName}_report_power.rpt\
{report_power -scenarios Normal_Typical}
redirect -file ${ReportsDir}/${StageName}_report_timing_setup.rpt \
{report_timing -scenarios Normal_Typical -delay_type max}
redirect -file ${ReportsDir}/${StageName}_report_timing_hold.rpt \
{report_timing -scenarios Normal_Typical -delay_type min}
redirect -file ${ReportsDir}/${StageName}_report_area.rpt {report_area}
redirect -file ${ReportsDir}/${StageName}_report_qor.rpt {report_qor}
redirect -file ${ReportsDir}/${StageName}_report_design.rpt {report_design}

# # check legality, save block and close
# check_legality
# save_block
# save_lib
# close_blocks
# close_lib