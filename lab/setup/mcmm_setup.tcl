#####################################################################
#####						MCMM Setup Script					#####
#####################################################################

# Remove all MCMM related info
remove_corners -all
remove_modes -all
remove_scenarios -all

# Create Corner(s)

create_corner Typical 

# Set parasitics parameters
set_parasitics_parameters -early_spec nomTLU -late_spec nomTLU -corners {Typical}
# Create Mode
create_mode Normal
current_mode Normal
# Create Scenario(s)
create_scenario -mode Normal -corner Typical -name Normal_Typical
current_corner Typical
current_scenario Normal_Typical
set_operating_conditions ${PVT_TT}

# Set operating conditions for the corner and scenario

