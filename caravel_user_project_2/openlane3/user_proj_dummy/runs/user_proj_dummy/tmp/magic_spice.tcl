
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
	def read /home/shahid/caravel_user_project/openlane/user_proj_dummy/runs/user_proj_dummy/results/routing/20-user_proj_dummy.def
}
load user_proj_dummy -dereference
cd /home/shahid/caravel_user_project/openlane/user_proj_dummy/runs/user_proj_dummy/results/magic/
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
ext2spice -o /home/shahid/caravel_user_project/openlane/user_proj_dummy/runs/user_proj_dummy/results/magic/user_proj_dummy.spice user_proj_dummy.ext
feedback save /home/shahid/caravel_user_project/openlane/user_proj_dummy/runs/user_proj_dummy/logs/magic/36-magic_ext2spice.feedback.txt
# exec cp user_proj_dummy.spice /home/shahid/caravel_user_project/openlane/user_proj_dummy/runs/user_proj_dummy/results/magic/user_proj_dummy.spice

