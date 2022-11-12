
if { [info exist ::env(MAGIC_EXT_USE_GDS)] && $::env(MAGIC_EXT_USE_GDS) } {
	gds read $::env(CURRENT_GDS)
} else {
	lef read /home/shahid/OSPDKs/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
	if {  [info exist ::env(EXTRA_LEFS)] } {
		set lefs_in $::env(EXTRA_LEFS)
		foreach lef_file $lefs_in {
			lef read $lef_file
		}
	}
	def read /home/shahid/caravel_user_project1/openlane/user_project_wrapper/runs/user_project_wrapper/results/routing/22-user_project_wrapper.def
}
load user_project_wrapper -dereference
cd /home/shahid/caravel_user_project1/openlane/user_project_wrapper/runs/user_project_wrapper/results/magic/
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
if { ! 0 } {
	extract unique
}
# extract warn all
extract

ext2spice lvs
ext2spice -o /home/shahid/caravel_user_project1/openlane/user_project_wrapper/runs/user_project_wrapper/results/magic/user_project_wrapper.spice user_project_wrapper.ext
feedback save /home/shahid/caravel_user_project1/openlane/user_project_wrapper/runs/user_project_wrapper/logs/magic/38-magic_ext2spice.feedback.txt
# exec cp user_project_wrapper.spice /home/shahid/caravel_user_project1/openlane/user_project_wrapper/runs/user_project_wrapper/results/magic/user_project_wrapper.spice

