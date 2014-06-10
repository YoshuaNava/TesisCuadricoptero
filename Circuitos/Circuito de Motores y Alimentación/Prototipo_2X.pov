//POVRay-File created by 3d41.ulp v20110101
//C:/Users/Yoshua/Documents/eagle/CircuitoMA_Tesis/Prototipo_2X.brd
//03-06-2014 02:29:36 a.m.

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
#local cam_y = 369;
#local cam_z = -197;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -8;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
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

#local lgt1_pos_x = 31;
#local lgt1_pos_y = 49;
#local lgt1_pos_z = 45;
#local lgt1_intense = 0.803200;
#local lgt2_pos_x = -31;
#local lgt2_pos_y = 49;
#local lgt2_pos_z = 45;
#local lgt2_intense = 0.803200;
#local lgt3_pos_x = 31;
#local lgt3_pos_y = 49;
#local lgt3_pos_z = -30;
#local lgt3_intense = 0.803200;
#local lgt4_pos_x = -31;
#local lgt4_pos_y = 49;
#local lgt4_pos_z = -30;
#local lgt4_intense = 0.803200;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 84.000000;
#declare pcb_y_size = 86.000000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(620);
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
	//translate<-42.000000,0,-43.000000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro PROTOTIPO_2X(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><84.000000,0.000000>
<84.000000,0.000000><84.000000,86.000000>
<84.000000,86.000000><0.000000,86.000000>
<0.000000,86.000000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<7.474000,1,69.880000><7.474000,-5,69.880000>1.651000 texture{col_hls}}
cylinder{<74.320000,1,19.934000><74.320000,-5,19.934000>1.651000 texture{col_hls}}
cylinder{<55.020000,1,19.934000><55.020000,-5,19.934000>1.651000 texture{col_hls}}
cylinder{<35.720000,1,19.934000><35.720000,-5,19.934000>1.651000 texture{col_hls}}
cylinder{<15.420000,1,19.934000><15.420000,-5,19.934000>1.651000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
cylinder{<13.040000,0.095000,10.040000><13.040000,-1.595000,10.040000>1.905000 texture{col_hls}}
cylinder{<64.660000,0.095000,10.040000><64.660000,-1.595000,10.040000>1.905000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_ARDUINO) #declare global_pack_ARDUINO=yes; object {CON_PHW_1X8()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<56.000000,0.000000,76.000000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) ARDUINO  1X08/90
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_50MM_76MM("0,33uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<21.830000,0.000000,78.960000>}#end		//ceramic disc capacitator C1 0,33uF C050-030X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_50MM_76MM("0,1uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<9.280000,0.000000,79.040000>}#end		//ceramic disc capacitator C2 0,1uF C050-030X075
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<64.850000,0.000000,27.140000>}#end		//Diode DO201 15mm hor. D1 RGP30 DO201-15
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<45.850000,0.000000,26.820000>}#end		//Diode DO201 15mm hor. D2 RGP30 DO201-15
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<6.150000,0.000000,27.500000>}#end		//Diode DO201 15mm hor. D3 RGP30 DO201-15
#ifndef(pack_D4) #declare global_pack_D4=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<26.040000,0.000000,26.860000>}#end		//Diode DO201 15mm hor. D4 RGP30 DO201-15
#ifndef(pack_LM7809) #declare global_pack_LM7809=yes; object {TR_TO220_3_H2("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<18.650000,0.000000,69.880000>}#end		//TO220 horizontal straight leads LM7809  78XXL
#ifndef(pack_MOTORES) #declare global_pack_MOTORES=yes; object {CON_PHW_1X8()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<38.130000,0.000000,8.280000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) MOTORES  1X08/90
#ifndef(pack_OK1) #declare global_pack_OK1=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<70.780000,0.000000,61.250000>}#end		//DIP6 OK1 4N26M DIL06
#ifndef(pack_OK2) #declare global_pack_OK2=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<58.940000,0.000000,61.250000>}#end		//DIP6 OK2 4N26M DIL06
#ifndef(pack_OK3) #declare global_pack_OK3=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<47.100000,0.000000,61.250000>}#end		//DIP6 OK3 4N26M DIL06
#ifndef(pack_OK4) #declare global_pack_OK4=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<35.260000,0.000000,61.250000>}#end		//DIP6 OK4 4N26M DIL06
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<74.320000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q1 IRLZ44Z TO220BH
#ifndef(pack_Q2) #declare global_pack_Q2=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<55.020000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q2 IRLZ44Z TO220BH
#ifndef(pack_Q3) #declare global_pack_Q3=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<35.720000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q3 IRLZ44Z TO220BH
#ifndef(pack_Q4) #declare global_pack_Q4=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<15.420000,0.000000,31.110000>}#end		//TO220 horizontal straight leads Q4 IRLZ44Z TO220BH
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<71.000000,0.000000,47.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 10kOhm 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<55.610000,0.000000,47.470000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 10kOhm 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<39.610000,0.000000,47.310000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 10kOhm 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<26.000000,0.000000,47.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 10kOhm 0207/7
#ifndef(pack_XBEE) #declare global_pack_XBEE=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<34.850000,0.000000,81.230000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) XBEE  1X04
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack__11_1V__BATERIA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(6.197600,3.810000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<64.660000,0,10.040000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<47.110000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.650000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.190000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.730000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.270000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.810000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.350000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.890000,0,72.190000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.370000,0,78.960000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<19.290000,0,78.960000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<6.740000,0,79.040000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<11.820000,0,79.040000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.850000,0,34.760000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.850000,0,19.520000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.850000,0,34.440000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.850000,0,19.200000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<6.150000,0,19.880000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<6.150000,0,35.120000> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<26.040000,0,19.240000> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<26.040000,0,34.480000> texture{col_thl}}
#ifndef(global_pack_GND__BATERIA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(6.197600,3.810000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<13.040000,0,10.040000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.460000,0,69.880000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.460000,0,67.340000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.460000,0,72.420000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<47.020000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<44.480000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<41.940000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<39.400000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<36.860000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<34.320000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<31.780000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<29.240000,0,12.090000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<73.320000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<70.780000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<68.240000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<68.240000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<70.780000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<73.320000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<61.480000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<58.940000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<56.400000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<56.400000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<58.940000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<61.480000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<49.640000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<47.100000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<44.560000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<44.560000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<47.100000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<49.640000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<37.800000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<35.260000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<32.720000,0,65.060000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<32.720000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<35.260000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<37.800000,0,57.440000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<11.340000,0,56.950000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<11.340000,0,59.490000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<74.320000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<76.860000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<71.780000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<55.020000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<57.560000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<52.480000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<35.720000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<38.260000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<33.180000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<15.420000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<17.960000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<12.880000,0,37.460000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<71.000000,0,43.190000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<71.000000,0,50.810000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<55.610000,0,43.660000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<55.610000,0,51.280000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.610000,0,43.500000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.610000,0,51.120000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<26.000000,0,43.190000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<26.000000,0,50.810000> texture{col_thl}}
#ifndef(global_pack_RX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<38.660000,0,74.400000> texture{col_thl}}
#ifndef(global_pack_RX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<38.660000,0,71.860000> texture{col_thl}}
#ifndef(global_pack_TX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<28.660000,0,74.750000> texture{col_thl}}
#ifndef(global_pack_TX) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.208000,0.700000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<28.660000,0,72.210000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.508000,1.000000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<11.550000,0,46.500000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.508000,1.000000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<11.550000,0,49.040000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<38.660000,0,81.230000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<36.120000,0,81.230000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<33.580000,0,81.230000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<31.040000,0,81.230000> texture{col_thl}}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.040000,-1.535000,10.040000>}
box{<0,0,-0.127000><0.360555,0.035000,0.127000> rotate<0,19.438752,0> translate<12.700000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.160000,-1.535000,10.160000> }
}cylinder{<13.040000,1,10.040000><13.040000,-2.500000,10.040000>1.905000 texture{col_thl}}}
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.660000,-1.535000,10.040000>}
box{<0,0,-0.127000><1.633432,0.035000,0.127000> rotate<0,-44.749014,0> translate<63.500000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.660000,-1.535000,10.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,10.160000>}
box{<0,0,-0.127000><0.162788,0.035000,0.127000> rotate<0,-47.486419,0> translate<64.660000,-1.535000,10.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,19.050000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,90.000000,0> translate<64.770000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,8.890000>}
box{<0,0,-0.127000><19.050000,0.035000,0.127000> rotate<0,0.000000,0> translate<44.450000,-1.535000,8.890000> }
}cylinder{<64.660000,1,10.040000><64.660000,-2.500000,10.040000>1.905000 texture{col_thl}}}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,17.780000>}
box{<0,0,-0.127000><40.640000,0.035000,0.127000> rotate<0,-90.000000,0> translate<2.540000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,17.780000>}
box{<0,0,-0.127000><15.240000,0.035000,0.127000> rotate<0,-90.000000,0> translate<3.810000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<3.810000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,34.290000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<3.810000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,78.740000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<5.080000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.150000,-1.535000,35.120000>}
box{<0,0,-0.127000><1.354179,0.035000,0.127000> rotate<0,-37.798272,0> translate<5.080000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.150000,-1.535000,19.880000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,19.050000>}
box{<0,0,-0.127000><0.853756,0.035000,0.127000> rotate<0,76.447015,0> translate<6.150000,-1.535000,19.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.150000,-1.535000,35.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,34.290000>}
box{<0,0,-0.127000><0.853756,0.035000,0.127000> rotate<0,76.447015,0> translate<6.150000,-1.535000,35.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.150000,-1.535000,35.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,35.560000>}
box{<0,0,-0.127000><0.483322,0.035000,0.127000> rotate<0,-65.551719,0> translate<6.150000,-1.535000,35.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,57.150000>}
box{<0,0,-0.127000><21.590000,0.035000,0.127000> rotate<0,90.000000,0> translate<6.350000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,81.280000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.080000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.740000,-1.535000,79.040000>}
box{<0,0,-0.127000><0.492037,0.035000,0.127000> rotate<0,-37.566113,0> translate<6.350000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,81.280000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.350000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,10.160000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,44.997030,0> translate<2.540000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,19.050000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.350000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,78.740000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.350000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,16.510000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<5.080000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.340000,-1.535000,56.950000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,57.150000>}
box{<0,0,-0.127000><0.219317,0.035000,0.127000> rotate<0,-65.767914,0> translate<11.340000,-1.535000,56.950000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,57.150000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,90.000000,0> translate<11.430000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.340000,-1.535000,59.490000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,59.690000>}
box{<0,0,-0.127000><0.219317,0.035000,0.127000> rotate<0,-65.767914,0> translate<11.340000,-1.535000,59.490000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,77.470000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,78.740000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<8.890000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.550000,-1.535000,49.040000>}
box{<0,0,-0.127000><0.504480,0.035000,0.127000> rotate<0,76.234183,0> translate<11.430000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.820000,-1.535000,79.040000>}
box{<0,0,-0.127000><0.492037,0.035000,0.127000> rotate<0,-37.566113,0> translate<11.430000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.550000,-1.535000,46.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,46.990000>}
box{<0,0,-0.127000><1.250040,0.035000,0.127000> rotate<0,-23.076698,0> translate<11.550000,-1.535000,46.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,46.990000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,90.000000,0> translate<12.700000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.880000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.664831,0.035000,0.127000> rotate<0,74.286459,0> translate<12.700000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,69.850000>}
box{<0,0,-0.127000><16.164461,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.540000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,69.850000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,44.997030,0> translate<5.080000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,41.910000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.240000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.420000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.664831,0.035000,0.127000> rotate<0,74.286459,0> translate<15.240000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,67.310000>}
box{<0,0,-0.127000><14.368410,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.350000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,38.100000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<17.780000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,46.990000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.700000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,59.690000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.960000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.664831,0.035000,0.127000> rotate<0,74.286459,0> translate<17.780000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,78.740000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.290000,-1.535000,78.960000>}
box{<0,0,-0.127000><0.325576,0.035000,0.127000> rotate<0,-42.507642,0> translate<19.050000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,7.620000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,44.997030,0> translate<11.430000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,8.890000>}
box{<0,0,-0.127000><14.368410,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,67.310000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.510000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,69.850000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.460000,-1.535000,67.340000>}
box{<0,0,-0.127000><0.870517,0.035000,0.127000> rotate<0,-1.974804,0> translate<21.590000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.460000,-1.535000,69.880000>}
box{<0,0,-0.127000><0.870517,0.035000,0.127000> rotate<0,-1.974804,0> translate<21.590000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,8.890000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,21.590000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.460000,-1.535000,67.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,67.310000>}
box{<0,0,-0.127000><0.401123,0.035000,0.127000> rotate<0,4.288870,0> translate<22.460000,-1.535000,67.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.460000,-1.535000,72.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,72.390000>}
box{<0,0,-0.127000><0.401123,0.035000,0.127000> rotate<0,4.288870,0> translate<22.460000,-1.535000,72.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,77.470000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,77.470000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.860000,-1.535000,77.470000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,77.470000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,80.010000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.860000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,21.590000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.130000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,78.740000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.130000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,83.820000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.050000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.370000,-1.535000,78.960000>}
box{<0,0,-0.127000><0.325576,0.035000,0.127000> rotate<0,-42.507642,0> translate<24.130000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,22.860000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.130000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,34.290000>}
box{<0,0,-0.127000><19.050000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.350000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,50.800000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,69.850000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.860000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,72.390000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<24.130000,-1.535000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,72.390000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<25.400000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,80.010000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.860000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.000000,-1.535000,43.190000>}
box{<0,0,-0.127000><0.600083,0.035000,0.127000> rotate<0,-0.954778,0> translate<25.400000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.000000,-1.535000,50.810000>}
box{<0,0,-0.127000><0.600083,0.035000,0.127000> rotate<0,-0.954778,0> translate<25.400000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.040000,-1.535000,34.480000>}
box{<0,0,-0.127000><0.667608,0.035000,0.127000> rotate<0,-16.533747,0> translate<25.400000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.040000,-1.535000,19.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,19.050000>}
box{<0,0,-0.127000><0.658027,0.035000,0.127000> rotate<0,16.781537,0> translate<26.040000,-1.535000,19.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.040000,-1.535000,19.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,20.320000>}
box{<0,0,-0.127000><1.250320,0.035000,0.127000> rotate<0,-59.739620,0> translate<26.040000,-1.535000,19.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,22.860000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<25.400000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,43.180000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<25.400000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,68.580000>}
box{<0,0,-0.127000><12.572359,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,68.580000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.670000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,78.740000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<25.400000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,10.160000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<24.130000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,43.180000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<26.670000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,12.700000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<29.210000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,16.510000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<26.670000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.660000,-1.535000,72.210000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,72.390000>}
box{<0,0,-0.127000><0.578705,0.035000,0.127000> rotate<0,-18.120664,0> translate<28.660000,-1.535000,72.210000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.660000,-1.535000,74.750000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,74.930000>}
box{<0,0,-0.127000><0.578705,0.035000,0.127000> rotate<0,-18.120664,0> translate<28.660000,-1.535000,74.750000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,74.930000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<29.210000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.240000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.610737,0.035000,0.127000> rotate<0,87.178689,0> translate<29.210000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<27.940000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,10.160000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,-90.000000,0> translate<30.480000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,80.010000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.210000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.040000,-1.535000,81.230000>}
box{<0,0,-0.127000><1.342386,0.035000,0.127000> rotate<0,-65.339789,0> translate<30.480000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,8.890000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.860000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,57.150000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.400000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.780000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.610737,0.035000,0.127000> rotate<0,87.178689,0> translate<31.750000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,7.620000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<31.750000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,38.100000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<27.940000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,57.150000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.720000,-1.535000,57.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,57.150000>}
box{<0,0,-0.127000><0.417253,0.035000,0.127000> rotate<0,44.026072,0> translate<32.720000,-1.535000,57.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,59.690000>}
box{<0,0,-0.127000><25.144717,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.240000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.180000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.659697,0.035000,0.127000> rotate<0,75.958743,0> translate<33.020000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.580000,-1.535000,81.230000>}
box{<0,0,-0.127000><1.342386,0.035000,0.127000> rotate<0,-65.339789,0> translate<33.020000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,11.430000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<31.750000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.320000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.660681,0.035000,0.127000> rotate<0,-87.391670,0> translate<34.290000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,13.970000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<33.020000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,34.290000>}
box{<0,0,-0.127000><17.960512,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.860000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,36.830000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<35.560000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,43.180000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<35.560000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,57.150000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<33.020000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.260000,-1.535000,57.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,57.150000>}
box{<0,0,-0.127000><0.417253,0.035000,0.127000> rotate<0,44.026072,0> translate<35.260000,-1.535000,57.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,64.770000>}
box{<0,0,-0.127000><25.144717,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.260000,-1.535000,65.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,64.770000>}
box{<0,0,-0.127000><0.417253,0.035000,0.127000> rotate<0,44.026072,0> translate<35.260000,-1.535000,65.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,72.390000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.720000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.650000,0.035000,0.127000> rotate<0,-75.744968,0> translate<35.560000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.720000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.659697,0.035000,0.127000> rotate<0,75.958743,0> translate<35.560000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.120000,-1.535000,81.230000>}
box{<0,0,-0.127000><1.342386,0.035000,0.127000> rotate<0,-65.339789,0> translate<35.560000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,11.430000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<33.020000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,12.700000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<35.560000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,63.500000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<35.560000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.860000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.660681,0.035000,0.127000> rotate<0,-87.391670,0> translate<36.830000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.860000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.610737,0.035000,0.127000> rotate<0,87.178689,0> translate<36.830000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,10.160000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<36.830000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,38.100000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<38.100000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.800000,-1.535000,65.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,66.040000>}
box{<0,0,-0.127000><1.024890,0.035000,0.127000> rotate<0,-72.974658,0> translate<37.800000,-1.535000,65.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,69.850000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<35.560000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,74.930000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<33.020000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,83.820000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,0.000000,0> translate<24.130000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.260000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.659697,0.035000,0.127000> rotate<0,75.958743,0> translate<38.100000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.660000,-1.535000,71.860000>}
box{<0,0,-0.127000><0.771038,0.035000,0.127000> rotate<0,43.420584,0> translate<38.100000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.660000,-1.535000,74.400000>}
box{<0,0,-0.127000><0.771038,0.035000,0.127000> rotate<0,43.420584,0> translate<38.100000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,12.700000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<39.370000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,80.010000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,76.200000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<35.560000,-1.535000,80.010000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.660000,-1.535000,81.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,81.280000>}
box{<0,0,-0.127000><0.711758,0.035000,0.127000> rotate<0,-4.027998,0> translate<38.660000,-1.535000,81.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.400000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.610737,0.035000,0.127000> rotate<0,87.178689,0> translate<39.370000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.610000,-1.535000,43.500000>}
box{<0,0,-0.127000><0.400000,0.035000,0.127000> rotate<0,-53.126596,0> translate<39.370000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.610000,-1.535000,51.120000>}
box{<0,0,-0.127000><0.400000,0.035000,0.127000> rotate<0,-53.126596,0> translate<39.370000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.100000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,62.230000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,83.820000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,81.280000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<38.100000,-1.535000,83.820000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,81.280000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<39.370000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.640000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,12.700000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<41.910000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,38.100000>}
box{<0,0,-0.127000><21.552615,0.035000,0.127000> rotate<0,-44.997030,0> translate<26.670000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,40.640000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<39.370000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,40.640000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<41.910000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,66.040000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.100000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.940000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.660681,0.035000,0.127000> rotate<0,-87.391670,0> translate<41.910000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.940000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.610737,0.035000,0.127000> rotate<0,87.178689,0> translate<41.910000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.910000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,8.890000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<41.910000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,55.880000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,55.880000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<44.450000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,60.960000>}
box{<0,0,-0.127000><25.144717,0.035000,0.127000> rotate<0,-44.997030,0> translate<26.670000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,68.580000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.910000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,72.390000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.100000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.480000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.660681,0.035000,0.127000> rotate<0,-87.391670,0> translate<44.450000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.560000,-1.535000,57.440000>}
box{<0,0,-0.127000><0.310161,0.035000,0.127000> rotate<0,-69.223177,0> translate<44.450000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,10.160000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<44.450000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,19.050000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.180000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,38.100000>}
box{<0,0,-0.127000><21.552615,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,63.500000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<36.830000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,69.850000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.100000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,81.280000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.850000,-1.535000,19.200000>}
box{<0,0,-0.127000><0.198494,0.035000,0.127000> rotate<0,-49.082377,0> translate<45.720000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.850000,-1.535000,34.440000>}
box{<0,0,-0.127000><0.198494,0.035000,0.127000> rotate<0,-49.082377,0> translate<45.720000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,12.700000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<43.180000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,54.610000>}
box{<0,0,-0.127000><16.164461,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,57.150000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<46.990000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,59.690000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.450000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,64.770000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<45.720000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,71.120000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<45.720000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,74.930000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.450000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.020000,-1.535000,12.090000>}
box{<0,0,-0.127000><0.610737,0.035000,0.127000> rotate<0,87.178689,0> translate<46.990000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.100000,-1.535000,57.440000>}
box{<0,0,-0.127000><0.310161,0.035000,0.127000> rotate<0,-69.223177,0> translate<46.990000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.100000,-1.535000,65.060000>}
box{<0,0,-0.127000><0.310161,0.035000,0.127000> rotate<0,-69.223177,0> translate<46.990000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.110000,-1.535000,72.190000>}
box{<0,0,-0.127000><1.076708,0.035000,0.127000> rotate<0,-83.595526,0> translate<46.990000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,54.610000>}
box{<0,0,-0.127000><14.368410,0.035000,0.127000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,54.610000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<48.260000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,58.420000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<46.990000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,60.960000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<44.450000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,62.230000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,76.200000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<39.370000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,62.230000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<46.990000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,72.390000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<46.990000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.640000,-1.535000,65.060000>}
box{<0,0,-0.127000><0.986154,0.035000,0.127000> rotate<0,83.590130,0> translate<49.530000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.650000,-1.535000,72.190000>}
box{<0,0,-0.127000><0.233238,0.035000,0.127000> rotate<0,59.032347,0> translate<49.530000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,38.100000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.720000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,38.100000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<50.800000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,54.610000>}
box{<0,0,-0.127000><16.164461,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,54.610000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<50.800000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,58.420000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<48.260000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,10.160000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.720000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,38.100000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.800000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,39.370000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<52.070000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,45.720000>}
box{<0,0,-0.127000><35.921024,0.035000,0.127000> rotate<0,-44.997030,0> translate<26.670000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,45.720000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,-90.000000,0> translate<52.070000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,58.420000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<48.260000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,76.200000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,72.390000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<48.260000,-1.535000,76.200000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,81.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,74.930000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,44.997030,0> translate<45.720000,-1.535000,81.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.190000,-1.535000,72.190000>}
box{<0,0,-0.127000><0.233238,0.035000,0.127000> rotate<0,59.032347,0> translate<52.070000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.480000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.760066,0.035000,0.127000> rotate<0,57.351575,0> translate<52.070000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.800000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,45.720000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<50.800000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,45.720000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.340000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,52.070000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.340000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,62.230000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<49.530000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,66.040000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<49.530000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,34.290000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.720000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,36.830000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<54.610000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,52.070000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<53.340000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,52.070000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<54.610000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,68.580000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<44.450000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,72.390000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<52.070000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.730000,-1.535000,72.190000>}
box{<0,0,-0.127000><0.233238,0.035000,0.127000> rotate<0,59.032347,0> translate<54.610000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.020000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.751665,0.035000,0.127000> rotate<0,-56.940419,0> translate<54.610000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,43.180000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<52.070000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.610000,-1.535000,43.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,43.180000>}
box{<0,0,-0.127000><0.550727,0.035000,0.127000> rotate<0,60.638244,0> translate<55.610000,-1.535000,43.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,43.180000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<55.880000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,49.530000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<53.340000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.610000,-1.535000,51.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,50.800000>}
box{<0,0,-0.127000><0.550727,0.035000,0.127000> rotate<0,60.638244,0> translate<55.610000,-1.535000,51.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,50.800000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<55.880000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,59.690000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<54.610000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,62.230000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<53.340000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<56.400000,-1.535000,57.440000>}
box{<0,0,-0.127000><0.595399,0.035000,0.127000> rotate<0,-29.146148,0> translate<55.880000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,34.290000>}
box{<0,0,-0.127000><25.144717,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,34.290000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<54.610000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,38.100000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,-90.000000,0> translate<57.150000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,49.530000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<55.880000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,69.850000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<53.340000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,71.120000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<54.610000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.270000,-1.535000,72.190000>}
box{<0,0,-0.127000><1.076708,0.035000,0.127000> rotate<0,-83.595526,0> translate<57.150000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.560000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.760066,0.035000,0.127000> rotate<0,57.351575,0> translate<57.150000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,57.150000>}
box{<0,0,-0.127000><17.780000,0.035000,0.127000> rotate<0,90.000000,0> translate<58.420000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,64.770000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<55.880000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,69.850000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<57.150000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,57.150000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.940000,-1.535000,57.440000>}
box{<0,0,-0.127000><0.595399,0.035000,0.127000> rotate<0,-29.146148,0> translate<58.420000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,64.770000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.940000,-1.535000,65.060000>}
box{<0,0,-0.127000><0.595399,0.035000,0.127000> rotate<0,-29.146148,0> translate<58.420000,-1.535000,64.770000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.150000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,36.830000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<57.150000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,38.100000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<58.420000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,38.100000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<59.690000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,71.120000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<58.420000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.810000,-1.535000,72.190000>}
box{<0,0,-0.127000><1.076708,0.035000,0.127000> rotate<0,-83.595526,0> translate<59.690000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,59.690000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<55.880000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,66.040000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<60.960000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<61.480000,-1.535000,65.060000>}
box{<0,0,-0.127000><1.109414,0.035000,0.127000> rotate<0,62.044936,0> translate<60.960000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,69.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,71.120000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<60.960000,-1.535000,69.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,74.930000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<52.070000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.350000,-1.535000,72.190000>}
box{<0,0,-0.127000><1.076708,0.035000,0.127000> rotate<0,-83.595526,0> translate<62.230000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.960000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,57.150000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<60.960000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,57.150000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<63.500000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,67.310000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<63.500000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-1.535000,74.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,73.660000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<62.230000,-1.535000,74.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,53.340000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<63.500000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,54.610000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,-90.000000,0> translate<64.770000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,62.230000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<55.880000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.850000,-1.535000,19.520000>}
box{<0,0,-0.127000><0.476760,0.035000,0.127000> rotate<0,-80.334805,0> translate<64.770000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.850000,-1.535000,34.760000>}
box{<0,0,-0.127000><0.476760,0.035000,0.127000> rotate<0,-80.334805,0> translate<64.770000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.890000,-1.535000,72.190000>}
box{<0,0,-0.127000><1.076708,0.035000,0.127000> rotate<0,-83.595526,0> translate<64.770000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,54.610000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.770000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,54.610000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<66.040000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.500000,-1.535000,67.310000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,63.500000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<63.500000,-1.535000,67.310000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.240000,-1.535000,57.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,57.150000>}
box{<0,0,-0.127000><0.446878,0.035000,0.127000> rotate<0,40.459557,0> translate<68.240000,-1.535000,57.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,57.150000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<68.580000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,62.230000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.770000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,63.500000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<67.310000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,71.120000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.770000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,62.230000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<66.040000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.850000,-1.535000,62.230000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<68.580000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.000000,-1.535000,43.190000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,43.180000>}
box{<0,0,-0.127000><0.120416,0.035000,0.127000> rotate<0,4.763327,0> translate<71.000000,-1.535000,43.190000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,43.180000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<71.120000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,43.180000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<71.120000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,48.260000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,44.997030,0> translate<64.770000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,50.800000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<68.580000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.000000,-1.535000,50.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,50.800000>}
box{<0,0,-0.127000><0.120416,0.035000,0.127000> rotate<0,4.763327,0> translate<71.000000,-1.535000,50.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.780000,-1.535000,57.440000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,57.150000>}
box{<0,0,-0.127000><0.446878,0.035000,0.127000> rotate<0,40.459557,0> translate<70.780000,-1.535000,57.440000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,57.150000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<71.120000,-1.535000,57.150000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,62.230000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,64.770000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<68.580000,-1.535000,62.230000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.780000,-1.535000,65.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,64.770000>}
box{<0,0,-0.127000><0.446878,0.035000,0.127000> rotate<0,40.459557,0> translate<70.780000,-1.535000,65.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.780000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.919348,0.035000,0.127000> rotate<0,44.115684,0> translate<71.120000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,71.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,66.040000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<68.580000,-1.535000,71.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.320000,-1.535000,65.060000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.660000,-1.535000,66.040000>}
box{<0,0,-0.127000><1.037304,0.035000,0.127000> rotate<0,-70.861680,0> translate<73.320000,-1.535000,65.060000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.770000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,34.290000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.770000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.320000,-1.535000,37.460000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,36.830000>}
box{<0,0,-0.127000><0.876926,0.035000,0.127000> rotate<0,45.921015,0> translate<74.320000,-1.535000,37.460000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,36.830000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<74.930000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,34.290000>}
box{<0,0,-0.127000><34.124973,0.035000,0.127000> rotate<0,-44.997030,0> translate<52.070000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.930000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,34.290000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.930000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,38.100000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,-90.000000,0> translate<76.200000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,45.720000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<71.120000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.860000,-1.535000,37.460000>}
box{<0,0,-0.127000><0.919348,0.035000,0.127000> rotate<0,44.115684,0> translate<76.200000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.470000,-1.535000,34.290000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<76.200000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.470000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,35.560000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<77.470000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.120000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,45.720000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,44.997030,0> translate<71.120000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.740000,-1.535000,45.720000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,90.000000,0> translate<78.740000,-1.535000,45.720000> }
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
cylinder{<47.110000,0.038000,72.190000><47.110000,-1.538000,72.190000>0.508000}
cylinder{<49.650000,0.038000,72.190000><49.650000,-1.538000,72.190000>0.508000}
cylinder{<52.190000,0.038000,72.190000><52.190000,-1.538000,72.190000>0.508000}
cylinder{<54.730000,0.038000,72.190000><54.730000,-1.538000,72.190000>0.508000}
cylinder{<57.270000,0.038000,72.190000><57.270000,-1.538000,72.190000>0.508000}
cylinder{<59.810000,0.038000,72.190000><59.810000,-1.538000,72.190000>0.508000}
cylinder{<62.350000,0.038000,72.190000><62.350000,-1.538000,72.190000>0.508000}
cylinder{<64.890000,0.038000,72.190000><64.890000,-1.538000,72.190000>0.508000}
cylinder{<24.370000,0.038000,78.960000><24.370000,-1.538000,78.960000>0.406400}
cylinder{<19.290000,0.038000,78.960000><19.290000,-1.538000,78.960000>0.406400}
cylinder{<6.740000,0.038000,79.040000><6.740000,-1.538000,79.040000>0.406400}
cylinder{<11.820000,0.038000,79.040000><11.820000,-1.538000,79.040000>0.406400}
cylinder{<64.850000,0.038000,34.760000><64.850000,-1.538000,34.760000>0.749300}
cylinder{<64.850000,0.038000,19.520000><64.850000,-1.538000,19.520000>0.749300}
cylinder{<45.850000,0.038000,34.440000><45.850000,-1.538000,34.440000>0.749300}
cylinder{<45.850000,0.038000,19.200000><45.850000,-1.538000,19.200000>0.749300}
cylinder{<6.150000,0.038000,19.880000><6.150000,-1.538000,19.880000>0.749300}
cylinder{<6.150000,0.038000,35.120000><6.150000,-1.538000,35.120000>0.749300}
cylinder{<26.040000,0.038000,19.240000><26.040000,-1.538000,19.240000>0.749300}
cylinder{<26.040000,0.038000,34.480000><26.040000,-1.538000,34.480000>0.749300}
cylinder{<22.460000,0.038000,69.880000><22.460000,-1.538000,69.880000>0.508000}
cylinder{<22.460000,0.038000,67.340000><22.460000,-1.538000,67.340000>0.508000}
cylinder{<22.460000,0.038000,72.420000><22.460000,-1.538000,72.420000>0.508000}
cylinder{<47.020000,0.038000,12.090000><47.020000,-1.538000,12.090000>0.508000}
cylinder{<44.480000,0.038000,12.090000><44.480000,-1.538000,12.090000>0.508000}
cylinder{<41.940000,0.038000,12.090000><41.940000,-1.538000,12.090000>0.508000}
cylinder{<39.400000,0.038000,12.090000><39.400000,-1.538000,12.090000>0.508000}
cylinder{<36.860000,0.038000,12.090000><36.860000,-1.538000,12.090000>0.508000}
cylinder{<34.320000,0.038000,12.090000><34.320000,-1.538000,12.090000>0.508000}
cylinder{<31.780000,0.038000,12.090000><31.780000,-1.538000,12.090000>0.508000}
cylinder{<29.240000,0.038000,12.090000><29.240000,-1.538000,12.090000>0.508000}
cylinder{<73.320000,0.038000,65.060000><73.320000,-1.538000,65.060000>0.406400}
cylinder{<70.780000,0.038000,65.060000><70.780000,-1.538000,65.060000>0.406400}
cylinder{<68.240000,0.038000,65.060000><68.240000,-1.538000,65.060000>0.406400}
cylinder{<68.240000,0.038000,57.440000><68.240000,-1.538000,57.440000>0.406400}
cylinder{<70.780000,0.038000,57.440000><70.780000,-1.538000,57.440000>0.406400}
cylinder{<73.320000,0.038000,57.440000><73.320000,-1.538000,57.440000>0.406400}
cylinder{<61.480000,0.038000,65.060000><61.480000,-1.538000,65.060000>0.406400}
cylinder{<58.940000,0.038000,65.060000><58.940000,-1.538000,65.060000>0.406400}
cylinder{<56.400000,0.038000,65.060000><56.400000,-1.538000,65.060000>0.406400}
cylinder{<56.400000,0.038000,57.440000><56.400000,-1.538000,57.440000>0.406400}
cylinder{<58.940000,0.038000,57.440000><58.940000,-1.538000,57.440000>0.406400}
cylinder{<61.480000,0.038000,57.440000><61.480000,-1.538000,57.440000>0.406400}
cylinder{<49.640000,0.038000,65.060000><49.640000,-1.538000,65.060000>0.406400}
cylinder{<47.100000,0.038000,65.060000><47.100000,-1.538000,65.060000>0.406400}
cylinder{<44.560000,0.038000,65.060000><44.560000,-1.538000,65.060000>0.406400}
cylinder{<44.560000,0.038000,57.440000><44.560000,-1.538000,57.440000>0.406400}
cylinder{<47.100000,0.038000,57.440000><47.100000,-1.538000,57.440000>0.406400}
cylinder{<49.640000,0.038000,57.440000><49.640000,-1.538000,57.440000>0.406400}
cylinder{<37.800000,0.038000,65.060000><37.800000,-1.538000,65.060000>0.406400}
cylinder{<35.260000,0.038000,65.060000><35.260000,-1.538000,65.060000>0.406400}
cylinder{<32.720000,0.038000,65.060000><32.720000,-1.538000,65.060000>0.406400}
cylinder{<32.720000,0.038000,57.440000><32.720000,-1.538000,57.440000>0.406400}
cylinder{<35.260000,0.038000,57.440000><35.260000,-1.538000,57.440000>0.406400}
cylinder{<37.800000,0.038000,57.440000><37.800000,-1.538000,57.440000>0.406400}
cylinder{<11.340000,0.038000,56.950000><11.340000,-1.538000,56.950000>0.350000}
cylinder{<11.340000,0.038000,59.490000><11.340000,-1.538000,59.490000>0.350000}
cylinder{<74.320000,0.038000,37.460000><74.320000,-1.538000,37.460000>0.558800}
cylinder{<76.860000,0.038000,37.460000><76.860000,-1.538000,37.460000>0.558800}
cylinder{<71.780000,0.038000,37.460000><71.780000,-1.538000,37.460000>0.558800}
cylinder{<55.020000,0.038000,37.460000><55.020000,-1.538000,37.460000>0.558800}
cylinder{<57.560000,0.038000,37.460000><57.560000,-1.538000,37.460000>0.558800}
cylinder{<52.480000,0.038000,37.460000><52.480000,-1.538000,37.460000>0.558800}
cylinder{<35.720000,0.038000,37.460000><35.720000,-1.538000,37.460000>0.558800}
cylinder{<38.260000,0.038000,37.460000><38.260000,-1.538000,37.460000>0.558800}
cylinder{<33.180000,0.038000,37.460000><33.180000,-1.538000,37.460000>0.558800}
cylinder{<15.420000,0.038000,37.460000><15.420000,-1.538000,37.460000>0.558800}
cylinder{<17.960000,0.038000,37.460000><17.960000,-1.538000,37.460000>0.558800}
cylinder{<12.880000,0.038000,37.460000><12.880000,-1.538000,37.460000>0.558800}
cylinder{<71.000000,0.038000,43.190000><71.000000,-1.538000,43.190000>0.406400}
cylinder{<71.000000,0.038000,50.810000><71.000000,-1.538000,50.810000>0.406400}
cylinder{<55.610000,0.038000,43.660000><55.610000,-1.538000,43.660000>0.406400}
cylinder{<55.610000,0.038000,51.280000><55.610000,-1.538000,51.280000>0.406400}
cylinder{<39.610000,0.038000,43.500000><39.610000,-1.538000,43.500000>0.406400}
cylinder{<39.610000,0.038000,51.120000><39.610000,-1.538000,51.120000>0.406400}
cylinder{<26.000000,0.038000,43.190000><26.000000,-1.538000,43.190000>0.406400}
cylinder{<26.000000,0.038000,50.810000><26.000000,-1.538000,50.810000>0.406400}
cylinder{<38.660000,0.038000,74.400000><38.660000,-1.538000,74.400000>0.350000}
cylinder{<38.660000,0.038000,71.860000><38.660000,-1.538000,71.860000>0.350000}
cylinder{<28.660000,0.038000,74.750000><28.660000,-1.538000,74.750000>0.350000}
cylinder{<28.660000,0.038000,72.210000><28.660000,-1.538000,72.210000>0.350000}
cylinder{<11.550000,0.038000,46.500000><11.550000,-1.538000,46.500000>0.500000}
cylinder{<11.550000,0.038000,49.040000><11.550000,-1.538000,49.040000>0.500000}
cylinder{<38.660000,0.038000,81.230000><38.660000,-1.538000,81.230000>0.508000}
cylinder{<36.120000,0.038000,81.230000><36.120000,-1.538000,81.230000>0.508000}
cylinder{<33.580000,0.038000,81.230000><33.580000,-1.538000,81.230000>0.508000}
cylinder{<31.040000,0.038000,81.230000><31.040000,-1.538000,81.230000>0.508000}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//+11,1V__BATERIA silk screen
difference{
cylinder{<64.660000,0,10.040000><64.660000,0.036000,10.040000>1.079500 translate<0,0.000000,0>}
cylinder{<64.660000,-0.1,10.040000><64.660000,0.135000,10.040000>0.952500 translate<0,0.000000,0>}}
//ARDUINO silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.840000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.380000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.840000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.380000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.380000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.380000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.380000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.840000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.840000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.840000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.840000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.840000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<47.110000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<47.110000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<47.110000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.380000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.920000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.380000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.920000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.920000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.920000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.920000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.380000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.380000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<49.650000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<49.650000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<49.650000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.920000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.920000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.460000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.920000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.920000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<52.190000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<52.190000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<52.190000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.460000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.000000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.460000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<54.730000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<54.730000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<54.730000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.000000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.540000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.000000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<57.270000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<57.270000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<57.270000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.080000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.540000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.080000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.080000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.080000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.080000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.540000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<59.810000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<59.810000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<59.810000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.080000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.620000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.080000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.620000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.620000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.620000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.620000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.080000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.080000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.350000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.350000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<62.350000,0.000000,77.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.620000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.160000,0.000000,74.095000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.620000,0.000000,74.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.160000,0.000000,74.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.160000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.160000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.160000,0.000000,76.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.620000,0.000000,76.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.620000,0.000000,76.635000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<64.890000,0.000000,82.985000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<64.890000,0.000000,77.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<64.890000,0.000000,77.270000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<47.110000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<49.650000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<52.190000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<54.730000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<57.270000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<59.810000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<62.350000,0.000000,76.889000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<64.890000,0.000000,76.889000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<47.110000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<49.650000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<52.190000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<54.730000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<57.270000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<59.810000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<62.350000,0.000000,73.587000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<64.890000,0.000000,73.587000>}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.134800,0.000000,78.325000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.134800,0.000000,78.960000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<22.134800,0.000000,78.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.134800,0.000000,78.960000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<22.134800,0.000000,79.595000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<22.134800,0.000000,79.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.134800,0.000000,78.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.354000,0.000000,78.960000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<22.134800,0.000000,78.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.499800,0.000000,78.325000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.499800,0.000000,78.960000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<21.499800,0.000000,78.960000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.499800,0.000000,78.960000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<21.499800,0.000000,79.595000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<21.499800,0.000000,79.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.499800,0.000000,78.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.306000,0.000000,78.960000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<20.306000,0.000000,78.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.513000,0.000000,77.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.513000,0.000000,80.230000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.513000,0.000000,80.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.259000,0.000000,80.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.401000,0.000000,80.484000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.401000,0.000000,80.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.147000,0.000000,80.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.147000,0.000000,77.690000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.147000,0.000000,77.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.401000,0.000000,77.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.259000,0.000000,77.436000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.401000,0.000000,77.436000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<18.401000,0.000000,77.690000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<18.401000,0.000000,80.230000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<25.259000,0.000000,80.230000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<25.259000,0.000000,77.690000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.975200,0.000000,79.675000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.975200,0.000000,79.040000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<8.975200,0.000000,79.040000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.975200,0.000000,79.040000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.975200,0.000000,78.405000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<8.975200,0.000000,78.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.975200,0.000000,79.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.756000,0.000000,79.040000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<7.756000,0.000000,79.040000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.610200,0.000000,79.675000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.610200,0.000000,79.040000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<9.610200,0.000000,79.040000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.610200,0.000000,79.040000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.610200,0.000000,78.405000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<9.610200,0.000000,78.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.610200,0.000000,79.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.804000,0.000000,79.040000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<9.610200,0.000000,79.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.597000,0.000000,80.310000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.597000,0.000000,77.770000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.597000,0.000000,77.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.851000,0.000000,77.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.709000,0.000000,77.516000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.851000,0.000000,77.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.963000,0.000000,77.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.963000,0.000000,80.310000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.963000,0.000000,80.310000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.709000,0.000000,80.564000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.851000,0.000000,80.564000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.851000,0.000000,80.564000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<12.709000,0.000000,80.310000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<12.709000,0.000000,77.770000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<5.851000,0.000000,77.770000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<5.851000,0.000000,80.310000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,25.870000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,27.140000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.850000,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.265800,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,27.140000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<64.265800,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.265800,0.000000,28.283000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<64.265800,0.000000,28.283000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.265800,0.000000,28.283000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.434200,0.000000,28.283000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<64.265800,0.000000,28.283000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.434200,0.000000,28.283000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,27.140000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<64.850000,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,29.426000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.850000,0.000000,29.426000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.850000,0.000000,27.140000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.434200,0.000000,27.140000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<64.850000,0.000000,27.140000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.644000,0.000000,22.060000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.056000,0.000000,22.060000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.056000,0.000000,22.060000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.056000,0.000000,32.220000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.644000,0.000000,32.220000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.056000,0.000000,32.220000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.056000,0.000000,22.060000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.056000,0.000000,32.220000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.056000,0.000000,32.220000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.644000,0.000000,32.220000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.644000,0.000000,22.060000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.644000,0.000000,22.060000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<64.850000,0.000000,34.760000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<64.850000,0.000000,33.363000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<64.850000,0.000000,33.363000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<64.850000,0.000000,19.520000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<64.850000,0.000000,20.917000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<64.850000,0.000000,20.917000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<64.850000,0.000000,23.330000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<64.850000,0.000000,21.615500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<64.850000,0.000000,32.664500>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,25.550000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,26.820000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.850000,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.265800,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,26.820000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<45.265800,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.265800,0.000000,27.963000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<45.265800,0.000000,27.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.265800,0.000000,27.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.434200,0.000000,27.963000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<45.265800,0.000000,27.963000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.434200,0.000000,27.963000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,26.820000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<45.850000,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,29.106000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.850000,0.000000,29.106000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.850000,0.000000,26.820000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.434200,0.000000,26.820000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<45.850000,0.000000,26.820000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.644000,0.000000,21.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.056000,0.000000,21.740000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.056000,0.000000,21.740000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.056000,0.000000,31.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.644000,0.000000,31.900000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.056000,0.000000,31.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.056000,0.000000,21.740000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.056000,0.000000,31.900000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.056000,0.000000,31.900000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.644000,0.000000,31.900000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.644000,0.000000,21.740000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.644000,0.000000,21.740000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<45.850000,0.000000,34.440000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<45.850000,0.000000,33.043000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<45.850000,0.000000,33.043000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<45.850000,0.000000,19.200000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<45.850000,0.000000,20.597000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<45.850000,0.000000,20.597000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<45.850000,0.000000,23.010000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<45.850000,0.000000,21.295500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<45.850000,0.000000,32.344500>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,28.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,27.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.150000,0.000000,27.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.734200,0.000000,27.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,27.500000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<6.150000,0.000000,27.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,27.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.734200,0.000000,26.357000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<6.150000,0.000000,27.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.734200,0.000000,26.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.565800,0.000000,26.357000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<5.565800,0.000000,26.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.565800,0.000000,26.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,27.500000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<5.565800,0.000000,26.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,27.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,25.214000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.150000,0.000000,25.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.150000,0.000000,27.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.565800,0.000000,27.500000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<5.565800,0.000000,27.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.356000,0.000000,32.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.944000,0.000000,32.580000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.356000,0.000000,32.580000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.944000,0.000000,22.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.356000,0.000000,22.420000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.356000,0.000000,22.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.944000,0.000000,32.580000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.944000,0.000000,22.420000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.944000,0.000000,22.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.356000,0.000000,22.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.356000,0.000000,32.580000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.356000,0.000000,32.580000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<6.150000,0.000000,19.880000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<6.150000,0.000000,21.277000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<6.150000,0.000000,21.277000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<6.150000,0.000000,35.120000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<6.150000,0.000000,33.723000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<6.150000,0.000000,33.723000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-270.000000,0> translate<6.150000,0.000000,31.310000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<6.150000,0.000000,33.024500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<6.150000,0.000000,21.975500>}
//D4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,28.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,26.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.040000,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.624200,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,26.860000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<26.040000,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.624200,0.000000,25.717000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<26.040000,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.624200,0.000000,25.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.455800,0.000000,25.717000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<25.455800,0.000000,25.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.455800,0.000000,25.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,26.860000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<25.455800,0.000000,25.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,24.574000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.040000,0.000000,24.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.040000,0.000000,26.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.455800,0.000000,26.860000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<25.455800,0.000000,26.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.246000,0.000000,31.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.834000,0.000000,31.940000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.246000,0.000000,31.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.834000,0.000000,21.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.246000,0.000000,21.780000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.246000,0.000000,21.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.834000,0.000000,31.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.834000,0.000000,21.780000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.834000,0.000000,21.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.246000,0.000000,21.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.246000,0.000000,31.940000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.246000,0.000000,31.940000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<26.040000,0.000000,19.240000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<26.040000,0.000000,20.637000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<26.040000,0.000000,20.637000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<26.040000,0.000000,34.480000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<26.040000,0.000000,33.083000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<26.040000,0.000000,33.083000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-270.000000,0> translate<26.040000,0.000000,30.670000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<26.040000,0.000000,32.384500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-270.000000,0> translate<26.040000,0.000000,21.335500>}
//GND__BATERIA silk screen
difference{
cylinder{<13.040000,0,10.040000><13.040000,0.036000,10.040000>1.079500 translate<0,0.000000,0>}
cylinder{<13.040000,-0.1,10.040000><13.040000,0.135000,10.040000>0.952500 translate<0,0.000000,0>}}
//LM7809 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.920000,0.000000,64.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.920000,0.000000,75.087000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.920000,0.000000,75.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.045000,0.000000,75.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.045000,0.000000,64.673000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,-90.000000,0> translate<4.045000,0.000000,64.673000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.920000,0.000000,75.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,75.087000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.474000,0.000000,75.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,75.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,74.198000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.474000,0.000000,74.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,74.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,74.198000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.950000,0.000000,74.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,74.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,75.087000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.950000,0.000000,75.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,75.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.045000,0.000000,75.087000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.045000,0.000000,75.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.920000,0.000000,64.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,64.673000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.474000,0.000000,64.673000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,64.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,65.562000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.474000,0.000000,65.562000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.474000,0.000000,65.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,65.562000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.950000,0.000000,65.562000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,65.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,64.673000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.950000,0.000000,64.673000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.950000,0.000000,64.673000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.045000,0.000000,64.673000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.045000,0.000000,64.673000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.285000,0.000000,65.308000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.285000,0.000000,74.452000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,90.000000,0> translate<19.285000,0.000000,74.452000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.030000,0.000000,74.452000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.285000,0.000000,74.452000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<11.030000,0.000000,74.452000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.030000,0.000000,74.452000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.030000,0.000000,65.308000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,-90.000000,0> translate<11.030000,0.000000,65.308000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.285000,0.000000,65.308000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.030000,0.000000,65.308000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<11.030000,0.000000,65.308000> }
difference{
cylinder{<7.474000,0,69.880000><7.474000,0.036000,69.880000>1.879600 translate<0,0.000000,0>}
cylinder{<7.474000,-0.1,69.880000><7.474000,0.135000,69.880000>1.727200 translate<0,0.000000,0>}}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<20.364500,0.000000,72.420000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<21.634500,0.000000,72.420000>}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<20.364500,0.000000,69.880000>}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<20.364500,0.000000,67.340000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<21.634500,0.000000,69.880000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<21.634500,0.000000,67.340000>}
//MOTORES silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.290000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.750000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.750000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.750000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.750000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.750000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.750000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.290000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.750000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.290000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.290000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.290000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<47.020000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<47.020000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<47.020000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.750000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.210000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.210000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.210000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.210000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.210000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.210000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.750000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.210000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<44.480000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<44.480000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<44.480000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.210000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.670000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.670000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.670000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.670000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.670000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.670000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.210000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.670000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<41.940000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<41.940000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<41.940000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.670000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.130000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.130000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.130000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.130000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.130000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.130000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.670000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.130000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<39.400000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<39.400000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<39.400000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.130000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.590000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.590000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.590000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.590000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.590000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.590000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.130000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.590000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<36.860000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<36.860000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<36.860000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.590000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.050000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.050000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.050000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.050000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.050000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.050000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.590000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.050000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<34.320000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<34.320000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<34.320000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.050000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.510000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.510000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.510000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.510000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.510000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.510000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.050000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.510000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<31.780000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<31.780000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<31.780000,0.000000,7.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.510000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.970000,0.000000,10.185000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.970000,0.000000,10.185000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.970000,0.000000,10.185000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.970000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.970000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.970000,0.000000,7.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.510000,0.000000,7.645000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.970000,0.000000,7.645000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<29.240000,0.000000,1.295000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<29.240000,0.000000,7.010000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,90.000000,0> translate<29.240000,0.000000,7.010000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<47.020000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<44.480000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<41.940000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<39.400000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<36.860000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<34.320000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<31.780000,0.000000,7.391000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<29.240000,0.000000,7.391000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<47.020000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<44.480000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<41.940000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<39.400000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<36.860000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<34.320000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<31.780000,0.000000,10.693000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<29.240000,0.000000,10.693000>}
//OK1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.970000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.590000,0.000000,58.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.970000,0.000000,58.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.590000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.970000,0.000000,64.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.970000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.970000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.970000,0.000000,64.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.970000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.590000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.590000,0.000000,60.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.590000,0.000000,60.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.590000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.590000,0.000000,62.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.590000,0.000000,62.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<74.590000,0.000000,61.250000>}
//OK2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.130000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.750000,0.000000,58.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.130000,0.000000,58.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.750000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.130000,0.000000,64.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.130000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.130000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.130000,0.000000,64.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.130000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.750000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.750000,0.000000,60.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.750000,0.000000,60.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.750000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.750000,0.000000,62.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.750000,0.000000,62.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<62.750000,0.000000,61.250000>}
//OK3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,58.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.290000,0.000000,58.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,64.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.290000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.290000,0.000000,64.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.290000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,60.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.910000,0.000000,60.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.910000,0.000000,62.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.910000,0.000000,62.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<50.910000,0.000000,61.250000>}
//OK4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.450000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.070000,0.000000,58.329000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.450000,0.000000,58.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.070000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.450000,0.000000,64.171000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.450000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.450000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.450000,0.000000,64.171000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.450000,0.000000,64.171000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.070000,0.000000,58.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.070000,0.000000,60.234000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.070000,0.000000,60.234000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.070000,0.000000,64.171000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.070000,0.000000,62.266000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.070000,0.000000,62.266000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<39.070000,0.000000,61.250000>}
//POWER silk screen
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.113000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.113000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.113000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.002000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.113000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.002000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.002000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.002000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.002000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.113000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.113000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.113000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.527000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.638000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.638000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.638000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.638000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.638000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.638000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<78.638000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.527000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.527000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<78.892000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.748000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<69.748000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.748000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.748000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<69.748000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.748000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<78.892000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<69.748000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<78.892000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<78.892000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<78.892000,0.000000,23.490000> }
difference{
cylinder{<74.320000,0,19.934000><74.320000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<74.320000,-0.1,19.934000><74.320000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<71.780000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<74.320000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<76.860000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<76.860000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<74.320000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<71.780000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<76.860000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<74.320000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<71.780000,0.000000,36.761500>}
//Q2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.813000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.813000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.813000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.702000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.813000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.702000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.702000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.702000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.702000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.813000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.813000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.813000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.227000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.338000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.338000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.338000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.338000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.338000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.338000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.338000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.227000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.227000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<59.592000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<50.448000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<50.448000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<50.448000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<50.448000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<50.448000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<50.448000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<59.592000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<50.448000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<59.592000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<59.592000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<59.592000,0.000000,23.490000> }
difference{
cylinder{<55.020000,0,19.934000><55.020000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<55.020000,-0.1,19.934000><55.020000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<52.480000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<55.020000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<57.560000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<57.560000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<55.020000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<52.480000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<57.560000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<55.020000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<52.480000,0.000000,36.761500>}
//Q3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.513000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.513000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.513000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.402000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.513000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.402000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.402000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.402000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.402000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.513000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.513000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.513000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.927000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.038000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.038000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.038000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.038000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.038000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.038000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.038000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.927000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.927000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.292000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.148000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<31.148000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.148000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.148000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<31.148000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.148000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.292000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<31.148000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.292000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.292000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<40.292000,0.000000,23.490000> }
difference{
cylinder{<35.720000,0,19.934000><35.720000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<35.720000,-0.1,19.934000><35.720000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<33.180000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<35.720000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<38.260000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<38.260000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<35.720000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<33.180000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<38.260000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<35.720000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<33.180000,0.000000,36.761500>}
//Q4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,32.380000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.213000,0.000000,32.380000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,16.505000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,16.505000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.213000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.213000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.102000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.213000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.102000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.102000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.102000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.102000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.213000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.213000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.213000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,32.380000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,19.934000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.627000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.738000,0.000000,19.934000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.738000,0.000000,19.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.738000,0.000000,19.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.738000,0.000000,18.410000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.738000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.738000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,18.410000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.738000,0.000000,18.410000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,18.410000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.627000,0.000000,16.505000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.627000,0.000000,16.505000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.992000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<10.848000,0.000000,31.745000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<10.848000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<10.848000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<10.848000,0.000000,31.745000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<10.848000,0.000000,31.745000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<10.848000,0.000000,23.490000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.992000,0.000000,23.490000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<10.848000,0.000000,23.490000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.992000,0.000000,31.745000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<19.992000,0.000000,23.490000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<19.992000,0.000000,23.490000> }
difference{
cylinder{<15.420000,0,19.934000><15.420000,0.036000,19.934000>1.879600 translate<0,0.000000,0>}
cylinder{<15.420000,-0.1,19.934000><15.420000,0.135000,19.934000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<12.880000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<15.420000,0.000000,35.491500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<17.960000,0.000000,35.491500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<17.960000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<15.420000,0.000000,33.777000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<12.880000,0.000000,33.777000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<17.960000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<15.420000,0.000000,36.761500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<12.880000,0.000000,36.761500>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<71.000000,0.000000,43.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<71.000000,0.000000,43.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<71.000000,0.000000,43.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<70.111000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<71.889000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<71.889000,0.000000,49.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<70.111000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.889000,0.000000,43.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.111000,0.000000,43.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.111000,0.000000,43.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.857000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.984000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.143000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.143000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.016000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<72.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<69.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.984000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.984000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.016000,0.000000,49.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.016000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.857000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.143000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.143000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.889000,0.000000,50.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.111000,0.000000,50.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.111000,0.000000,50.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<71.000000,0.000000,50.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<71.000000,0.000000,50.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<71.000000,0.000000,50.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<71.000000,0.000000,43.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<71.000000,0.000000,50.302000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<55.610000,0.000000,43.660000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<55.610000,0.000000,44.041000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<55.610000,0.000000,44.041000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<54.721000,0.000000,44.549000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<56.499000,0.000000,44.549000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<56.499000,0.000000,50.391000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<54.721000,0.000000,50.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.499000,0.000000,44.295000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.721000,0.000000,44.295000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.721000,0.000000,44.295000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.467000,0.000000,44.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.467000,0.000000,44.930000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.467000,0.000000,44.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.594000,0.000000,45.057000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.467000,0.000000,44.930000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<54.467000,0.000000,44.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.753000,0.000000,44.549000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.753000,0.000000,44.930000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.753000,0.000000,44.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.626000,0.000000,45.057000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.753000,0.000000,44.930000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<56.626000,0.000000,45.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.594000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.467000,0.000000,50.010000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<54.467000,0.000000,50.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.594000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.594000,0.000000,45.057000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.594000,0.000000,45.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.626000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.753000,0.000000,50.010000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<56.626000,0.000000,49.883000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.626000,0.000000,49.883000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.626000,0.000000,45.057000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.626000,0.000000,45.057000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.467000,0.000000,50.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.467000,0.000000,50.010000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.467000,0.000000,50.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.753000,0.000000,50.391000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.753000,0.000000,50.010000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.753000,0.000000,50.010000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.499000,0.000000,50.645000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.721000,0.000000,50.645000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.721000,0.000000,50.645000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<55.610000,0.000000,50.899000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<55.610000,0.000000,51.280000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<55.610000,0.000000,51.280000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<55.610000,0.000000,44.168000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<55.610000,0.000000,50.772000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.610000,0.000000,43.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.610000,0.000000,43.881000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<39.610000,0.000000,43.881000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.721000,0.000000,44.389000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<40.499000,0.000000,44.389000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<40.499000,0.000000,50.231000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.721000,0.000000,50.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.499000,0.000000,44.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.721000,0.000000,44.135000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.721000,0.000000,44.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.467000,0.000000,44.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.467000,0.000000,44.770000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.467000,0.000000,44.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.594000,0.000000,44.897000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.467000,0.000000,44.770000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.467000,0.000000,44.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.753000,0.000000,44.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.753000,0.000000,44.770000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.753000,0.000000,44.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.626000,0.000000,44.897000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.753000,0.000000,44.770000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<40.626000,0.000000,44.897000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.594000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.467000,0.000000,49.850000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<38.467000,0.000000,49.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.594000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.594000,0.000000,44.897000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.594000,0.000000,44.897000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.626000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.753000,0.000000,49.850000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.626000,0.000000,49.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.626000,0.000000,49.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.626000,0.000000,44.897000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.626000,0.000000,44.897000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.467000,0.000000,50.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.467000,0.000000,49.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.467000,0.000000,49.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.753000,0.000000,50.231000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.753000,0.000000,49.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.753000,0.000000,49.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.499000,0.000000,50.485000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.721000,0.000000,50.485000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.721000,0.000000,50.485000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.610000,0.000000,50.739000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.610000,0.000000,51.120000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<39.610000,0.000000,51.120000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<39.610000,0.000000,44.008000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<39.610000,0.000000,50.612000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.000000,0.000000,43.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.000000,0.000000,43.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<26.000000,0.000000,43.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<25.111000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<26.889000,0.000000,44.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<26.889000,0.000000,49.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<25.111000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.889000,0.000000,43.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.111000,0.000000,43.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.111000,0.000000,43.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.857000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.984000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.857000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.857000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.143000,0.000000,44.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.143000,0.000000,44.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,44.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.143000,0.000000,44.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<27.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.984000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.984000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.984000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.016000,0.000000,49.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,49.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.016000,0.000000,44.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.016000,0.000000,44.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.857000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.857000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.857000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.143000,0.000000,49.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.143000,0.000000,49.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.143000,0.000000,49.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.889000,0.000000,50.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.111000,0.000000,50.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.111000,0.000000,50.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.000000,0.000000,50.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.000000,0.000000,50.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<26.000000,0.000000,50.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<26.000000,0.000000,43.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<26.000000,0.000000,50.302000>}
//RX silk screen
//TX silk screen
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.375000,0.000000,45.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.375000,0.000000,50.310000>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,90.000000,0> translate<8.375000,0.000000,50.310000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.375000,0.000000,50.310000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.280000,0.000000,50.310000>}
box{<0,0,-0.127000><1.905000,0.036000,0.127000> rotate<0,0.000000,0> translate<8.375000,0.000000,50.310000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.280000,0.000000,50.310000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<14.725000,0.000000,50.310000>}
box{<0,0,-0.127000><4.445000,0.036000,0.127000> rotate<0,0.000000,0> translate<10.280000,0.000000,50.310000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<14.725000,0.000000,50.310000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<14.725000,0.000000,45.230000>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,-90.000000,0> translate<14.725000,0.000000,45.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<14.725000,0.000000,45.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.280000,0.000000,45.230000>}
box{<0,0,-0.127000><4.445000,0.036000,0.127000> rotate<0,0.000000,0> translate<10.280000,0.000000,45.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.280000,0.000000,45.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<8.375000,0.000000,45.230000>}
box{<0,0,-0.127000><1.905000,0.036000,0.127000> rotate<0,0.000000,0> translate<8.375000,0.000000,45.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.280000,0.000000,45.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.280000,0.000000,50.310000>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,90.000000,0> translate<10.280000,0.000000,50.310000> }
//XBEE silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.850000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.215000,0.000000,79.960000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.215000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.215000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.945000,0.000000,79.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.945000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.945000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.310000,0.000000,80.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<32.310000,0.000000,80.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.310000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.310000,0.000000,81.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.310000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.310000,0.000000,81.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.945000,0.000000,82.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.310000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.945000,0.000000,82.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.215000,0.000000,82.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.945000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.215000,0.000000,82.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.850000,0.000000,81.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<34.215000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.295000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.025000,0.000000,79.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.025000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.025000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.390000,0.000000,80.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<37.390000,0.000000,80.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.390000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.390000,0.000000,81.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.390000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.390000,0.000000,81.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.025000,0.000000,82.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<37.390000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.390000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.755000,0.000000,79.960000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.755000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.755000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.485000,0.000000,79.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.485000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.485000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.850000,0.000000,80.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<34.850000,0.000000,80.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.850000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.850000,0.000000,81.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.850000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.850000,0.000000,81.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.485000,0.000000,82.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.850000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.485000,0.000000,82.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.755000,0.000000,82.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.485000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.755000,0.000000,82.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.390000,0.000000,81.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<36.755000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.930000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.930000,0.000000,81.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.930000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.295000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.930000,0.000000,80.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.295000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.930000,0.000000,81.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.295000,0.000000,82.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<39.295000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.025000,0.000000,82.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.295000,0.000000,82.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.025000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.675000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.405000,0.000000,79.960000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.405000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.405000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.770000,0.000000,80.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.770000,0.000000,80.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.770000,0.000000,80.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.770000,0.000000,81.865000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<29.770000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.770000,0.000000,81.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.405000,0.000000,82.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.770000,0.000000,81.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.675000,0.000000,79.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.310000,0.000000,80.595000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.675000,0.000000,79.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.310000,0.000000,81.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.675000,0.000000,82.500000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.675000,0.000000,82.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.405000,0.000000,82.500000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.675000,0.000000,82.500000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.405000,0.000000,82.500000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<33.580000,0.000000,81.230000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<36.120000,0.000000,81.230000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<38.660000,0.000000,81.230000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<31.040000,0.000000,81.230000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  PROTOTIPO_2X(-42.000000,0,-43.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
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
