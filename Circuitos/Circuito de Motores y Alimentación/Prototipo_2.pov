//POVRay-File created by 3d41.ulp v20110101
//C:/Users/Yoshua/Documents/eagle/CircuitoMA_Tesis/Prototipo_2.brd
//03-06-2014 01:59:24 a.m.

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 387;
#local cam_z = -206;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -9;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 100;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 34;
#local lgt1_pos_y = 51;
#local lgt1_pos_z = 47;
#local lgt1_intense = 0.815714;
#local lgt2_pos_x = -34;
#local lgt2_pos_y = 51;
#local lgt2_pos_z = 47;
#local lgt2_intense = 0.815714;
#local lgt3_pos_x = 34;
#local lgt3_pos_y = 51;
#local lgt3_pos_z = -32;
#local lgt3_intense = 0.815714;
#local lgt4_pos_x = -34;
#local lgt4_pos_y = 51;
#local lgt4_pos_z = -32;
#local lgt4_intense = 0.815714;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 90.000000;
#declare pcb_y_size = 90.000000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(873);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-45.000000,0,-45.000000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro PROTOTIPO_2(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><90.000000,0.000000>
<90.000000,0.000000><90.000000,90.000000>
<90.000000,90.000000><0.000000,90.000000>
<0.000000,90.000000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<8.474000,1,70.880000><8.474000,-5,70.880000>1.651000 texture{col_hls}}
cylinder{<82.320000,1,19.934000><82.320000,-5,19.934000>1.651000 texture{col_hls}}
cylinder{<61.020000,1,19.934000><61.020000,-5,19.934000>1.651000 texture{col_hls}}
cylinder{<38.720000,1,19.934000><38.720000,-5,19.934000>1.651000 texture{col_hls}}
cylinder{<16.420000,1,19.934000><16.420000,-5,19.934000>1.651000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
cylinder{<8.040000,0.095000,9.040000><8.040000,-1.595000,9.040000>1.905000 texture{col_hls}}
cylinder{<84.660000,0.095000,9.040000><84.660000,-1.595000,9.040000>1.905000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_ARDUINO) #declare global_pack_ARDUINO=yes; object {CON_PHW_1X8()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<66.000000,0.000000,82.000000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) ARDUINO  1X08/90
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_50MM_76MM("0,33uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<22.830000,0.000000,81.960000>}#end		//ceramic disc capacitator C1 0,33uF C050-030X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_50MM_76MM("0,1uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<10.280000,0.000000,82.040000>}#end		//ceramic disc capacitator C2 0,1uF C050-030X075
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<72.850000,0.000000,27.140000>}#end		//Diode DO201 15mm hor. D1 RGP30 DO201-15
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<51.850000,0.000000,26.820000>}#end		//Diode DO201 15mm hor. D2 RGP30 DO201-15
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<7.150000,0.000000,26.500000>}#end		//Diode DO201 15mm hor. D3 RGP30 DO201-15
#ifndef(pack_D4) #declare global_pack_D4=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.040000,0.000000,26.860000>}#end		//Diode DO201 15mm hor. D4 RGP30 DO201-15
#ifndef(pack_LM7809) #declare global_pack_LM7809=yes; object {TR_TO220_3_H2("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<19.650000,0.000000,70.880000>}#end		//TO220 horizontal straight leads LM7809  78XXL
#ifndef(pack_MOTORES) #declare global_pack_MOTORES=yes; object {CON_PHW_1X8()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<42.130000,0.000000,8.280000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) MOTORES  1X08/90
#ifndef(pack_OK1) #declare global_pack_OK1=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<78.780000,0.000000,61.250000>}#end		//DIP6 OK1 4N26M DIL06
#ifndef(pack_OK2) #declare global_pack_OK2=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<62.940000,0.000000,62.250000>}#end		//DIP6 OK2 4N26M DIL06
#ifndef(pack_OK3) #declare global_pack_OK3=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<47.100000,0.000000,62.250000>}#end		//DIP6 OK3 4N26M DIL06
#ifndef(pack_OK4) #declare global_pack_OK4=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<31.260000,0.000000,62.250000>}#end		//DIP6 OK4 4N26M DIL06
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<82.320000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q1 IRLZ44Z TO220BH
#ifndef(pack_Q2) #declare global_pack_Q2=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<61.020000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q2 IRLZ44Z TO220BH
#ifndef(pack_Q3) #declare global_pack_Q3=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<38.720000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q3 IRLZ44Z TO220BH
#ifndef(pack_Q4) #declare global_pack_Q4=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<16.420000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q4 IRLZ44Z TO220BH
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<75.000000,0.000000,47.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 10kOhm 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<59.610000,0.000000,47.470000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 10kOhm 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<43.610000,0.000000,47.310000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 10kOhm 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<28.000000,0.000000,47.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 10kOhm 0207/7
#ifndef(pack_XBEE) #declare global_pack_XBEE=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<42.850000,0.000000,82.230000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) XBEE  1X04
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack__11_1V__BATERIA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(6.197600,3.810000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<84.660000,0,9.040000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.110000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.650000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.190000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.730000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.270000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<69.810000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.350000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<74.890000,0,78.190000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.370000,0,81.960000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<20.290000,0,81.960000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<7.740000,0,82.040000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.820000,0,82.040000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.850000,0,34.760000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.850000,0,19.520000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<51.850000,0,34.440000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<51.850000,0,19.200000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<7.150000,0,18.880000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<7.150000,0,34.120000> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<30.040000,0,19.240000> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<30.040000,0,34.480000> texture{col_thl}}
#ifndef(global_pack_GND__BATERIA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(6.197600,3.810000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<8.040000,0,9.040000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<23.460000,0,70.880000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<23.460000,0,68.340000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<23.460000,0,73.420000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<51.020000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<48.480000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<45.940000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<43.400000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<40.860000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<38.320000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<35.780000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<33.240000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<81.320000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<78.780000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<76.240000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<76.240000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<78.780000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<81.320000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<65.480000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<62.940000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<60.400000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<60.400000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<62.940000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<65.480000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<49.640000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<47.100000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<44.560000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<44.560000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<47.100000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<49.640000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<33.800000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<31.260000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<28.720000,0,66.060000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<28.720000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<31.260000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<33.800000,0,58.440000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<8.340000,0,56.950000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<8.340000,0,59.490000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<82.320000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<84.860000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<79.780000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<61.020000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<63.560000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<58.480000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<38.720000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<41.260000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<36.180000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<16.420000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<18.960000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<13.880000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<75.000000,0,43.190000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<75.000000,0,50.810000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<59.610000,0,43.660000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<59.610000,0,51.280000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<43.610000,0,43.500000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<43.610000,0,51.120000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<28.000000,0,43.190000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<28.000000,0,50.810000> texture{col_thl}}
#ifndef(global_pack_RX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<42.660000,0,74.400000> texture{col_thl}}
#ifndef(global_pack_RX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<42.660000,0,71.860000> texture{col_thl}}
#ifndef(global_pack_TX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<36.660000,0,74.750000> texture{col_thl}}
#ifndef(global_pack_TX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<36.660000,0,72.210000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.508000,1.000000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<9.550000,0,47.500000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.508000,1.000000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<9.550000,0,50.040000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<46.660000,0,82.230000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<44.120000,0,82.230000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<41.580000,0,82.230000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<39.040000,0,82.230000> texture{col_thl}}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.040000,-1.535000,9.040000>}
box{<0,0,-0.127000><1.196161,0.035000,0.127000> rotate<0,69.439372,0> translate<7.620000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.620000,-1.535000,10.160000> }
}cylinder{<8.040000,1,9.040000><8.040000,-2.500000,9.040000>1.905000 texture{col_thl}}}
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<83.820000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.660000,-1.535000,9.040000>}
box{<0,0,-0.127000><0.853288,0.035000,0.127000> rotate<0,-10.124003,0> translate<83.820000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<83.820000,-1.535000,8.890000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<80.010000,-1.535000,12.700000> }
}cylinder{<84.660000,1,9.040000><84.660000,-2.500000,9.040000>1.905000 texture{col_thl}}}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,16.510000>}
box{<0,0,-0.127000><25.400000,0.035000,0.127000> rotate<0,-90.000000,0> translate<3.810000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,20.320000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<5.080000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.080000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,33.020000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,90.000000,0> translate<6.350000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.150000,-1.535000,34.120000>}
box{<0,0,-0.127000><1.360147,0.035000,0.127000> rotate<0,-53.969065,0> translate<6.350000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,12.700000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<3.810000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.150000,-1.535000,18.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,17.780000>}
box{<0,0,-0.127000><1.196202,0.035000,0.127000> rotate<0,66.859890,0> translate<7.150000,-1.535000,18.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.150000,-1.535000,34.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,33.020000>}
box{<0,0,-0.127000><1.196202,0.035000,0.127000> rotate<0,66.859890,0> translate<7.150000,-1.535000,34.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.740000,-1.535000,82.040000>}
box{<0,0,-0.127000><0.523927,0.035000,0.127000> rotate<0,76.754414,0> translate<7.620000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,12.700000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<5.080000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,46.990000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<3.810000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.340000,-1.535000,56.950000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,57.150000>}
box{<0,0,-0.127000><0.585235,0.035000,0.127000> rotate<0,-19.981788,0> translate<8.340000,-1.535000,56.950000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,57.150000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,90.000000,0> translate<8.890000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.340000,-1.535000,59.490000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,59.690000>}
box{<0,0,-0.127000><0.585235,0.035000,0.127000> rotate<0,-19.981788,0> translate<8.340000,-1.535000,59.490000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550000,-1.535000,47.500000>}
box{<0,0,-0.127000><0.834086,0.035000,0.127000> rotate<0,-37.691753,0> translate<8.890000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550000,-1.535000,50.040000>}
box{<0,0,-0.127000><0.834086,0.035000,0.127000> rotate<0,-37.691753,0> translate<8.890000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,33.020000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<7.620000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550000,-1.535000,47.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,46.990000>}
box{<0,0,-0.127000><0.795110,0.035000,0.127000> rotate<0,39.895202,0> translate<9.550000,-1.535000,47.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,17.780000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<7.620000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,35.560000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<12.700000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,46.990000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.160000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.820000,-1.535000,82.040000>}
box{<0,0,-0.127000><0.523927,0.035000,0.127000> rotate<0,76.754414,0> translate<12.700000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,34.290000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<12.700000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.880000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.636396,0.035000,0.127000> rotate<0,81.864495,0> translate<13.880000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,40.640000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<12.700000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,12.700000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<8.890000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,34.290000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,34.290000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<13.970000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.420000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.646297,0.035000,0.127000> rotate<0,-81.989860,0> translate<16.420000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,34.290000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.510000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.960000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.646297,0.035000,0.127000> rotate<0,-81.989860,0> translate<18.960000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,40.640000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,40.640000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.510000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,71.120000>}
box{<0,0,-0.127000><16.164461,0.035000,0.127000> rotate<0,44.997030,0> translate<7.620000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,7.620000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<15.240000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,8.890000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,44.997030,0> translate<11.430000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,40.640000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.050000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,71.120000>}
box{<0,0,-0.127000><16.164461,0.035000,0.127000> rotate<0,-44.997030,0> translate<8.890000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,71.120000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.050000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,82.550000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.700000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.290000,-1.535000,81.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,82.550000>}
box{<0,0,-0.127000><0.590762,0.035000,0.127000> rotate<0,-87.083415,0> translate<20.290000,-1.535000,81.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,82.550000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<20.320000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,55.880000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<12.700000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,69.850000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,90.000000,0> translate<21.590000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,71.120000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<21.590000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,73.660000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.320000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.460000,-1.535000,70.880000>}
box{<0,0,-0.127000><0.646220,0.035000,0.127000> rotate<0,21.799971,0> translate<22.860000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.460000,-1.535000,73.420000>}
box{<0,0,-0.127000><0.646220,0.035000,0.127000> rotate<0,21.799971,0> translate<22.860000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.460000,-1.535000,68.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,68.580000>}
box{<0,0,-0.127000><0.711688,0.035000,0.127000> rotate<0,-19.706678,0> translate<23.460000,-1.535000,68.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.460000,-1.535000,70.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,71.120000>}
box{<0,0,-0.127000><0.711688,0.035000,0.127000> rotate<0,-19.706678,0> translate<23.460000,-1.535000,70.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,72.390000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.130000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,74.930000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<20.320000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,74.930000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<25.400000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.370000,-1.535000,81.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,82.550000>}
box{<0,0,-0.127000><0.590762,0.035000,0.127000> rotate<0,-87.083415,0> translate<25.370000,-1.535000,81.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,82.550000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,90.000000,0> translate<25.400000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,71.120000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.130000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,74.930000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<25.400000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,74.930000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<26.670000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,43.180000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.050000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,50.800000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<27.940000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.000000,-1.535000,43.190000>}
box{<0,0,-0.127000><0.060828,0.035000,0.127000> rotate<0,-9.461698,0> translate<27.940000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.000000,-1.535000,50.810000>}
box{<0,0,-0.127000><0.060828,0.035000,0.127000> rotate<0,-9.461698,0> translate<27.940000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,20.320000>}
box{<0,0,-0.127000><19.756563,0.035000,0.127000> rotate<0,44.997030,0> translate<15.240000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.940000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.720000,-1.535000,58.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,58.420000>}
box{<0,0,-0.127000><0.490408,0.035000,0.127000> rotate<0,2.337152,0> translate<28.720000,-1.535000,58.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.040000,-1.535000,19.240000>}
box{<0,0,-0.127000><1.362094,0.035000,0.127000> rotate<0,52.453593,0> translate<29.210000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.040000,-1.535000,19.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,19.050000>}
box{<0,0,-0.127000><0.479270,0.035000,0.127000> rotate<0,23.354023,0> translate<30.040000,-1.535000,19.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.040000,-1.535000,34.480000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,34.290000>}
box{<0,0,-0.127000><0.479270,0.035000,0.127000> rotate<0,23.354023,0> translate<30.040000,-1.535000,34.480000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,43.180000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<27.940000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,43.180000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<30.480000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,59.690000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.210000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,64.770000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<21.590000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,11.430000>}
box{<0,0,-0.127000><30.532871,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<31.750000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,20.320000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,-90.000000,0> translate<31.750000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,33.020000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<30.480000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,52.070000>}
box{<0,0,-0.127000><16.164461,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.320000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.260000,-1.535000,58.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,58.420000>}
box{<0,0,-0.127000><0.490408,0.035000,0.127000> rotate<0,2.337152,0> translate<31.260000,-1.535000,58.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,58.420000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,90.000000,0> translate<31.750000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,64.770000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<30.480000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,66.040000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.260000,-1.535000,66.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,66.040000>}
box{<0,0,-0.127000><0.490408,0.035000,0.127000> rotate<0,2.337152,0> translate<31.260000,-1.535000,66.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.260000,-1.535000,66.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,67.310000>}
box{<0,0,-0.127000><1.342609,0.035000,0.127000> rotate<0,-68.590294,0> translate<31.260000,-1.535000,66.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,12.700000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<33.020000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,16.510000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<30.480000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,68.580000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<31.750000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.240000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<33.020000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,59.690000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<30.480000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.800000,-1.535000,66.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,66.040000>}
box{<0,0,-0.127000><0.490408,0.035000,0.127000> rotate<0,2.337152,0> translate<33.800000,-1.535000,66.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,8.890000>}
box{<0,0,-0.127000><15.240000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.290000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,12.700000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,16.510000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<31.750000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,38.100000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<30.480000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,54.610000>}
box{<0,0,-0.127000><23.348666,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.050000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,54.610000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<34.290000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.780000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.695701,0.035000,0.127000> rotate<0,-71.560328,0> translate<35.560000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.780000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<35.560000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.180000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.891067,0.035000,0.127000> rotate<0,45.906351,0> translate<35.560000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,7.620000>}
box{<0,0,-0.127000><16.510000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.660000,-1.535000,72.210000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,72.390000>}
box{<0,0,-0.127000><0.247588,0.035000,0.127000> rotate<0,-46.633499,0> translate<36.660000,-1.535000,72.210000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.660000,-1.535000,74.750000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,74.930000>}
box{<0,0,-0.127000><0.247588,0.035000,0.127000> rotate<0,-46.633499,0> translate<36.660000,-1.535000,74.750000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,74.930000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<36.830000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,82.550000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,0.000000,0> translate<25.400000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,11.430000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.320000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.695701,0.035000,0.127000> rotate<0,-71.560328,0> translate<38.100000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.320000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<38.100000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.720000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.883912,0.035000,0.127000> rotate<0,-45.455356,0> translate<38.100000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.720000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.912195,0.035000,0.127000> rotate<0,-44.552915,0> translate<38.720000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,55.880000>}
box{<0,0,-0.127000><17.780000,0.035000,0.127000> rotate<0,90.000000,0> translate<39.370000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,57.150000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,57.150000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,44.997030,0> translate<31.750000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,72.390000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<36.830000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,81.280000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<36.830000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.040000,-1.535000,82.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,81.280000>}
box{<0,0,-0.127000><1.005684,0.035000,0.127000> rotate<0,70.839712,0> translate<39.040000,-1.535000,82.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,11.430000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<36.830000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,86.360000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<36.830000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.860000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.695701,0.035000,0.127000> rotate<0,-71.560328,0> translate<40.640000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,10.160000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<40.640000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.260000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.912195,0.035000,0.127000> rotate<0,-44.552915,0> translate<41.260000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,38.100000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,-90.000000,0> translate<41.910000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,66.040000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<34.290000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,69.850000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<39.370000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.580000,-1.535000,82.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,81.280000>}
box{<0,0,-0.127000><1.005684,0.035000,0.127000> rotate<0,70.839712,0> translate<41.580000,-1.535000,82.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,12.700000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<43.180000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,17.780000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,17.780000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,-90.000000,0> translate<43.180000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,31.750000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<38.100000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,50.800000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.910000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,50.800000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<43.180000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,59.690000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,60.960000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,64.770000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<41.910000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.660000,-1.535000,71.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,72.390000>}
box{<0,0,-0.127000><0.742496,0.035000,0.127000> rotate<0,-45.542652,0> translate<42.660000,-1.535000,71.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.660000,-1.535000,74.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,74.930000>}
box{<0,0,-0.127000><0.742496,0.035000,0.127000> rotate<0,-45.542652,0> translate<42.660000,-1.535000,74.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,74.930000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<43.180000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,80.010000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<41.910000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.400000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<43.180000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.610000,-1.535000,43.500000>}
box{<0,0,-0.127000><0.536004,0.035000,0.127000> rotate<0,-36.653689,0> translate<43.180000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.610000,-1.535000,51.120000>}
box{<0,0,-0.127000><0.536004,0.035000,0.127000> rotate<0,-36.653689,0> translate<43.180000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<41.910000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.180000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.120000,-1.535000,82.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,82.550000>}
box{<0,0,-0.127000><0.459674,0.035000,0.127000> rotate<0,-44.115684,0> translate<44.120000,-1.535000,82.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.560000,-1.535000,58.440000>}
box{<0,0,-0.127000><0.111803,0.035000,0.127000> rotate<0,-10.304166,0> translate<44.450000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.450000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<45.720000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,59.690000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.180000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,68.580000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<33.020000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.940000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.695701,0.035000,0.127000> rotate<0,-71.560328,0> translate<45.720000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.940000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<45.720000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<45.720000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,67.310000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<45.720000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.660000,-1.535000,82.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,82.550000>}
box{<0,0,-0.127000><0.459674,0.035000,0.127000> rotate<0,-44.115684,0> translate<46.660000,-1.535000,82.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,85.090000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.450000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.100000,-1.535000,58.440000>}
box{<0,0,-0.127000><0.111803,0.035000,0.127000> rotate<0,-10.304166,0> translate<46.990000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.100000,-1.535000,66.060000>}
box{<0,0,-0.127000><1.254831,0.035000,0.127000> rotate<0,84.965319,0> translate<46.990000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,72.390000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.180000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.480000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<48.260000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,10.160000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<44.450000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,69.850000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<41.910000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.640000,-1.535000,66.060000>}
box{<0,0,-0.127000><1.254831,0.035000,0.127000> rotate<0,84.965319,0> translate<49.530000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<49.530000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,15.240000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<48.260000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,19.050000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<45.720000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,24.130000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.180000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,24.130000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<50.800000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,26.670000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,-90.000000,0> translate<50.800000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.020000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.695701,0.035000,0.127000> rotate<0,-71.560328,0> translate<50.800000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.020000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.648460,0.035000,0.127000> rotate<0,70.163239,0> translate<50.800000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.850000,-1.535000,19.200000>}
box{<0,0,-0.127000><1.060660,0.035000,0.127000> rotate<0,-8.129566,0> translate<50.800000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<51.850000,-1.535000,34.440000>}
box{<0,0,-0.127000><1.060660,0.035000,0.127000> rotate<0,-8.129566,0> translate<50.800000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,64.770000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.180000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,68.580000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.720000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,67.310000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<49.530000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,77.470000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,-44.997030,0> translate<49.530000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.110000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,77.470000>}
box{<0,0,-0.127000><0.721110,0.035000,0.127000> rotate<0,86.814440,0> translate<57.110000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,81.280000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<48.260000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,85.090000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.990000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,38.100000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<58.420000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,43.180000>}
box{<0,0,-0.127000><15.240000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.180000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,43.180000>}
box{<0,0,-0.127000><15.240000,0.035000,0.127000> rotate<0,-90.000000,0> translate<58.420000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,82.550000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.990000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.480000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.642806,0.035000,0.127000> rotate<0,84.638589,0> translate<58.420000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,43.180000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<58.420000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.610000,-1.535000,43.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,43.180000>}
box{<0,0,-0.127000><0.486621,0.035000,0.127000> rotate<0,80.532363,0> translate<59.610000,-1.535000,43.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.610000,-1.535000,51.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,50.800000>}
box{<0,0,-0.127000><0.486621,0.035000,0.127000> rotate<0,80.532363,0> translate<59.610000,-1.535000,51.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,50.800000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<59.690000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,78.740000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<57.150000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.650000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,78.740000>}
box{<0,0,-0.127000><0.551453,0.035000,0.127000> rotate<0,-85.834693,0> translate<59.650000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,36.830000>}
box{<0,0,-0.127000><14.368410,0.035000,0.127000> rotate<0,-44.997030,0> translate<50.800000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,39.370000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<60.960000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<59.690000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.400000,-1.535000,58.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,58.420000>}
box{<0,0,-0.127000><0.560357,0.035000,0.127000> rotate<0,2.045273,0> translate<60.400000,-1.535000,58.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,60.960000>}
box{<0,0,-0.127000><17.780000,0.035000,0.127000> rotate<0,0.000000,0> translate<43.180000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,60.960000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<58.420000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,73.660000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<55.880000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,82.550000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,80.010000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<58.420000,-1.535000,82.550000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,80.010000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,90.000000,0> translate<60.960000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.020000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.632851,0.035000,0.127000> rotate<0,-84.554087,0> translate<60.960000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.020000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.642806,0.035000,0.127000> rotate<0,84.638589,0> translate<60.960000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,59.690000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<60.960000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.190000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,78.740000>}
box{<0,0,-0.127000><0.551453,0.035000,0.127000> rotate<0,-85.834693,0> translate<62.190000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,78.740000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<62.230000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,85.090000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,80.010000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<57.150000,-1.535000,85.090000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,15.240000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.800000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,38.100000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<63.500000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,41.910000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<60.960000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.940000,-1.535000,58.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,58.420000>}
box{<0,0,-0.127000><0.560357,0.035000,0.127000> rotate<0,2.045273,0> translate<62.940000,-1.535000,58.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,58.420000>}
box{<0,0,-0.127000><16.510000,0.035000,0.127000> rotate<0,90.000000,0> translate<63.500000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.940000,-1.535000,66.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,66.040000>}
box{<0,0,-0.127000><0.560357,0.035000,0.127000> rotate<0,2.045273,0> translate<62.940000,-1.535000,66.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.560000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.642806,0.035000,0.127000> rotate<0,84.638589,0> translate<63.500000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,64.770000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<60.960000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,64.770000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<63.500000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,77.470000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<60.960000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.730000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,77.470000>}
box{<0,0,-0.127000><0.721110,0.035000,0.127000> rotate<0,86.814440,0> translate<64.730000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,59.690000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<62.230000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,63.500000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<64.770000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.480000,-1.535000,66.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,67.310000>}
box{<0,0,-0.127000><1.369708,0.035000,0.127000> rotate<0,-65.863273,0> translate<65.480000,-1.535000,66.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,67.310000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<66.040000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,74.930000>}
box{<0,0,-0.127000><14.368410,0.035000,0.127000> rotate<0,-44.997030,0> translate<55.880000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,76.200000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<57.150000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,44.450000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<63.500000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,44.450000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,-90.000000,0> translate<67.310000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<66.040000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.270000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,78.740000>}
box{<0,0,-0.127000><0.551453,0.035000,0.127000> rotate<0,-85.834693,0> translate<67.270000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,76.200000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.040000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,74.930000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.040000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,77.470000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<68.580000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.810000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,77.470000>}
box{<0,0,-0.127000><0.721110,0.035000,0.127000> rotate<0,86.814440,0> translate<69.810000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,81.280000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<67.310000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,86.360000>}
box{<0,0,-0.127000><29.210000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,76.200000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<69.850000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,76.200000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<71.120000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,80.010000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<69.850000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,24.130000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<63.500000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,24.130000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<72.390000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,26.670000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,-90.000000,0> translate<72.390000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,76.200000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,-44.997030,0> translate<66.040000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,76.200000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<72.390000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.350000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,77.470000>}
box{<0,0,-0.127000><0.721110,0.035000,0.127000> rotate<0,86.814440,0> translate<72.350000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.850000,-1.535000,34.760000>}
box{<0,0,-0.127000><0.657647,0.035000,0.127000> rotate<0,-45.613049,0> translate<72.390000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.850000,-1.535000,19.520000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,19.050000>}
box{<0,0,-0.127000><0.936483,0.035000,0.127000> rotate<0,30.122330,0> translate<72.850000,-1.535000,19.520000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.850000,-1.535000,19.520000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,20.320000>}
box{<0,0,-0.127000><1.138464,0.035000,0.127000> rotate<0,-44.641184,0> translate<72.850000,-1.535000,19.520000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,49.530000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,-90.000000,0> translate<73.660000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,63.500000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.040000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,43.180000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<74.930000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,48.260000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<73.660000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,50.800000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<74.930000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.890000,-1.535000,78.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,77.470000>}
box{<0,0,-0.127000><0.721110,0.035000,0.127000> rotate<0,86.814440,0> translate<74.890000,-1.535000,78.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.000000,-1.535000,43.190000>}
box{<0,0,-0.127000><0.070711,0.035000,0.127000> rotate<0,-8.129566,0> translate<74.930000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.000000,-1.535000,50.810000>}
box{<0,0,-0.127000><0.070711,0.035000,0.127000> rotate<0,-8.129566,0> translate<74.930000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,57.150000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<74.930000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<76.200000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,63.500000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.660000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.240000,-1.535000,57.440000>}
box{<0,0,-0.127000><0.292746,0.035000,0.127000> rotate<0,-82.141265,0> translate<76.200000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.470000,-1.535000,64.770000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<76.200000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,57.150000>}
box{<0,0,-0.127000><15.240000,0.035000,0.127000> rotate<0,90.000000,0> translate<78.740000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,60.960000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<76.200000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.470000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,64.770000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<77.470000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.780000,-1.535000,57.440000>}
box{<0,0,-0.127000><0.292746,0.035000,0.127000> rotate<0,-82.141265,0> translate<78.740000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.780000,-1.535000,65.060000>}
box{<0,0,-0.127000><0.292746,0.035000,0.127000> rotate<0,-82.141265,0> translate<78.740000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,12.700000>}
box{<0,0,-0.127000><29.210000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.800000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,12.700000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,44.997030,0> translate<73.660000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,38.100000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<74.930000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<79.780000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.680074,0.035000,0.127000> rotate<0,-70.228196,0> translate<79.780000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,60.960000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<78.740000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.280000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.280000,-1.535000,66.040000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<81.280000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.280000,-1.535000,71.120000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,44.997030,0> translate<74.930000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.280000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<81.320000,-1.535000,65.060000>}
box{<0,0,-0.127000><0.980816,0.035000,0.127000> rotate<0,87.656909,0> translate<81.280000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.550000,-1.535000,36.830000>}
box{<0,0,-0.127000><14.368410,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.390000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.320000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.550000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.670671,0.035000,0.127000> rotate<0,69.939289,0> translate<82.320000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.550000,-1.535000,38.100000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<78.740000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.320000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<82.550000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.680074,0.035000,0.127000> rotate<0,-70.228196,0> translate<82.320000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<84.860000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,38.100000>}
box{<0,0,-0.127000><0.680074,0.035000,0.127000> rotate<0,-70.228196,0> translate<84.860000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,38.100000>}
box{<0,0,-0.127000><17.780000,0.035000,0.127000> rotate<0,-90.000000,0> translate<85.090000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<80.010000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<85.090000,-1.535000,55.880000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<80.010000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,-1.535000,33.020000>}
box{<0,0,-0.127000><17.960512,0.035000,0.127000> rotate<0,-44.997030,0> translate<73.660000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,86.360000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,-1.535000,69.850000>}
box{<0,0,-0.127000><23.348666,0.035000,0.127000> rotate<0,44.997030,0> translate<69.850000,-1.535000,86.360000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<86.360000,-1.535000,69.850000>}
box{<0,0,-0.127000><36.830000,0.035000,0.127000> rotate<0,90.000000,0> translate<86.360000,-1.535000,69.850000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
texture{col_pol}
}
#end
union{
cylinder{<57.110000,0.038000,78.190000><57.110000,-1.538000,78.190000>0.508000}
cylinder{<59.650000,0.038000,78.190000><59.650000,-1.538000,78.190000>0.508000}
cylinder{<62.190000,0.038000,78.190000><62.190000,-1.538000,78.190000>0.508000}
cylinder{<64.730000,0.038000,78.190000><64.730000,-1.538000,78.190000>0.508000}
cylinder{<67.270000,0.038000,78.190000><67.270000,-1.538000,78.190000>0.508000}
cylinder{<69.810000,0.038000,78.190000><69.810000,-1.538000,78.190000>0.508000}
cylinder{<72.350000,0.038000,78.190000><72.350000,-1.538000,78.190000>0.508000}
cylinder{<74.890000,0.038000,78.190000><74.890000,-1.538000,78.190000>0.508000}
cylinder{<25.370000,0.038000,81.960000><25.370000,-1.538000,81.960000>0.406400}
cylinder{<20.290000,0.038000,81.960000><20.290000,-1.538000,81.960000>0.406400}
cylinder{<7.740000,0.038000,82.040000><7.740000,-1.538000,82.040000>0.406400}
cylinder{<12.820000,0.038000,82.040000><12.820000,-1.538000,82.040000>0.406400}
cylinder{<72.850000,0.038000,34.760000><72.850000,-1.538000,34.760000>0.749300}
cylinder{<72.850000,0.038000,19.520000><72.850000,-1.538000,19.520000>0.749300}
cylinder{<51.850000,0.038000,34.440000><51.850000,-1.538000,34.440000>0.749300}
cylinder{<51.850000,0.038000,19.200000><51.850000,-1.538000,19.200000>0.749300}
cylinder{<7.150000,0.038000,18.880000><7.150000,-1.538000,18.880000>0.749300}
cylinder{<7.150000,0.038000,34.120000><7.150000,-1.538000,34.120000>0.749300}
cylinder{<30.040000,0.038000,19.240000><30.040000,-1.538000,19.240000>0.749300}
cylinder{<30.040000,0.038000,34.480000><30.040000,-1.538000,34.480000>0.749300}
cylinder{<23.460000,0.038000,70.880000><23.460000,-1.538000,70.880000>0.508000}
cylinder{<23.460000,0.038000,68.340000><23.460000,-1.538000,68.340000>0.508000}
cylinder{<23.460000,0.038000,73.420000><23.460000,-1.538000,73.420000>0.508000}
cylinder{<51.020000,0.038000,12.090000><51.020000,-1.538000,12.090000>0.508000}
cylinder{<48.480000,0.038000,12.090000><48.480000,-1.538000,12.090000>0.508000}
cylinder{<45.940000,0.038000,12.090000><45.940000,-1.538000,12.090000>0.508000}
cylinder{<43.400000,0.038000,12.090000><43.400000,-1.538000,12.090000>0.508000}
cylinder{<40.860000,0.038000,12.090000><40.860000,-1.538000,12.090000>0.508000}
cylinder{<38.320000,0.038000,12.090000><38.320000,-1.538000,12.090000>0.508000}
cylinder{<35.780000,0.038000,12.090000><35.780000,-1.538000,12.090000>0.508000}
cylinder{<33.240000,0.038000,12.090000><33.240000,-1.538000,12.090000>0.508000}
cylinder{<81.320000,0.038000,65.060000><81.320000,-1.538000,65.060000>0.406400}
cylinder{<78.780000,0.038000,65.060000><78.780000,-1.538000,65.060000>0.406400}
cylinder{<76.240000,0.038000,65.060000><76.240000,-1.538000,65.060000>0.406400}
cylinder{<76.240000,0.038000,57.440000><76.240000,-1.538000,57.440000>0.406400}
cylinder{<78.780000,0.038000,57.440000><78.780000,-1.538000,57.440000>0.406400}
cylinder{<81.320000,0.038000,57.440000><81.320000,-1.538000,57.440000>0.406400}
cylinder{<65.480000,0.038000,66.060000><65.480000,-1.538000,66.060000>0.406400}
cylinder{<62.940000,0.038000,66.060000><62.940000,-1.538000,66.060000>0.406400}
cylinder{<60.400000,0.038000,66.060000><60.400000,-1.538000,66.060000>0.406400}
cylinder{<60.400000,0.038000,58.440000><60.400000,-1.538000,58.440000>0.406400}
cylinder{<62.940000,0.038000,58.440000><62.940000,-1.538000,58.440000>0.406400}
cylinder{<65.480000,0.038000,58.440000><65.480000,-1.538000,58.440000>0.406400}
cylinder{<49.640000,0.038000,66.060000><49.640000,-1.538000,66.060000>0.406400}
cylinder{<47.100000,0.038000,66.060000><47.100000,-1.538000,66.060000>0.406400}
cylinder{<44.560000,0.038000,66.060000><44.560000,-1.538000,66.060000>0.406400}
cylinder{<44.560000,0.038000,58.440000><44.560000,-1.538000,58.440000>0.406400}
cylinder{<47.100000,0.038000,58.440000><47.100000,-1.538000,58.440000>0.406400}
cylinder{<49.640000,0.038000,58.440000><49.640000,-1.538000,58.440000>0.406400}
cylinder{<33.800000,0.038000,66.060000><33.800000,-1.538000,66.060000>0.406400}
cylinder{<31.260000,0.038000,66.060000><31.260000,-1.538000,66.060000>0.406400}
cylinder{<28.720000,0.038000,66.060000><28.720000,-1.538000,66.060000>0.406400}
cylinder{<28.720000,0.038000,58.440000><28.720000,-1.538000,58.440000>0.406400}
cylinder{<31.260000,0.038000,58.440000><31.260000,-1.538000,58.440000>0.406400}
cylinder{<33.800000,0.038000,58.440000><33.800000,-1.538000,58.440000>0.406400}
cylinder{<8.340000,0.038000,56.950000><8.340000,-1.538000,56.950000>0.350000}
cylinder{<8.340000,0.038000,59.490000><8.340000,-1.538000,59.490000>0.350000}
cylinder{<82.320000,0.038000,37.460000><82.320000,-1.538000,37.460000>0.558800}
cylinder{<84.860000,0.038000,37.460000><84.860000,-1.538000,37.460000>0.558800}
cylinder{<79.780000,0.038000,37.460000><79.780000,-1.538000,37.460000>0.558800}
cylinder{<61.020000,0.038000,37.460000><61.020000,-1.538000,37.460000>0.558800}
cylinder{<63.560000,0.038000,37.460000><63.560000,-1.538000,37.460000>0.558800}
cylinder{<58.480000,0.038000,37.460000><58.480000,-1.538000,37.460000>0.558800}
cylinder{<38.720000,0.038000,37.460000><38.720000,-1.538000,37.460000>0.558800}
cylinder{<41.260000,0.038000,37.460000><41.260000,-1.538000,37.460000>0.558800}
cylinder{<36.180000,0.038000,37.460000><36.180000,-1.538000,37.460000>0.558800}
cylinder{<16.420000,0.038000,37.460000><16.420000,-1.538000,37.460000>0.558800}
cylinder{<18.960000,0.038000,37.460000><18.960000,-1.538000,37.460000>0.558800}
cylinder{<13.880000,0.038000,37.460000><13.880000,-1.538000,37.460000>0.558800}
cylinder{<75.000000,0.038000,43.190000><75.000000,-1.538000,43.190000>0.406400}
cylinder{<75.000000,0.038000,50.810000><75.000000,-1.538000,50.810000>0.406400}
cylinder{<59.610000,0.038000,43.660000><59.610000,-1.538000,43.660000>0.406400}
cylinder{<59.610000,0.038000,51.280000><59.610000,-1.538000,51.280000>0.406400}
cylinder{<43.610000,0.038000,43.500000><43.610000,-1.538000,43.500000>0.406400}
cylinder{<43.610000,0.038000,51.120000><43.610000,-1.538000,51.120000>0.406400}
cylinder{<28.000000,0.038000,43.190000><28.000000,-1.538000,43.190000>0.406400}
cylinder{<28.000000,0.038000,50.810000><28.000000,-1.538000,50.810000>0.406400}
cylinder{<42.660000,0.038000,74.400000><42.660000,-1.538000,74.400000>0.350000}
cylinder{<42.660000,0.038000,71.860000><42.660000,-1.538000,71.860000>0.350000}
cylinder{<36.660000,0.038000,74.750000><36.660000,-1.538000,74.750000>0.350000}
cylinder{<36.660000,0.038000,72.210000><36.660000,-1.538000,72.210000>0.350000}
cylinder{<9.550000,0.038000,47.500000><9.550000,-1.538000,47.500000>0.500000}
cylinder{<9.550000,0.038000,50.040000><9.550000,-1.538000,50.040000>0.500000}
cylinder{<46.660000,0.038000,82.230000><46.660000,-1.538000,82.230000>0.508000}
cylinder{<44.120000,0.038000,82.230000><44.120000,-1.538000,82.230000>0.508000}
cylinder{<41.580000,0.038000,82.230000><41.580000,-1.538000,82.230000>0.508000}
cylinder{<39.040000,0.038000,82.230000><39.040000,-1.538000,82.230000>0.508000}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//+11,1V__BATERIA silk screen
difference{
cylinder{<84.660000,0,9.040000><84.660000,0.036000,9.040000>1.079500 translate<0,0.000000,0>}
cylinder{<84.660000,-0.1,9.040000><84.660000,0.135000,9.040000>0.952500 translate<0,0.000000,0>}}
//ARDUINO silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.840000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.380000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.840000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.380000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.380000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.380000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.380000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.840000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.840000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.840000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.840000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.840000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<57.110000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<57.110000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<57.110000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.380000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.920000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.380000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.920000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.920000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.920000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.920000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.380000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.380000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<59.650000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<59.650000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<59.650000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.920000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.460000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.920000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.460000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.460000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.460000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.460000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.920000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.920000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.190000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.190000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<62.190000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.460000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.000000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.460000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.000000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.000000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.000000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.000000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.460000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.460000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<64.730000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<64.730000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<64.730000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.000000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.540000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.000000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.540000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.540000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.540000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.540000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.000000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.000000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<67.270000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<67.270000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<67.270000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.540000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.080000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.540000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.080000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.080000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.080000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.080000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.540000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.540000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<69.810000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<69.810000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<69.810000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.080000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.620000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.080000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.620000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.620000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.620000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.620000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.080000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.080000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<72.350000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<72.350000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<72.350000,0.000000,83.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.620000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.160000,0.000000,80.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.620000,0.000000,80.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.160000,0.000000,80.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.160000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.160000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.160000,0.000000,82.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.620000,0.000000,82.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.620000,0.000000,82.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<74.890000,0.000000,88.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<74.890000,0.000000,83.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<74.890000,0.000000,83.270000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<57.110000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<59.650000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<62.190000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<64.730000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<67.270000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<69.810000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<72.350000,0.000000,82.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<74.890000,0.000000,82.889000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<57.110000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<59.650000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<62.190000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<64.730000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<67.270000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<69.810000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<72.350000,0.000000,79.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<74.890000,0.000000,79.587000>}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<23.134800,0.000000,81.325000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<23.134800,0.000000,81.960000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<23.134800,0.000000,81.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<23.134800,0.000000,81.960000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<23.134800,0.000000,82.595000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<23.134800,0.000000,82.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.134800,0.000000,81.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.354000,0.000000,81.960000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<23.134800,0.000000,81.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.499800,0.000000,81.325000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.499800,0.000000,81.960000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<22.499800,0.000000,81.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.499800,0.000000,81.960000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.499800,0.000000,82.595000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<22.499800,0.000000,82.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.499800,0.000000,81.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.306000,0.000000,81.960000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<21.306000,0.000000,81.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.513000,0.000000,80.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.513000,0.000000,83.230000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.513000,0.000000,83.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.259000,0.000000,83.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.401000,0.000000,83.484000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.401000,0.000000,83.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.147000,0.000000,83.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.147000,0.000000,80.690000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.147000,0.000000,80.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.401000,0.000000,80.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.259000,0.000000,80.436000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.401000,0.000000,80.436000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.401000,0.000000,80.690000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.401000,0.000000,83.230000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<26.259000,0.000000,83.230000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<26.259000,0.000000,80.690000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.975200,0.000000,82.675000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.975200,0.000000,82.040000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<9.975200,0.000000,82.040000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.975200,0.000000,82.040000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.975200,0.000000,81.405000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<9.975200,0.000000,81.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.975200,0.000000,82.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.756000,0.000000,82.040000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<8.756000,0.000000,82.040000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<10.610200,0.000000,82.675000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<10.610200,0.000000,82.040000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<10.610200,0.000000,82.040000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<10.610200,0.000000,82.040000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<10.610200,0.000000,81.405000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<10.610200,0.000000,81.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.610200,0.000000,82.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.804000,0.000000,82.040000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<10.610200,0.000000,82.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.597000,0.000000,83.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.597000,0.000000,80.770000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.597000,0.000000,80.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.851000,0.000000,80.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.709000,0.000000,80.516000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.851000,0.000000,80.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.963000,0.000000,80.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.963000,0.000000,83.310000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.963000,0.000000,83.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.709000,0.000000,83.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.851000,0.000000,83.564000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.851000,0.000000,83.564000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<13.709000,0.000000,83.310000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<13.709000,0.000000,80.770000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<6.851000,0.000000,80.770000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<6.851000,0.000000,83.310000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,25.870000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,27.140000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.850000,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.265800,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,27.140000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<72.265800,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.265800,0.000000,28.283000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<72.265800,0.000000,28.283000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.265800,0.000000,28.283000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.434200,0.000000,28.283000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<72.265800,0.000000,28.283000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.434200,0.000000,28.283000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,27.140000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<72.850000,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,29.426000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.850000,0.000000,29.426000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.850000,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.434200,0.000000,27.140000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<72.850000,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.644000,0.000000,22.060000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.056000,0.000000,22.060000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.056000,0.000000,22.060000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.056000,0.000000,32.220000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.644000,0.000000,32.220000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.056000,0.000000,32.220000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.056000,0.000000,22.060000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.056000,0.000000,32.220000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.056000,0.000000,32.220000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.644000,0.000000,32.220000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.644000,0.000000,22.060000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<75.644000,0.000000,22.060000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<72.850000,0.000000,34.760000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<72.850000,0.000000,33.363000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<72.850000,0.000000,33.363000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<72.850000,0.000000,19.520000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<72.850000,0.000000,20.917000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<72.850000,0.000000,20.917000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<72.850000,0.000000,23.330000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<72.850000,0.000000,21.615500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<72.850000,0.000000,32.664500>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,25.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,26.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.850000,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.265800,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,26.820000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<51.265800,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.265800,0.000000,27.963000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<51.265800,0.000000,27.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.265800,0.000000,27.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.434200,0.000000,27.963000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<51.265800,0.000000,27.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.434200,0.000000,27.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,26.820000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<51.850000,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,29.106000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.850000,0.000000,29.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.850000,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.434200,0.000000,26.820000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<51.850000,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.644000,0.000000,21.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.056000,0.000000,21.740000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.056000,0.000000,21.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.056000,0.000000,31.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.644000,0.000000,31.900000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.056000,0.000000,31.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.056000,0.000000,21.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.056000,0.000000,31.900000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.056000,0.000000,31.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.644000,0.000000,31.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.644000,0.000000,21.740000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.644000,0.000000,21.740000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<51.850000,0.000000,34.440000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<51.850000,0.000000,33.043000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<51.850000,0.000000,33.043000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<51.850000,0.000000,19.200000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<51.850000,0.000000,20.597000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<51.850000,0.000000,20.597000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<51.850000,0.000000,23.010000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<51.850000,0.000000,21.295500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<51.850000,0.000000,32.344500>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,27.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,26.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.150000,0.000000,26.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.734200,0.000000,26.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,26.500000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<7.150000,0.000000,26.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,26.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.734200,0.000000,25.357000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<7.150000,0.000000,26.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.734200,0.000000,25.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.565800,0.000000,25.357000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<6.565800,0.000000,25.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.565800,0.000000,25.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,26.500000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<6.565800,0.000000,25.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,26.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,24.214000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.150000,0.000000,24.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.150000,0.000000,26.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.565800,0.000000,26.500000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<6.565800,0.000000,26.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.356000,0.000000,31.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.944000,0.000000,31.580000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.356000,0.000000,31.580000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.944000,0.000000,21.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.356000,0.000000,21.420000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.356000,0.000000,21.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.944000,0.000000,31.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.944000,0.000000,21.420000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.944000,0.000000,21.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.356000,0.000000,21.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.356000,0.000000,31.580000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.356000,0.000000,31.580000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<7.150000,0.000000,18.880000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<7.150000,0.000000,20.277000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<7.150000,0.000000,20.277000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<7.150000,0.000000,34.120000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<7.150000,0.000000,32.723000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<7.150000,0.000000,32.723000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-270.000000,0> translate<7.150000,0.000000,30.310000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<7.150000,0.000000,32.024500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<7.150000,0.000000,20.975500>}
//D4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,28.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,26.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.040000,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.624200,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,26.860000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<30.040000,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.624200,0.000000,25.717000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<30.040000,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.624200,0.000000,25.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.455800,0.000000,25.717000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<29.455800,0.000000,25.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.455800,0.000000,25.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,26.860000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<29.455800,0.000000,25.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,24.574000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.040000,0.000000,24.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.040000,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.455800,0.000000,26.860000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<29.455800,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.246000,0.000000,31.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.834000,0.000000,31.940000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.246000,0.000000,31.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.834000,0.000000,21.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.246000,0.000000,21.780000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.246000,0.000000,21.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.834000,0.000000,31.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.834000,0.000000,21.780000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.834000,0.000000,21.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.246000,0.000000,21.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.246000,0.000000,31.940000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.246000,0.000000,31.940000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<30.040000,0.000000,19.240000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<30.040000,0.000000,20.637000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<30.040000,0.000000,20.637000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<30.040000,0.000000,34.480000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<30.040000,0.000000,33.083000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<30.040000,0.000000,33.083000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-270.000000,0> translate<30.040000,0.000000,30.670000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<30.040000,0.000000,32.384500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<30.040000,0.000000,21.335500>}
//GND__BATERIA silk screen
difference{
cylinder{<8.040000,0,9.040000><8.040000,0.036000,9.040000>1.079500 translate<0,0.000000,0>}
cylinder{<8.040000,-0.1,9.040000><8.040000,0.135000,9.040000>0.952500 translate<0,0.000000,0>}}
//LM7809 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,65.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,76.087000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.920000,0.000000,76.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,76.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,65.673000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.045000,0.000000,65.673000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,76.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,76.087000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.474000,0.000000,76.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,76.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,75.198000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.474000,0.000000,75.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,75.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,75.198000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.950000,0.000000,75.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,75.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,76.087000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.950000,0.000000,76.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,76.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,76.087000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.045000,0.000000,76.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,65.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,65.673000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.474000,0.000000,65.673000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,65.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,66.562000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.474000,0.000000,66.562000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,66.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,66.562000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.950000,0.000000,66.562000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,66.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,65.673000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.950000,0.000000,65.673000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,65.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,65.673000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.045000,0.000000,65.673000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,66.308000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,75.452000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,90.000000,0> translate<20.285000,0.000000,75.452000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,75.452000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,75.452000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<12.030000,0.000000,75.452000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,75.452000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,66.308000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,-90.000000,0> translate<12.030000,0.000000,66.308000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,66.308000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,66.308000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<12.030000,0.000000,66.308000> }
difference{
cylinder{<8.474000,0,70.880000><8.474000,0.036000,70.880000>1.879600 translate<0,0.000000,0>}
cylinder{<8.474000,-0.1,70.880000><8.474000,0.135000,70.880000>1.727200 translate<0,0.000000,0>}}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<21.364500,0.000000,73.420000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<22.634500,0.000000,73.420000>}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<21.364500,0.000000,70.880000>}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<21.364500,0.000000,68.340000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<22.634500,0.000000,70.880000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<22.634500,0.000000,68.340000>}
//MOTORES silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.290000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.750000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.750000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.750000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.750000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.750000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.750000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.290000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.750000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.290000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.290000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.290000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<51.020000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<51.020000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<51.020000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.750000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.210000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.210000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.210000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.210000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.210000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.210000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.750000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.210000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<48.480000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<48.480000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<48.480000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.210000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.670000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.670000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.670000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.670000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.670000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.670000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.210000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.670000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<45.940000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<45.940000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<45.940000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.670000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.130000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.130000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.130000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.130000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.130000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.130000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.670000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.130000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<43.400000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<43.400000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<43.400000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.130000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.590000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.590000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.590000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.590000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.590000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.590000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.130000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.590000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<40.860000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<40.860000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<40.860000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.590000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.050000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.050000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.050000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.050000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.050000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.050000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.590000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.050000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<38.320000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<38.320000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<38.320000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.050000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.510000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.510000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.510000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.510000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.510000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.510000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.050000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.510000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<35.780000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<35.780000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<35.780000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.510000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.970000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.970000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.970000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.970000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.970000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.970000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.510000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.970000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<33.240000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<33.240000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<33.240000,0.000000,7.010000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<51.020000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<48.480000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<45.940000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<43.400000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<40.860000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<38.320000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<35.780000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<33.240000,0.000000,7.391000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<51.020000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<48.480000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<45.940000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<43.400000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<40.860000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<38.320000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<35.780000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<33.240000,0.000000,10.693000>}
//OK1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.970000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.590000,0.000000,58.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.970000,0.000000,58.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.590000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.970000,0.000000,64.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.970000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.970000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.970000,0.000000,64.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.970000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.590000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.590000,0.000000,60.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.590000,0.000000,60.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.590000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.590000,0.000000,62.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<82.590000,0.000000,62.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<82.590000,0.000000,61.250000>}
//OK2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.130000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.750000,0.000000,59.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.130000,0.000000,59.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.750000,0.000000,65.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.130000,0.000000,65.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.130000,0.000000,65.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.130000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.130000,0.000000,65.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.130000,0.000000,65.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.750000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.750000,0.000000,61.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.750000,0.000000,61.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.750000,0.000000,65.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.750000,0.000000,63.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.750000,0.000000,63.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<66.750000,0.000000,62.250000>}
//OK3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,59.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.290000,0.000000,59.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,65.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,65.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.290000,0.000000,65.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,65.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.290000,0.000000,65.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,61.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.910000,0.000000,61.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,65.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,63.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.910000,0.000000,63.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<50.910000,0.000000,62.250000>}
//OK4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,59.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.450000,0.000000,59.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,65.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,65.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.450000,0.000000,65.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,65.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.450000,0.000000,65.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,59.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,61.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.070000,0.000000,61.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,65.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,63.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.070000,0.000000,63.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<35.070000,0.000000,62.250000>}
//POWER silk screen
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.113000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.113000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.113000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.002000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.113000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.002000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.002000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.002000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.002000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.113000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.113000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.113000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.527000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.638000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.638000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.638000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.638000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<86.638000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.638000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.638000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.527000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<87.527000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<86.892000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<77.748000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<77.748000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<77.748000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<77.748000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<77.748000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<77.748000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<86.892000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<77.748000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<86.892000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<86.892000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<86.892000,0.000000,23.490000> }
difference{
cylinder{<82.320000,0,19.934000><82.320000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<82.320000,-0.1,19.934000><82.320000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<79.780000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<82.320000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<84.860000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<84.860000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<82.320000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<79.780000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<84.860000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<82.320000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<79.780000,0.000000,36.761500>}
//Q2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.813000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.813000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.813000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.702000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.813000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.702000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.702000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.702000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.702000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.813000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.813000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.813000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.227000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.338000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.338000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.338000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.338000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.338000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.338000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.338000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.227000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.227000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.592000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.448000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<56.448000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.448000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.448000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<56.448000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.448000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.592000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<56.448000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.592000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.592000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.592000,0.000000,23.490000> }
difference{
cylinder{<61.020000,0,19.934000><61.020000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<61.020000,-0.1,19.934000><61.020000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<58.480000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<61.020000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<63.560000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<63.560000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<61.020000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<58.480000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<63.560000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<61.020000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<58.480000,0.000000,36.761500>}
//Q3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.513000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.513000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.513000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.402000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.513000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.402000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.402000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.402000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.402000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.513000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.513000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.513000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.927000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.038000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.038000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.038000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.038000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.038000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.038000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.038000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.927000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.927000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.292000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.148000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<34.148000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.148000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.148000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<34.148000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.148000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.292000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<34.148000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.292000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.292000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<43.292000,0.000000,23.490000> }
difference{
cylinder{<38.720000,0,19.934000><38.720000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<38.720000,-0.1,19.934000><38.720000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<36.180000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<38.720000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<41.260000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<41.260000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<38.720000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<36.180000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<41.260000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<38.720000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<36.180000,0.000000,36.761500>}
//Q4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.213000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.102000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.213000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.627000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.738000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.738000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.738000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.627000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<11.848000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<11.848000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<11.848000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<20.992000,0.000000,23.490000> }
difference{
cylinder{<16.420000,0,19.934000><16.420000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<16.420000,-0.1,19.934000><16.420000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<13.880000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<16.420000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<18.960000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<18.960000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<16.420000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<13.880000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<18.960000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<16.420000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<13.880000,0.000000,36.761500>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<75.000000,0.000000,43.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<75.000000,0.000000,43.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<75.000000,0.000000,43.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<74.111000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<75.889000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<75.889000,0.000000,49.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<74.111000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.889000,0.000000,43.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.111000,0.000000,43.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.111000,0.000000,43.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.857000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.984000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<73.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.143000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.143000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.016000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<76.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<73.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.984000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.984000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<76.016000,0.000000,49.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.016000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.857000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.143000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.143000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.889000,0.000000,50.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.111000,0.000000,50.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.111000,0.000000,50.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<75.000000,0.000000,50.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<75.000000,0.000000,50.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<75.000000,0.000000,50.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<75.000000,0.000000,43.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<75.000000,0.000000,50.302000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.610000,0.000000,43.660000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.610000,0.000000,44.041000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<59.610000,0.000000,44.041000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<58.721000,0.000000,44.549000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<60.499000,0.000000,44.549000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<60.499000,0.000000,50.391000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<58.721000,0.000000,50.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.499000,0.000000,44.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.721000,0.000000,44.295000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.721000,0.000000,44.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.467000,0.000000,44.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.467000,0.000000,44.930000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.467000,0.000000,44.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.594000,0.000000,45.057000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.467000,0.000000,44.930000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.467000,0.000000,44.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.753000,0.000000,44.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.753000,0.000000,44.930000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.753000,0.000000,44.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.626000,0.000000,45.057000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.753000,0.000000,44.930000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<60.626000,0.000000,45.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.594000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.467000,0.000000,50.010000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.467000,0.000000,50.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.594000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.594000,0.000000,45.057000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.594000,0.000000,45.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.626000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.753000,0.000000,50.010000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<60.626000,0.000000,49.883000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.626000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.626000,0.000000,45.057000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.626000,0.000000,45.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.467000,0.000000,50.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.467000,0.000000,50.010000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.467000,0.000000,50.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.753000,0.000000,50.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.753000,0.000000,50.010000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.753000,0.000000,50.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.499000,0.000000,50.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.721000,0.000000,50.645000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.721000,0.000000,50.645000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.610000,0.000000,50.899000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.610000,0.000000,51.280000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<59.610000,0.000000,51.280000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<59.610000,0.000000,44.168000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<59.610000,0.000000,50.772000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.610000,0.000000,43.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.610000,0.000000,43.881000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<43.610000,0.000000,43.881000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<42.721000,0.000000,44.389000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<44.499000,0.000000,44.389000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<44.499000,0.000000,50.231000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<42.721000,0.000000,50.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.499000,0.000000,44.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.721000,0.000000,44.135000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.721000,0.000000,44.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.467000,0.000000,44.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.467000,0.000000,44.770000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.467000,0.000000,44.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.594000,0.000000,44.897000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.467000,0.000000,44.770000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.467000,0.000000,44.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.753000,0.000000,44.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.753000,0.000000,44.770000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.753000,0.000000,44.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.626000,0.000000,44.897000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.753000,0.000000,44.770000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<44.626000,0.000000,44.897000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.594000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.467000,0.000000,49.850000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<42.467000,0.000000,49.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.594000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.594000,0.000000,44.897000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.594000,0.000000,44.897000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.626000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.753000,0.000000,49.850000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.626000,0.000000,49.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.626000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.626000,0.000000,44.897000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.626000,0.000000,44.897000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.467000,0.000000,50.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.467000,0.000000,49.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.467000,0.000000,49.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.753000,0.000000,50.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.753000,0.000000,49.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.753000,0.000000,49.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.499000,0.000000,50.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.721000,0.000000,50.485000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.721000,0.000000,50.485000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.610000,0.000000,50.739000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<43.610000,0.000000,51.120000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<43.610000,0.000000,51.120000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<43.610000,0.000000,44.008000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<43.610000,0.000000,50.612000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<28.000000,0.000000,43.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<28.000000,0.000000,43.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<28.000000,0.000000,43.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<27.111000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<28.889000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<28.889000,0.000000,49.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<27.111000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.889000,0.000000,43.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.111000,0.000000,43.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.111000,0.000000,43.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.857000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.984000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.143000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<29.143000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.016000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<29.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<26.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.984000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.984000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.016000,0.000000,49.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.016000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.857000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.143000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.143000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.889000,0.000000,50.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.111000,0.000000,50.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.111000,0.000000,50.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<28.000000,0.000000,50.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<28.000000,0.000000,50.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<28.000000,0.000000,50.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<28.000000,0.000000,43.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<28.000000,0.000000,50.302000>}
//RX silk screen
//TX silk screen
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.375000,0.000000,46.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.375000,0.000000,51.310000>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,90.000000,0> translate<6.375000,0.000000,51.310000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.375000,0.000000,51.310000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.280000,0.000000,51.310000>}
box{<0,0,-0.127000><1.905000,0.036000,0.127000> rotate<0,0.000000,0> translate<6.375000,0.000000,51.310000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.280000,0.000000,51.310000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.725000,0.000000,51.310000>}
box{<0,0,-0.127000><4.445000,0.036000,0.127000> rotate<0,0.000000,0> translate<8.280000,0.000000,51.310000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.725000,0.000000,51.310000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.725000,0.000000,46.230000>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,-90.000000,0> translate<12.725000,0.000000,46.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<12.725000,0.000000,46.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.280000,0.000000,46.230000>}
box{<0,0,-0.127000><4.445000,0.036000,0.127000> rotate<0,0.000000,0> translate<8.280000,0.000000,46.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.280000,0.000000,46.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.375000,0.000000,46.230000>}
box{<0,0,-0.127000><1.905000,0.036000,0.127000> rotate<0,0.000000,0> translate<6.375000,0.000000,46.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.280000,0.000000,46.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.280000,0.000000,51.310000>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,90.000000,0> translate<8.280000,0.000000,51.310000> }
//XBEE silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.850000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,0.000000,80.960000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.215000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.945000,0.000000,80.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.945000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.945000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.310000,0.000000,81.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.310000,0.000000,81.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.310000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.310000,0.000000,82.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.310000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.310000,0.000000,82.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.945000,0.000000,83.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.310000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.945000,0.000000,83.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,0.000000,83.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.945000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,0.000000,83.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.850000,0.000000,82.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.215000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.295000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.025000,0.000000,80.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.025000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.025000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.390000,0.000000,81.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<45.390000,0.000000,81.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.390000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.390000,0.000000,82.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.390000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.390000,0.000000,82.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.025000,0.000000,83.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.390000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.390000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.755000,0.000000,80.960000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.755000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.755000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.485000,0.000000,80.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.485000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.485000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.850000,0.000000,81.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.850000,0.000000,81.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.850000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.850000,0.000000,82.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.850000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.850000,0.000000,82.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.485000,0.000000,83.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.850000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.485000,0.000000,83.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.755000,0.000000,83.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.485000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.755000,0.000000,83.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.390000,0.000000,82.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<44.755000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.930000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.930000,0.000000,82.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.930000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.295000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.930000,0.000000,81.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.295000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.930000,0.000000,82.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.295000,0.000000,83.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<47.295000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.025000,0.000000,83.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.295000,0.000000,83.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.025000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.675000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.405000,0.000000,80.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.405000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.405000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.770000,0.000000,81.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<37.770000,0.000000,81.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.770000,0.000000,81.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.770000,0.000000,82.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.770000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.770000,0.000000,82.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.405000,0.000000,83.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<37.770000,0.000000,82.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.675000,0.000000,80.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.310000,0.000000,81.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.675000,0.000000,80.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.310000,0.000000,82.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.675000,0.000000,83.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<39.675000,0.000000,83.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.405000,0.000000,83.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.675000,0.000000,83.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.405000,0.000000,83.500000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<41.580000,0.000000,82.230000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<44.120000,0.000000,82.230000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<46.660000,0.000000,82.230000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<39.040000,0.000000,82.230000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  PROTOTIPO_2(-45.000000,0,-45.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//+11,1V__BATERIA	M01-SMTSO-256-ET	SMTSO-256-ET
//GND__BATERIA	M01-SMTSO-256-ET	SMTSO-256-ET
//POWER	SPST	SPST
//RX	SPST	SPST
//TX	SPST	SPST
//X1	22-23-2021	22-23-2021
