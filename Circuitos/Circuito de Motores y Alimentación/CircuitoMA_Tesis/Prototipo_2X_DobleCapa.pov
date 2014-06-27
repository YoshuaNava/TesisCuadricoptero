//POVRay-File created by 3d41.ulp v20110101
//C:/Users/Yoshua/Documents/eagle/CircuitoMA_Tesis/Prototipo_2X_DobleCapa.brd
//26-06-2014 10:55:07 p.m.

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
#local cam_y = 371;
#local cam_z = -198;
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

#local lgt1_pos_x = 28;
#local lgt1_pos_y = 49;
#local lgt1_pos_z = 45;
#local lgt1_intense = 0.793296;
#local lgt2_pos_x = -28;
#local lgt2_pos_y = 49;
#local lgt2_pos_z = 45;
#local lgt2_intense = 0.793296;
#local lgt3_pos_x = 28;
#local lgt3_pos_y = 49;
#local lgt3_pos_z = -31;
#local lgt3_intense = 0.793296;
#local lgt4_pos_x = -28;
#local lgt4_pos_y = 49;
#local lgt4_pos_z = -31;
#local lgt4_intense = 0.793296;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 75.500000;
#declare pcb_y_size = 86.500000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(44);
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
	//translate<-37.750000,0,-43.250000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro PROTOTIPO_2X_DOBLECAPA(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><75.500000,0.000000>
<75.500000,0.000000><75.500000,86.500000>
<75.500000,86.500000><0.000000,86.500000>
<0.000000,86.500000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<6.500000,1,6.500000><6.500000,-5,6.500000>1.600000 texture{col_hls}}
cylinder{<6.500000,1,80.000000><6.500000,-5,80.000000>1.600000 texture{col_hls}}
cylinder{<69.000000,1,6.500000><69.000000,-5,6.500000>1.600000 texture{col_hls}}
cylinder{<69.000000,1,80.000000><69.000000,-5,80.000000>1.600000 texture{col_hls}}
cylinder{<8.474000,1,61.380000><8.474000,-5,61.380000>1.651000 texture{col_hls}}
cylinder{<67.320000,1,20.434000><67.320000,-5,20.434000>1.651000 texture{col_hls}}
cylinder{<49.020000,1,20.434000><49.020000,-5,20.434000>1.651000 texture{col_hls}}
cylinder{<32.720000,1,20.434000><32.720000,-5,20.434000>1.651000 texture{col_hls}}
cylinder{<16.420000,1,20.434000><16.420000,-5,20.434000>1.651000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
cylinder{<18.040000,0.095000,9.540000><18.040000,-1.595000,9.540000>1.905000 texture{col_hls}}
cylinder{<28.660000,0.095000,9.540000><28.660000,-1.595000,9.540000>1.905000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_ARDUINO) #declare global_pack_ARDUINO=yes; object {CON_PHW_1X8()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<54.000000,0.000000,74.500000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) ARDUINO  1X08/90
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<58.850000,0.000000,27.640000>}#end		//Diode DO201 15mm hor. D1 RGP30 DO201-15
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<40.850000,0.000000,27.320000>}#end		//Diode DO201 15mm hor. D2 RGP30 DO201-15
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<24.350000,0.000000,28.000000>}#end		//Diode DO201 15mm hor. D3 RGP30 DO201-15
#ifndef(pack_D4) #declare global_pack_D4=yes; object {DIODE_DIS_DO201_152MM_H("RGP30",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<8.460000,0.000000,27.640000>}#end		//Diode DO201 15mm hor. D4 RGP30 DO201-15
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<39.000000,0.000000,77.500000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP1  1X02
#ifndef(pack_JP2) #declare global_pack_JP2=yes; object {CON_PHW_1X2()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<16.000000,0.000000,50.000000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) JP2  1X02/90
#ifndef(pack_LM7809) #declare global_pack_LM7809=yes; object {TR_TO220_3_H2("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<19.650000,0.000000,61.380000>}#end		//TO220 horizontal straight leads LM7809  78XXL
#ifndef(pack_MOTORES) #declare global_pack_MOTORES=yes; object {CON_PHW_1X8()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<51.130000,0.000000,6.780000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) MOTORES  1X08/90
#ifndef(pack_OK1) #declare global_pack_OK1=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<66.780000,0.000000,58.750000>}#end		//DIP6 OK1 4N26M DIL06
#ifndef(pack_OK2) #declare global_pack_OK2=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<54.940000,0.000000,58.750000>}#end		//DIP6 OK2 4N26M DIL06
#ifndef(pack_OK3) #declare global_pack_OK3=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<43.100000,0.000000,58.750000>}#end		//DIP6 OK3 4N26M DIL06
#ifndef(pack_OK4) #declare global_pack_OK4=yes; object {IC_DIS_DIP6("4N26M","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<31.260000,0.000000,58.750000>}#end		//DIP6 OK4 4N26M DIL06
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<67.320000,0.000000,31.610000>}#end		//TO220 horizontal straight leads Q1 IRLZ44Z TO220BH
#ifndef(pack_Q2) #declare global_pack_Q2=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<49.020000,0.000000,31.610000>}#end		//TO220 horizontal straight leads Q2 IRLZ44Z TO220BH
#ifndef(pack_Q3) #declare global_pack_Q3=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<32.720000,0.000000,31.610000>}#end		//TO220 horizontal straight leads Q3 IRLZ44Z TO220BH
#ifndef(pack_Q4) #declare global_pack_Q4=yes; object {TR_TO220_3_H("IRLZ44Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<16.420000,0.000000,31.610000>}#end		//TO220 horizontal straight leads Q4 IRLZ44Z TO220BH
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Red*0.7}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<65.000000,0.000000,45.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 1KOhm 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Red*0.7}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<54.000000,0.000000,45.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 1KOhm 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Red*0.7}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<32.500000,0.000000,45.000000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 1KOhm 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Red*0.7}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<24.000000,0.000000,44.500000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 1KOhm 0207/7
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_075MM(texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Violet*1.2}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<53.500000,0.000000,51.500000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R5 470KOhm 0207/7
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_075MM(texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Violet*1.2}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<42.000000,0.000000,51.500000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R6 470KOhm 0207/7
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_075MM(texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Violet*1.2}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<65.500000,0.000000,51.500000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R7 470KOhm 0207/7
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_075MM(texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Violet*1.2}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<30.000000,0.000000,51.500000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R8 470KOhm 0207/7
#ifndef(pack_XBEE) #declare global_pack_XBEE=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<31.850000,0.000000,69.730000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) XBEE  1X04
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack__11_1V__BATERIA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(6.197600,3.810000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<28.660000,0,9.540000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.110000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<47.650000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.190000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.730000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.270000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.810000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.350000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_ARDUINO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.890000,0,70.690000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<23.397000,0,72.500000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<20.603000,0,72.500000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<23.397000,0,75.500000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<20.603000,0,75.500000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<23.397000,0,69.500000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<20.603000,0,69.500000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<15.103000,0,75.500000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.016000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<17.897000,0,75.500000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.850000,0,35.260000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.850000,0,20.020000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.850000,0,34.940000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.850000,0,19.700000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<24.350000,0,35.620000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<24.350000,0,20.380000> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<8.460000,0,35.260000> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.247900,1.498600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<8.460000,0,20.020000> texture{col_thl}}
#ifndef(global_pack_GND__BATERIA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(6.197600,3.810000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<18.040000,0,9.540000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<40.270000,0,77.500000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<37.730000,0,77.500000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.810000,0,48.730000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.810000,0,51.270000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<23.460000,0,61.380000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<23.460000,0,58.840000> texture{col_thl}}
#ifndef(global_pack_LM7809) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<23.460000,0,63.920000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<60.020000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<57.480000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<54.940000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<52.400000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<49.860000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<47.320000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<44.780000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_MOTORES) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<42.240000,0,10.590000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<69.320000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<66.780000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<64.240000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<64.240000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<66.780000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<69.320000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<57.480000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<54.940000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<52.400000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<52.400000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<54.940000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<57.480000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<45.640000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<43.100000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<40.560000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<40.560000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<43.100000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<45.640000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<33.800000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<31.260000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<28.720000,0,62.560000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<28.720000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<31.260000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_OK4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<33.800000,0,54.940000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<67.320000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<69.860000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<64.780000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<49.020000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<51.560000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<46.480000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<32.720000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<35.260000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<30.180000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<16.420000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<18.960000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<13.880000,0,37.960000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<65.000000,0,41.190000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<65.000000,0,48.810000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<54.000000,0,41.190000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<54.000000,0,48.810000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<32.500000,0,41.190000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<32.500000,0,48.810000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<24.000000,0,40.690000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<24.000000,0,48.310000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<49.690000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<57.310000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<38.190000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<45.810000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<61.690000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<69.310000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<26.190000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<33.810000,0,51.500000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<35.660000,0,69.730000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<33.120000,0,69.730000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<30.580000,0,69.730000> texture{col_thl}}
#ifndef(global_pack_XBEE) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<28.040000,0,69.730000> texture{col_thl}}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<15.540000,0.000000,9.460000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<18.040000,0.000000,9.540000>}
box{<0,0,-0.965200><2.501280,0.035000,0.965200> rotate<0,-1.832719,0> translate<15.540000,0.000000,9.460000> }
}cylinder{<18.040000,1,9.540000><18.040000,-2.500000,9.540000>1.905000 texture{col_thl}}}
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.660000,-1.535000,9.540000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.960000,-1.535000,9.540000>}
box{<0,0,-0.965200><0.300000,0.035000,0.965200> rotate<0,0.000000,0> translate<28.660000,-1.535000,9.540000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.960000,-1.535000,9.540000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,6.000000>}
box{<0,0,-0.965200><5.006316,0.035000,0.965200> rotate<0,44.997030,0> translate<28.960000,-1.535000,9.540000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,13.850000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.660000,-1.535000,9.540000>}
box{<0,0,-0.965200><6.095260,0.035000,0.965200> rotate<0,44.997030,0> translate<24.350000,-1.535000,13.850000> }
}cylinder{<28.660000,1,9.540000><28.660000,-2.500000,9.540000>1.905000 texture{col_thl}}}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<5.500000,-1.535000,53.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<5.500000,-1.535000,22.980000>}
box{<0,0,-0.965200><30.020000,0.035000,0.965200> rotate<0,-90.000000,0> translate<5.500000,-1.535000,22.980000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,20.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,19.540000>}
box{<0,0,-0.965200><0.480000,0.035000,0.965200> rotate<0,-90.000000,0> translate<8.460000,-1.535000,19.540000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<5.500000,-1.535000,22.980000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,20.020000>}
box{<0,0,-0.965200><4.186072,0.035000,0.965200> rotate<0,44.997030,0> translate<5.500000,-1.535000,22.980000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,35.260000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,31.540000>}
box{<0,0,-0.965200><3.720000,0.035000,0.965200> rotate<0,-90.000000,0> translate<8.460000,-1.535000,31.540000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,31.540000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<10.000000,-1.535000,30.000000>}
box{<0,0,-0.965200><2.177889,0.035000,0.965200> rotate<0,44.997030,0> translate<8.460000,-1.535000,31.540000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<5.500000,-1.535000,53.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<11.340000,-1.535000,58.840000>}
box{<0,0,-0.965200><8.259007,0.035000,0.965200> rotate<0,-44.997030,0> translate<5.500000,-1.535000,53.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<8.460000,-1.535000,19.540000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<12.500000,-1.535000,15.500000>}
box{<0,0,-0.965200><5.713423,0.035000,0.965200> rotate<0,44.997030,0> translate<8.460000,-1.535000,19.540000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<12.500000,0.000000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<12.500000,0.000000,35.080000>}
box{<0,0,-0.965200><22.080000,0.035000,0.965200> rotate<0,90.000000,0> translate<12.500000,0.000000,35.080000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.500000,-1.535000,69.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.500000,-1.535000,76.500000>}
box{<0,0,-0.406400><7.000000,0.035000,0.406400> rotate<0,90.000000,0> translate<12.500000,-1.535000,76.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.500000,-1.535000,76.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.500000,-1.535000,78.500000>}
box{<0,0,-0.406400><2.236068,0.035000,0.406400> rotate<0,-63.430762,0> translate<12.500000,-1.535000,76.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<12.500000,0.000000,35.080000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<13.880000,0.000000,37.960000>}
box{<0,0,-0.965200><3.193556,0.035000,0.965200> rotate<0,-64.393562,0> translate<12.500000,0.000000,35.080000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<13.880000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<13.960000,-1.535000,37.960000>}
box{<0,0,-0.838200><0.080000,0.035000,0.838200> rotate<0,0.000000,0> translate<13.880000,-1.535000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<13.960000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<14.000000,-1.535000,38.000000>}
box{<0,0,-0.838200><0.056569,0.035000,0.838200> rotate<0,-44.997030,0> translate<13.960000,-1.535000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<14.000000,-1.535000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<14.000000,-1.535000,40.000000>}
box{<0,0,-0.838200><2.000000,0.035000,0.838200> rotate<0,90.000000,0> translate<14.000000,-1.535000,40.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<10.000000,-1.535000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<14.500000,-1.535000,30.000000>}
box{<0,0,-0.965200><4.500000,0.035000,0.965200> rotate<0,0.000000,0> translate<10.000000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.603000,-1.535000,69.897000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.103000,-1.535000,75.500000>}
box{<0,0,-0.406400><5.625265,0.035000,0.406400> rotate<0,-84.894949,0> translate<14.603000,-1.535000,69.897000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<14.000000,-1.535000,40.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<15.500000,-1.535000,41.000000>}
box{<0,0,-0.838200><1.802776,0.035000,0.838200> rotate<0,-33.687844,0> translate<14.000000,-1.535000,40.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<12.500000,0.000000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<15.540000,0.000000,9.460000>}
box{<0,0,-0.965200><4.666176,0.035000,0.965200> rotate<0,49.342175,0> translate<12.500000,0.000000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<16.420000,0.000000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<16.420000,0.000000,31.080000>}
box{<0,0,-0.406400><6.880000,0.035000,0.406400> rotate<0,-90.000000,0> translate<16.420000,0.000000,31.080000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<14.500000,-1.535000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,32.000000>}
box{<0,0,-0.965200><2.828427,0.035000,0.965200> rotate<0,-44.997030,0> translate<14.500000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,32.000000>}
box{<0,0,-0.965200><4.000000,0.035000,0.965200> rotate<0,90.000000,0> translate<16.500000,-1.535000,32.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.420000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,37.880000>}
box{<0,0,-0.965200><0.113137,0.035000,0.965200> rotate<0,44.997030,0> translate<16.420000,-1.535000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,32.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,37.880000>}
box{<0,0,-0.965200><5.880000,0.035000,0.965200> rotate<0,90.000000,0> translate<16.500000,-1.535000,37.880000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<16.420000,0.000000,31.080000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.000000,0.000000,29.500000>}
box{<0,0,-0.406400><2.234457,0.035000,0.406400> rotate<0,44.997030,0> translate<16.420000,0.000000,31.080000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.000000,0.000000,61.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.000000,0.000000,55.460000>}
box{<0,0,-0.406400><6.040000,0.035000,0.406400> rotate<0,-90.000000,0> translate<18.000000,0.000000,55.460000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<16.500000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<18.500000,-1.535000,26.000000>}
box{<0,0,-0.965200><2.828427,0.035000,0.965200> rotate<0,44.997030,0> translate<16.500000,-1.535000,28.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.603000,-1.535000,69.897000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.500000,-1.535000,64.000000>}
box{<0,0,-0.406400><7.068325,0.035000,0.406400> rotate<0,56.537766,0> translate<14.603000,-1.535000,69.897000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.960000,0.000000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.960000,0.000000,40.460000>}
box{<0,0,-0.406400><2.500000,0.035000,0.406400> rotate<0,90.000000,0> translate<18.960000,0.000000,40.460000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<12.500000,-1.535000,15.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<19.470000,-1.535000,15.500000>}
box{<0,0,-0.965200><6.970000,0.035000,0.965200> rotate<0,0.000000,0> translate<12.500000,-1.535000,15.500000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<14.000000,-1.535000,40.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<19.500000,-1.535000,45.040000>}
box{<0,0,-0.838200><7.460000,0.035000,0.838200> rotate<0,-42.498206,0> translate<14.000000,-1.535000,40.000000> }
cylinder{<0,0,0><0,0.035000,0>0.889000 translate<11.340000,-1.535000,58.840000>}
cylinder{<0,0,0><0,0.035000,0>0.889000 translate<19.660000,-1.535000,58.840000>}
box{<0,0,-0.889000><8.320000,0.035000,0.889000> rotate<0,0.000000,0> translate<11.340000,-1.535000,58.840000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.500000,-1.535000,69.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.660000,-1.535000,58.840000>}
box{<0,0,-0.406400><12.841386,0.035000,0.406400> rotate<0,56.108232,0> translate<12.500000,-1.535000,69.500000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<19.500000,-1.535000,45.040000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<19.810000,-1.535000,48.730000>}
box{<0,0,-0.838200><3.702999,0.035000,0.838200> rotate<0,-85.192187,0> translate<19.500000,-1.535000,45.040000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.000000,0.000000,55.460000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.810000,0.000000,51.270000>}
box{<0,0,-0.406400><4.564230,0.035000,0.406400> rotate<0,66.632180,0> translate<18.000000,0.000000,55.460000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.500000,-1.535000,72.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.500000,-1.535000,70.603000>}
box{<0,0,-0.406400><1.897000,0.035000,0.406400> rotate<0,-90.000000,0> translate<20.500000,-1.535000,70.603000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,69.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,67.397000>}
box{<0,0,-0.406400><2.103000,0.035000,0.406400> rotate<0,-90.000000,0> translate<20.603000,-1.535000,67.397000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.500000,-1.535000,70.603000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,69.500000>}
box{<0,0,-0.406400><1.107799,0.035000,0.406400> rotate<0,84.659507,0> translate<20.500000,-1.535000,70.603000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.500000,-1.535000,72.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,72.500000>}
box{<0,0,-0.406400><0.103000,0.035000,0.406400> rotate<0,0.000000,0> translate<20.500000,-1.535000,72.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,72.500000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,-90.000000,0> translate<20.603000,-1.535000,72.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.897000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,75.500000>}
box{<0,0,-0.406400><2.706000,0.035000,0.406400> rotate<0,0.000000,0> translate<17.897000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.000000,0.000000,61.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.920000,0.000000,63.920000>}
box{<0,0,-0.406400><3.792466,0.035000,0.406400> rotate<0,-39.648206,0> translate<18.000000,0.000000,61.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.960000,0.000000,40.460000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.500000,0.000000,43.000000>}
box{<0,0,-0.406400><3.592102,0.035000,0.406400> rotate<0,-44.997030,0> translate<18.960000,0.000000,40.460000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.500000,0.000000,43.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.500000,0.000000,45.810000>}
box{<0,0,-0.406400><2.810000,0.035000,0.406400> rotate<0,90.000000,0> translate<21.500000,0.000000,45.810000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.603000,-1.535000,67.397000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.500000,-1.535000,66.500000>}
box{<0,0,-0.406400><1.268550,0.035000,0.406400> rotate<0,44.997030,0> translate<20.603000,-1.535000,67.397000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.500000,-1.535000,78.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.000000,-1.535000,78.500000>}
box{<0,0,-0.406400><9.500000,0.035000,0.406400> rotate<0,0.000000,0> translate<13.500000,-1.535000,78.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.500000,-1.535000,64.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.380000,-1.535000,64.000000>}
box{<0,0,-0.406400><4.880000,0.035000,0.406400> rotate<0,0.000000,0> translate<18.500000,-1.535000,64.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397000,-1.535000,69.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397000,-1.535000,72.500000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,90.000000,0> translate<23.397000,-1.535000,72.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397000,-1.535000,72.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397000,-1.535000,75.500000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,90.000000,0> translate<23.397000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.889000 translate<19.660000,-1.535000,58.840000>}
cylinder{<0,0,0><0,0.035000,0>0.889000 translate<23.460000,-1.535000,58.840000>}
box{<0,0,-0.889000><3.800000,0.035000,0.889000> rotate<0,0.000000,0> translate<19.660000,-1.535000,58.840000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.920000,0.000000,63.920000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.460000,0.000000,63.920000>}
box{<0,0,-0.406400><2.540000,0.035000,0.406400> rotate<0,0.000000,0> translate<20.920000,0.000000,63.920000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.380000,-1.535000,64.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.460000,-1.535000,63.920000>}
box{<0,0,-0.406400><0.113137,0.035000,0.406400> rotate<0,44.997030,0> translate<23.380000,-1.535000,64.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.000000,-1.535000,78.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.500000,-1.535000,77.603000>}
box{<0,0,-0.406400><1.026942,0.035000,0.406400> rotate<0,60.860093,0> translate<23.000000,-1.535000,78.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.500000,-1.535000,77.603000>}
box{<0,0,-0.406400><2.105521,0.035000,0.406400> rotate<0,-87.190273,0> translate<23.397000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<15.500000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<23.810000,-1.535000,41.000000>}
box{<0,0,-0.838200><8.310000,0.035000,0.838200> rotate<0,0.000000,0> translate<15.500000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<23.810000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<24.000000,-1.535000,40.690000>}
box{<0,0,-0.838200><0.363593,0.035000,0.838200> rotate<0,58.491873,0> translate<23.810000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.500000,0.000000,45.810000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.000000,0.000000,48.310000>}
box{<0,0,-0.406400><3.535534,0.035000,0.406400> rotate<0,-44.997030,0> translate<21.500000,0.000000,45.810000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<24.000000,-1.535000,40.690000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<24.190000,-1.535000,41.000000>}
box{<0,0,-0.635000><0.363593,0.035000,0.635000> rotate<0,-58.491873,0> translate<24.000000,-1.535000,40.690000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.000000,0.000000,48.310000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.190000,0.000000,48.500000>}
box{<0,0,-0.406400><0.268701,0.035000,0.406400> rotate<0,-44.997030,0> translate<24.000000,0.000000,48.310000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,20.380000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,13.850000>}
box{<0,0,-0.965200><6.530000,0.035000,0.965200> rotate<0,-90.000000,0> translate<24.350000,-1.535000,13.850000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<19.470000,-1.535000,15.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,20.380000>}
box{<0,0,-0.965200><6.901362,0.035000,0.965200> rotate<0,-44.997030,0> translate<19.470000,-1.535000,15.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,35.620000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,32.150000>}
box{<0,0,-0.965200><3.470000,0.035000,0.965200> rotate<0,-90.000000,0> translate<24.350000,-1.535000,32.150000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.500000,-1.535000,66.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.500000,-1.535000,66.500000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<21.500000,-1.535000,66.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.460000,-1.535000,61.380000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.620000,-1.535000,61.380000>}
box{<0,0,-0.406400><2.160000,0.035000,0.406400> rotate<0,0.000000,0> translate<23.460000,-1.535000,61.380000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.000000,0.000000,29.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.000000,0.000000,29.500000>}
box{<0,0,-0.406400><8.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<18.000000,0.000000,29.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.350000,-1.535000,32.150000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<26.000000,-1.535000,30.500000>}
box{<0,0,-0.965200><2.333452,0.035000,0.965200> rotate<0,44.997030,0> translate<24.350000,-1.535000,32.150000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<26.190000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<26.190000,-1.535000,56.690000>}
box{<0,0,-0.965200><5.190000,0.035000,0.965200> rotate<0,90.000000,0> translate<26.190000,-1.535000,56.690000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.620000,-1.535000,61.380000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.500000,-1.535000,60.500000>}
box{<0,0,-0.406400><1.244508,0.035000,0.406400> rotate<0,44.997030,0> translate<25.620000,-1.535000,61.380000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.500000,-1.535000,64.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.500000,-1.535000,60.500000>}
box{<0,0,-0.406400><4.000000,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.500000,-1.535000,60.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.500000,-1.535000,66.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.500000,-1.535000,64.500000>}
box{<0,0,-0.406400><2.828427,0.035000,0.406400> rotate<0,44.997030,0> translate<24.500000,-1.535000,66.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<18.500000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<27.000000,-1.535000,26.000000>}
box{<0,0,-0.965200><8.500000,0.035000,0.965200> rotate<0,0.000000,0> translate<18.500000,-1.535000,26.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.190000,0.000000,48.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.000000,0.000000,48.500000>}
box{<0,0,-0.406400><2.810000,0.035000,0.406400> rotate<0,0.000000,0> translate<24.190000,0.000000,48.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.000000,0.000000,29.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.500000,0.000000,31.000000>}
box{<0,0,-0.406400><2.121320,0.035000,0.406400> rotate<0,-44.997030,0> translate<26.000000,0.000000,29.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.500000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.500000,0.000000,46.500000>}
box{<0,0,-0.406400><15.500000,0.035000,0.406400> rotate<0,90.000000,0> translate<27.500000,0.000000,46.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.500000,-1.535000,60.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.500000,-1.535000,59.000000>}
box{<0,0,-0.406400><1.802776,0.035000,0.406400> rotate<0,56.306216,0> translate<26.500000,-1.535000,60.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<27.000000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.000000,-1.535000,25.000000>}
box{<0,0,-0.965200><1.414214,0.035000,0.965200> rotate<0,44.997030,0> translate<27.000000,-1.535000,26.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.000000,-1.535000,17.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.000000,-1.535000,25.000000>}
box{<0,0,-0.965200><7.500000,0.035000,0.965200> rotate<0,90.000000,0> translate<28.000000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.000000,0.000000,67.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.000000,0.000000,69.690000>}
box{<0,0,-0.406400><2.190000,0.035000,0.406400> rotate<0,90.000000,0> translate<28.000000,0.000000,69.690000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.000000,0.000000,69.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.040000,0.000000,69.730000>}
box{<0,0,-0.406400><0.056569,0.035000,0.406400> rotate<0,-44.997030,0> translate<28.000000,0.000000,69.690000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<24.190000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.500000,-1.535000,41.000000>}
box{<0,0,-0.965200><4.310000,0.035000,0.965200> rotate<0,0.000000,0> translate<24.190000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<26.190000,-1.535000,56.690000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.500000,-1.535000,59.000000>}
box{<0,0,-0.965200><3.266833,0.035000,0.965200> rotate<0,-44.997030,0> translate<26.190000,-1.535000,56.690000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.500000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.500000,-1.535000,59.000000>}
box{<0,0,-0.406400><1.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<27.500000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.000000,0.000000,67.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.500000,0.000000,67.000000>}
box{<0,0,-0.406400><0.707107,0.035000,0.406400> rotate<0,44.997030,0> translate<28.000000,0.000000,67.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.000000,0.000000,48.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.720000,0.000000,50.220000>}
box{<0,0,-0.406400><2.432447,0.035000,0.406400> rotate<0,-44.997030,0> translate<27.000000,0.000000,48.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.720000,0.000000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.720000,0.000000,50.220000>}
box{<0,0,-0.406400><4.720000,0.035000,0.406400> rotate<0,-90.000000,0> translate<28.720000,0.000000,50.220000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.000000,-1.535000,17.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.500000,-1.535000,16.000000>}
box{<0,0,-0.965200><2.121320,0.035000,0.965200> rotate<0,44.997030,0> translate<28.000000,-1.535000,17.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.500000,0.000000,46.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.000000,0.000000,49.000000>}
box{<0,0,-0.406400><3.535534,0.035000,0.406400> rotate<0,-44.997030,0> translate<27.500000,0.000000,46.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.000000,0.000000,49.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.000000,0.000000,49.500000>}
box{<0,0,-0.406400><0.500000,0.035000,0.406400> rotate<0,90.000000,0> translate<30.000000,0.000000,49.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.500000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<30.180000,-1.535000,39.820000>}
box{<0,0,-0.965200><2.052998,0.035000,0.965200> rotate<0,35.081159,0> translate<28.500000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<30.180000,-1.535000,40.870000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<30.180000,-1.535000,39.820000>}
box{<0,0,-0.635000><1.050000,0.035000,0.635000> rotate<0,-90.000000,0> translate<30.180000,-1.535000,39.820000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<30.180000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<30.180000,-1.535000,40.870000>}
box{<0,0,-0.838200><2.910000,0.035000,0.838200> rotate<0,90.000000,0> translate<30.180000,-1.535000,40.870000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.500000,0.000000,72.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.500000,0.000000,69.810000>}
box{<0,0,-0.406400><2.690000,0.035000,0.406400> rotate<0,-90.000000,0> translate<30.500000,0.000000,69.810000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.500000,0.000000,69.810000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.580000,0.000000,69.730000>}
box{<0,0,-0.406400><0.113137,0.035000,0.406400> rotate<0,44.997030,0> translate<30.500000,0.000000,69.810000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<29.500000,-1.535000,16.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<31.000000,-1.535000,16.000000>}
box{<0,0,-0.965200><1.500000,0.035000,0.965200> rotate<0,0.000000,0> translate<29.500000,-1.535000,16.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<26.000000,-1.535000,30.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<31.000000,-1.535000,30.500000>}
box{<0,0,-0.965200><5.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<26.000000,-1.535000,30.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.000000,0.000000,49.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,0.000000,50.500000>}
box{<0,0,-0.406400><1.414214,0.035000,0.406400> rotate<0,-44.997030,0> translate<30.000000,0.000000,49.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,0.000000,50.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,0.000000,54.680000>}
box{<0,0,-0.406400><4.180000,0.035000,0.406400> rotate<0,90.000000,0> translate<31.000000,0.000000,54.680000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,-1.535000,65.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,-1.535000,62.820000>}
box{<0,0,-0.406400><2.680000,0.035000,0.406400> rotate<0,-90.000000,0> translate<31.000000,-1.535000,62.820000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,0.000000,54.680000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.260000,0.000000,54.940000>}
box{<0,0,-0.406400><0.367696,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.000000,0.000000,54.680000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,-1.535000,62.820000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.260000,-1.535000,62.560000>}
box{<0,0,-0.406400><0.367696,0.035000,0.406400> rotate<0,44.997030,0> translate<31.000000,-1.535000,62.820000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.000000,-1.535000,65.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.500000,-1.535000,66.000000>}
box{<0,0,-0.406400><0.707107,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.000000,-1.535000,65.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.500000,0.000000,72.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.500000,0.000000,73.500000>}
box{<0,0,-0.406400><1.414214,0.035000,0.406400> rotate<0,-44.997030,0> translate<30.500000,0.000000,72.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<31.000000,-1.535000,30.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,32.000000>}
box{<0,0,-0.965200><2.121320,0.035000,0.965200> rotate<0,-44.997030,0> translate<31.000000,-1.535000,30.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,32.000000>}
box{<0,0,-0.965200><4.000000,0.035000,0.965200> rotate<0,90.000000,0> translate<32.500000,-1.535000,32.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,32.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,37.740000>}
box{<0,0,-0.965200><5.740000,0.035000,0.965200> rotate<0,90.000000,0> translate<32.500000,-1.535000,37.740000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<30.180000,-1.535000,40.870000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,41.190000>}
box{<0,0,-0.965200><2.341965,0.035000,0.965200> rotate<0,-7.852795,0> translate<30.180000,-1.535000,40.870000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.720000,0.000000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.720000,0.000000,31.780000>}
box{<0,0,-0.406400><6.180000,0.035000,0.406400> rotate<0,-90.000000,0> translate<32.720000,0.000000,31.780000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,37.740000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.720000,-1.535000,37.960000>}
box{<0,0,-0.965200><0.311127,0.035000,0.965200> rotate<0,-44.997030,0> translate<32.500000,-1.535000,37.740000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120000,-1.535000,69.730000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120000,-1.535000,74.120000>}
box{<0,0,-0.406400><4.390000,0.035000,0.406400> rotate<0,90.000000,0> translate<33.120000,-1.535000,74.120000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<33.800000,-1.535000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<33.810000,-1.535000,54.930000>}
box{<0,0,-0.965200><0.014142,0.035000,0.965200> rotate<0,44.997030,0> translate<33.800000,-1.535000,54.940000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<33.810000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<33.810000,-1.535000,54.930000>}
box{<0,0,-0.965200><3.430000,0.035000,0.965200> rotate<0,90.000000,0> translate<33.810000,-1.535000,54.930000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.720000,0.000000,31.780000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.000000,0.000000,30.000000>}
box{<0,0,-0.406400><2.192442,0.035000,0.406400> rotate<0,54.276463,0> translate<32.720000,0.000000,31.780000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500000,0.000000,62.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.000000,0.000000,63.000000>}
box{<0,0,-0.406400><0.707107,0.035000,0.406400> rotate<0,-44.997030,0> translate<33.500000,0.000000,62.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120000,-1.535000,74.120000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.500000,-1.535000,75.500000>}
box{<0,0,-0.406400><1.951615,0.035000,0.406400> rotate<0,-44.997030,0> translate<33.120000,-1.535000,74.120000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,41.190000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<34.690000,-1.535000,42.000000>}
box{<0,0,-0.965200><2.334995,0.035000,0.965200> rotate<0,-20.296230,0> translate<32.500000,-1.535000,41.190000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.500000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.500000,-1.535000,66.000000>}
box{<0,0,-0.406400><4.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<31.500000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.500000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.660000,-1.535000,66.160000>}
box{<0,0,-0.406400><0.226274,0.035000,0.406400> rotate<0,-44.997030,0> translate<35.500000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.660000,-1.535000,69.730000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.660000,-1.535000,66.160000>}
box{<0,0,-0.406400><3.570000,0.035000,0.406400> rotate<0,-90.000000,0> translate<35.660000,-1.535000,66.160000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<36.000000,-1.535000,24.500000>}
box{<0,0,-0.965200><4.949747,0.035000,0.965200> rotate<0,44.997030,0> translate<32.500000,-1.535000,28.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<31.000000,-1.535000,16.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<36.410000,-1.535000,10.590000>}
box{<0,0,-0.965200><7.650895,0.035000,0.965200> rotate<0,44.997030,0> translate<31.000000,-1.535000,16.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.000000,0.000000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.500000,0.000000,30.000000>}
box{<0,0,-0.406400><2.500000,0.035000,0.406400> rotate<0,0.000000,0> translate<34.000000,0.000000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.000000,0.000000,63.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.000000,0.000000,63.000000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<34.000000,0.000000,63.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.500000,0.000000,67.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.500000,0.000000,67.000000>}
box{<0,0,-0.406400><9.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<28.500000,0.000000,67.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.500000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.500000,-1.535000,75.500000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<34.500000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.500000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.730000,-1.535000,75.730000>}
box{<0,0,-0.406400><0.325269,0.035000,0.406400> rotate<0,-44.997030,0> translate<37.500000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.730000,-1.535000,77.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.730000,-1.535000,75.730000>}
box{<0,0,-0.406400><1.770000,0.035000,0.406400> rotate<0,-90.000000,0> translate<37.730000,-1.535000,75.730000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.500000,0.000000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.000000,0.000000,32.000000>}
box{<0,0,-0.406400><2.500000,0.035000,0.406400> rotate<0,-53.126596,0> translate<36.500000,0.000000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.000000,0.000000,32.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.000000,0.000000,38.000000>}
box{<0,0,-0.406400><6.000000,0.035000,0.406400> rotate<0,90.000000,0> translate<38.000000,0.000000,38.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<38.190000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<38.190000,-1.535000,56.690000>}
box{<0,0,-0.965200><5.190000,0.035000,0.965200> rotate<0,90.000000,0> translate<38.190000,-1.535000,56.690000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.500000,0.000000,48.810000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.690000,0.000000,49.000000>}
box{<0,0,-0.406400><6.192915,0.035000,0.406400> rotate<0,-1.758007,0> translate<32.500000,0.000000,48.810000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.500000,0.000000,67.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.000000,0.000000,68.500000>}
box{<0,0,-0.406400><2.121320,0.035000,0.406400> rotate<0,-44.997030,0> translate<37.500000,0.000000,67.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.000000,0.000000,70.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.000000,0.000000,68.500000>}
box{<0,0,-0.406400><1.500000,0.035000,0.406400> rotate<0,-90.000000,0> translate<39.000000,0.000000,68.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.660000,-1.535000,69.730000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.270000,-1.535000,69.730000>}
box{<0,0,-0.406400><3.610000,0.035000,0.406400> rotate<0,0.000000,0> translate<35.660000,-1.535000,69.730000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<28.500000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<40.000000,-1.535000,59.000000>}
box{<0,0,-0.965200><11.500000,0.035000,0.965200> rotate<0,0.000000,0> translate<28.500000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<38.190000,-1.535000,56.690000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<40.000000,-1.535000,59.000000>}
box{<0,0,-0.965200><2.934655,0.035000,0.965200> rotate<0,-51.916107,0> translate<38.190000,-1.535000,56.690000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.270000,-1.535000,77.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.270000,-1.535000,75.730000>}
box{<0,0,-0.406400><1.770000,0.035000,0.406400> rotate<0,-90.000000,0> translate<40.270000,-1.535000,75.730000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.690000,0.000000,49.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.500000,0.000000,50.500000>}
box{<0,0,-0.406400><2.350766,0.035000,0.406400> rotate<0,-39.646921,0> translate<38.690000,0.000000,49.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.000000,0.000000,70.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.500000,0.000000,70.500000>}
box{<0,0,-0.406400><1.581139,0.035000,0.406400> rotate<0,-18.433732,0> translate<39.000000,0.000000,70.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.270000,-1.535000,75.730000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.500000,-1.535000,75.500000>}
box{<0,0,-0.406400><0.325269,0.035000,0.406400> rotate<0,44.997030,0> translate<40.270000,-1.535000,75.730000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.260000,0.000000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.560000,0.000000,43.260000>}
box{<0,0,-0.406400><7.495332,0.035000,0.406400> rotate<0,-44.997030,0> translate<35.260000,0.000000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.560000,0.000000,51.560000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.560000,0.000000,43.260000>}
box{<0,0,-0.406400><8.300000,0.035000,0.406400> rotate<0,-90.000000,0> translate<40.560000,0.000000,43.260000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.500000,0.000000,50.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.560000,0.000000,51.560000>}
box{<0,0,-0.406400><1.061697,0.035000,0.406400> rotate<0,-86.754574,0> translate<40.500000,0.000000,50.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.560000,0.000000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.560000,0.000000,51.560000>}
box{<0,0,-0.406400><3.380000,0.035000,0.406400> rotate<0,-90.000000,0> translate<40.560000,0.000000,51.560000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.850000,-1.535000,34.940000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<41.000000,-1.535000,34.790000>}
box{<0,0,-0.635000><0.212132,0.035000,0.635000> rotate<0,44.997030,0> translate<40.850000,-1.535000,34.940000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<41.000000,-1.535000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<41.000000,-1.535000,34.790000>}
box{<0,0,-0.965200><4.790000,0.035000,0.965200> rotate<0,90.000000,0> translate<41.000000,-1.535000,34.790000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<36.410000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<42.240000,-1.535000,10.590000>}
box{<0,0,-0.965200><5.830000,0.035000,0.965200> rotate<0,0.000000,0> translate<36.410000,-1.535000,10.590000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.000000,0.000000,63.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<42.500000,0.000000,68.000000>}
box{<0,0,-0.406400><7.433034,0.035000,0.406400> rotate<0,-42.270899,0> translate<37.000000,0.000000,63.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<36.000000,-1.535000,24.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.000000,-1.535000,24.500000>}
box{<0,0,-0.965200><7.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<36.000000,-1.535000,24.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<41.000000,-1.535000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.000000,-1.535000,28.000000>}
box{<0,0,-0.965200><2.828427,0.035000,0.965200> rotate<0,44.997030,0> translate<41.000000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.000000,0.000000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,0.000000,43.000000>}
box{<0,0,-0.406400><7.071068,0.035000,0.406400> rotate<0,-44.997030,0> translate<38.000000,0.000000,38.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,0.000000,43.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,0.000000,54.840000>}
box{<0,0,-0.406400><11.840000,0.035000,0.406400> rotate<0,90.000000,0> translate<43.000000,0.000000,54.840000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,65.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,62.660000>}
box{<0,0,-0.406400><2.840000,0.035000,0.406400> rotate<0,-90.000000,0> translate<43.000000,-1.535000,62.660000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,65.500000>}
box{<0,0,-0.406400><0.500000,0.035000,0.406400> rotate<0,-90.000000,0> translate<43.000000,-1.535000,65.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.270000,-1.535000,69.730000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,66.000000>}
box{<0,0,-0.406400><5.275017,0.035000,0.406400> rotate<0,44.997030,0> translate<39.270000,-1.535000,69.730000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,0.000000,54.840000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.100000,0.000000,54.940000>}
box{<0,0,-0.406400><0.141421,0.035000,0.406400> rotate<0,-44.997030,0> translate<43.000000,0.000000,54.840000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,62.660000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.100000,-1.535000,62.560000>}
box{<0,0,-0.406400><0.141421,0.035000,0.406400> rotate<0,44.997030,0> translate<43.000000,-1.535000,62.660000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.000000,-1.535000,65.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.500000,-1.535000,66.000000>}
box{<0,0,-0.406400><0.707107,0.035000,0.406400> rotate<0,-44.997030,0> translate<43.000000,-1.535000,65.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.500000,0.000000,70.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.500000,0.000000,70.500000>}
box{<0,0,-0.406400><3.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<40.500000,0.000000,70.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<40.850000,-1.535000,19.700000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.780000,-1.535000,14.770000>}
box{<0,0,-0.965200><5.734963,0.035000,0.965200> rotate<0,59.272205,0> translate<40.850000,-1.535000,19.700000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.500000,0.000000,70.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<44.110000,0.000000,70.890000>}
box{<0,0,-0.406400><0.724017,0.035000,0.406400> rotate<0,-32.590430,0> translate<43.500000,0.000000,70.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<34.690000,-1.535000,42.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<44.500000,-1.535000,42.000000>}
box{<0,0,-0.965200><9.810000,0.035000,0.965200> rotate<0,0.000000,0> translate<34.690000,-1.535000,42.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<44.780000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<44.780000,-1.535000,6.720000>}
box{<0,0,-0.965200><3.870000,0.035000,0.965200> rotate<0,-90.000000,0> translate<44.780000,-1.535000,6.720000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.780000,-1.535000,14.770000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<44.780000,-1.535000,10.590000>}
box{<0,0,-0.965200><4.297953,0.035000,0.965200> rotate<0,76.540696,0> translate<43.780000,-1.535000,14.770000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<44.110000,0.000000,70.890000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<45.110000,0.000000,70.690000>}
box{<0,0,-0.406400><1.019804,0.035000,0.406400> rotate<0,11.309186,0> translate<44.110000,0.000000,70.890000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<32.500000,-1.535000,6.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.500000,-1.535000,6.000000>}
box{<0,0,-0.965200><13.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<32.500000,-1.535000,6.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<44.780000,-1.535000,6.720000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.500000,-1.535000,6.000000>}
box{<0,0,-0.965200><1.018234,0.035000,0.965200> rotate<0,44.997030,0> translate<44.780000,-1.535000,6.720000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.640000,-1.535000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.640000,-1.535000,52.170000>}
box{<0,0,-0.965200><2.770000,0.035000,0.965200> rotate<0,-90.000000,0> translate<45.640000,-1.535000,52.170000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.640000,-1.535000,52.170000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.810000,-1.535000,51.500000>}
box{<0,0,-0.965200><0.691231,0.035000,0.965200> rotate<0,75.757719,0> translate<45.640000,-1.535000,52.170000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.500000,0.000000,73.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<46.000000,0.000000,73.500000>}
box{<0,0,-0.406400><14.500000,0.035000,0.406400> rotate<0,0.000000,0> translate<31.500000,0.000000,73.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<44.500000,-1.535000,42.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<46.480000,-1.535000,41.020000>}
box{<0,0,-0.965200><2.209253,0.035000,0.965200> rotate<0,26.331348,0> translate<44.500000,-1.535000,42.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<46.480000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<46.480000,-1.535000,41.020000>}
box{<0,0,-0.965200><3.060000,0.035000,0.965200> rotate<0,90.000000,0> translate<46.480000,-1.535000,41.020000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<46.480000,-1.535000,41.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<46.480000,-1.535000,47.480000>}
box{<0,0,-0.965200><6.460000,0.035000,0.965200> rotate<0,90.000000,0> translate<46.480000,-1.535000,47.480000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.000000,-1.535000,24.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<47.320000,-1.535000,15.680000>}
box{<0,0,-0.965200><9.821140,0.035000,0.965200> rotate<0,63.900358,0> translate<43.000000,-1.535000,24.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<47.320000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<47.320000,-1.535000,15.680000>}
box{<0,0,-0.965200><5.090000,0.035000,0.965200> rotate<0,90.000000,0> translate<47.320000,-1.535000,15.680000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.500000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<47.500000,-1.535000,75.500000>}
box{<0,0,-0.406400><7.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<40.500000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<46.000000,0.000000,73.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<47.650000,0.000000,72.850000>}
box{<0,0,-0.406400><1.773415,0.035000,0.406400> rotate<0,21.500015,0> translate<46.000000,0.000000,73.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<47.650000,0.000000,70.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<47.650000,0.000000,72.850000>}
box{<0,0,-0.406400><2.160000,0.035000,0.406400> rotate<0,90.000000,0> translate<47.650000,0.000000,72.850000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<46.480000,-1.535000,47.480000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,50.500000>}
box{<0,0,-0.965200><3.633291,0.035000,0.965200> rotate<0,-56.218748,0> translate<46.480000,-1.535000,47.480000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,50.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,51.000000>}
box{<0,0,-0.965200><0.500000,0.035000,0.965200> rotate<0,90.000000,0> translate<48.500000,-1.535000,51.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,51.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,57.000000>}
box{<0,0,-0.965200><6.000000,0.035000,0.965200> rotate<0,90.000000,0> translate<48.500000,-1.535000,57.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<43.000000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.000000,-1.535000,28.000000>}
box{<0,0,-0.965200><6.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<43.000000,-1.535000,28.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,51.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.000000,-1.535000,51.500000>}
box{<0,0,-0.965200><0.707107,0.035000,0.965200> rotate<0,-44.997030,0> translate<48.500000,-1.535000,51.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.020000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.020000,-1.535000,28.520000>}
box{<0,0,-0.965200><9.440000,0.035000,0.965200> rotate<0,-90.000000,0> translate<49.020000,-1.535000,28.520000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.000000,-1.535000,43.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.020000,-1.535000,41.480000>}
box{<0,0,-0.406400><1.520132,0.035000,0.406400> rotate<0,89.240262,0> translate<49.000000,-1.535000,43.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.020000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.020000,-1.535000,41.480000>}
box{<0,0,-0.406400><3.520000,0.035000,0.406400> rotate<0,90.000000,0> translate<49.020000,-1.535000,41.480000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.000000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.250000,-1.535000,26.750000>}
box{<0,0,-0.635000><1.274755,0.035000,0.635000> rotate<0,78.684874,0> translate<49.000000,-1.535000,28.000000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<49.020000,-1.535000,28.520000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<49.250000,-1.535000,26.750000>}
box{<0,0,-0.838200><1.784881,0.035000,0.838200> rotate<0,82.590820,0> translate<49.020000,-1.535000,28.520000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.000000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.690000,-1.535000,51.500000>}
box{<0,0,-0.965200><0.690000,0.035000,0.965200> rotate<0,0.000000,0> translate<49.000000,-1.535000,51.500000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<49.590000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<49.860000,-1.535000,10.590000>}
box{<0,0,-0.838200><0.270000,0.035000,0.838200> rotate<0,0.000000,0> translate<49.590000,-1.535000,10.590000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.500000,-1.535000,7.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<50.000000,-1.535000,10.500000>}
box{<0,0,-0.965200><3.535534,0.035000,0.965200> rotate<0,-81.864495,0> translate<49.500000,-1.535000,7.000000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.590000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<50.000000,-1.535000,10.500000>}
box{<0,0,-0.635000><0.419762,0.035000,0.635000> rotate<0,12.379940,0> translate<49.590000,-1.535000,10.590000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<40.000000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<50.000000,-1.535000,59.000000>}
box{<0,0,-0.965200><10.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<40.000000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<48.500000,-1.535000,57.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<50.000000,-1.535000,59.000000>}
box{<0,0,-0.965200><2.500000,0.035000,0.965200> rotate<0,-53.126596,0> translate<48.500000,-1.535000,57.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.000000,-1.535000,73.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.000000,-1.535000,70.880000>}
box{<0,0,-0.406400><2.120000,0.035000,0.406400> rotate<0,-90.000000,0> translate<50.000000,-1.535000,70.880000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<47.500000,-1.535000,75.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.000000,-1.535000,73.000000>}
box{<0,0,-0.406400><3.535534,0.035000,0.406400> rotate<0,44.997030,0> translate<47.500000,-1.535000,75.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<45.640000,0.000000,62.560000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.080000,0.000000,66.000000>}
box{<0,0,-0.406400><5.616689,0.035000,0.406400> rotate<0,-37.765129,0> translate<45.640000,0.000000,62.560000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.000000,-1.535000,70.880000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.190000,-1.535000,70.690000>}
box{<0,0,-0.406400><0.268701,0.035000,0.406400> rotate<0,44.997030,0> translate<50.000000,-1.535000,70.880000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<45.500000,-1.535000,6.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<50.500000,-1.535000,6.000000>}
box{<0,0,-0.965200><5.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<45.500000,-1.535000,6.000000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<49.500000,-1.535000,7.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<50.500000,-1.535000,6.000000>}
box{<0,0,-0.838200><1.414214,0.035000,0.838200> rotate<0,44.997030,0> translate<49.500000,-1.535000,7.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<49.000000,-1.535000,43.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.000000,-1.535000,45.000000>}
box{<0,0,-0.406400><2.828427,0.035000,0.406400> rotate<0,-44.997030,0> translate<49.000000,-1.535000,43.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<43.500000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.500000,-1.535000,66.000000>}
box{<0,0,-0.406400><8.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<43.500000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.500000,0.000000,38.520000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.560000,0.000000,37.960000>}
box{<0,0,-0.406400><0.563205,0.035000,0.406400> rotate<0,83.878960,0> translate<51.500000,0.000000,38.520000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.500000,0.000000,38.520000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.000000,0.000000,51.000000>}
box{<0,0,-0.406400><12.490012,0.035000,0.406400> rotate<0,-87.699935,0> translate<51.500000,0.000000,38.520000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.000000,0.000000,52.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.000000,0.000000,51.000000>}
box{<0,0,-0.406400><1.000000,0.035000,0.406400> rotate<0,-90.000000,0> translate<52.000000,0.000000,51.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<49.250000,-1.535000,26.750000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<52.400000,-1.535000,22.100000>}
box{<0,0,-0.965200><5.616494,0.035000,0.965200> rotate<0,55.881839,0> translate<49.250000,-1.535000,26.750000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<52.400000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<52.400000,-1.535000,22.100000>}
box{<0,0,-0.965200><11.510000,0.035000,0.965200> rotate<0,90.000000,0> translate<52.400000,-1.535000,22.100000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.000000,0.000000,52.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.400000,0.000000,53.900000>}
box{<0,0,-0.406400><1.941649,0.035000,0.406400> rotate<0,-78.106187,0> translate<52.000000,0.000000,52.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.400000,0.000000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.400000,0.000000,53.900000>}
box{<0,0,-0.406400><1.040000,0.035000,0.406400> rotate<0,-90.000000,0> translate<52.400000,0.000000,53.900000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.000000,0.000000,51.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.690000,0.000000,50.310000>}
box{<0,0,-0.406400><0.975807,0.035000,0.406400> rotate<0,44.997030,0> translate<52.000000,0.000000,51.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.500000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.000000,-1.535000,66.000000>}
box{<0,0,-0.406400><1.500000,0.035000,0.406400> rotate<0,0.000000,0> translate<51.500000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.500000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.250000,-1.535000,65.750000>}
box{<0,0,-0.406400><1.767767,0.035000,0.406400> rotate<0,8.129566,0> translate<51.500000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.000000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.250000,-1.535000,65.750000>}
box{<0,0,-0.406400><0.353553,0.035000,0.406400> rotate<0,44.997030,0> translate<53.000000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<42.500000,0.000000,68.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.500000,0.000000,68.000000>}
box{<0,0,-0.406400><11.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<42.500000,0.000000,68.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.250000,-1.535000,65.750000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.940000,-1.535000,65.060000>}
box{<0,0,-0.406400><0.975807,0.035000,0.406400> rotate<0,44.997030,0> translate<53.250000,-1.535000,65.750000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.690000,0.000000,50.310000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.000000,0.000000,48.810000>}
box{<0,0,-0.406400><1.991507,0.035000,0.406400> rotate<0,48.864979,0> translate<52.690000,0.000000,50.310000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<50.080000,0.000000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.000000,0.000000,66.000000>}
box{<0,0,-0.406400><3.920000,0.035000,0.406400> rotate<0,0.000000,0> translate<50.080000,0.000000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<52.730000,-1.535000,70.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.730000,-1.535000,62.770000>}
box{<0,0,-0.406400><8.168623,0.035000,0.406400> rotate<0,75.822658,0> translate<52.730000,-1.535000,70.690000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<54.940000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<54.940000,-1.535000,7.560000>}
box{<0,0,-0.965200><3.030000,0.035000,0.965200> rotate<0,-90.000000,0> translate<54.940000,-1.535000,7.560000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.940000,-1.535000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.940000,-1.535000,51.560000>}
box{<0,0,-0.406400><3.380000,0.035000,0.406400> rotate<0,-90.000000,0> translate<54.940000,-1.535000,51.560000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.940000,-1.535000,65.060000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.940000,-1.535000,62.560000>}
box{<0,0,-0.406400><2.692582,0.035000,0.406400> rotate<0,68.194090,0> translate<53.940000,-1.535000,65.060000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.730000,-1.535000,62.770000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.940000,-1.535000,62.560000>}
box{<0,0,-0.406400><0.296985,0.035000,0.406400> rotate<0,44.997030,0> translate<54.730000,-1.535000,62.770000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<51.000000,-1.535000,45.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.000000,-1.535000,45.000000>}
box{<0,0,-0.406400><4.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<51.000000,-1.535000,45.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.500000,0.000000,68.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.270000,0.000000,68.770000>}
box{<0,0,-0.406400><1.930233,0.035000,0.406400> rotate<0,-23.508850,0> translate<53.500000,0.000000,68.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.270000,0.000000,70.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.270000,0.000000,68.770000>}
box{<0,0,-0.406400><1.920000,0.035000,0.406400> rotate<0,-90.000000,0> translate<55.270000,0.000000,68.770000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<55.500000,-1.535000,28.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<55.500000,-1.535000,17.500000>}
box{<0,0,-0.965200><11.000000,0.035000,0.965200> rotate<0,-90.000000,0> translate<55.500000,-1.535000,17.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<55.000000,-1.535000,45.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<56.000000,-1.535000,46.000000>}
box{<0,0,-0.406400><1.414214,0.035000,0.406400> rotate<0,-44.997030,0> translate<55.000000,-1.535000,45.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<56.000000,-1.535000,49.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<56.000000,-1.535000,46.000000>}
box{<0,0,-0.406400><3.500000,0.035000,0.406400> rotate<0,-90.000000,0> translate<56.000000,-1.535000,46.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.940000,-1.535000,51.560000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<56.000000,-1.535000,49.500000>}
box{<0,0,-0.406400><2.316722,0.035000,0.406400> rotate<0,62.767178,0> translate<54.940000,-1.535000,51.560000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<50.500000,-1.535000,6.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<56.500000,-1.535000,6.000000>}
box{<0,0,-0.965200><6.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<50.500000,-1.535000,6.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<54.940000,-1.535000,7.560000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<56.500000,-1.535000,6.000000>}
box{<0,0,-0.965200><2.206173,0.035000,0.965200> rotate<0,44.997030,0> translate<54.940000,-1.535000,7.560000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<55.500000,-1.535000,17.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.000000,-1.535000,14.500000>}
box{<0,0,-0.965200><3.354102,0.035000,0.965200> rotate<0,63.430762,0> translate<55.500000,-1.535000,17.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.310000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.310000,-1.535000,54.770000>}
box{<0,0,-0.965200><3.270000,0.035000,0.965200> rotate<0,90.000000,0> translate<57.310000,-1.535000,54.770000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.310000,-1.535000,54.770000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.480000,-1.535000,54.940000>}
box{<0,0,-0.965200><0.240416,0.035000,0.965200> rotate<0,-44.997030,0> translate<57.310000,-1.535000,54.770000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.000000,-1.535000,14.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.500000,-1.535000,10.610000>}
box{<0,0,-0.965200><3.922002,0.035000,0.965200> rotate<0,82.670207,0> translate<57.000000,-1.535000,14.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.480000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<57.500000,-1.535000,10.610000>}
box{<0,0,-0.965200><0.028284,0.035000,0.965200> rotate<0,-44.997030,0> translate<57.480000,-1.535000,10.590000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<54.000000,0.000000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<57.810000,0.000000,68.810000>}
box{<0,0,-0.406400><4.734153,0.035000,0.406400> rotate<0,-36.407589,0> translate<54.000000,0.000000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<57.810000,0.000000,70.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<57.810000,0.000000,68.810000>}
box{<0,0,-0.406400><1.880000,0.035000,0.406400> rotate<0,-90.000000,0> translate<57.810000,0.000000,68.810000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<54.000000,-1.535000,41.190000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<58.190000,-1.535000,41.190000>}
box{<0,0,-0.965200><4.190000,0.035000,0.965200> rotate<0,0.000000,0> translate<54.000000,-1.535000,41.190000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<55.500000,-1.535000,28.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<58.850000,-1.535000,31.850000>}
box{<0,0,-0.965200><4.737615,0.035000,0.965200> rotate<0,-44.997030,0> translate<55.500000,-1.535000,28.500000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.850000,-1.535000,35.260000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.850000,-1.535000,31.850000>}
box{<0,0,-0.635000><3.410000,0.035000,0.635000> rotate<0,-90.000000,0> translate<58.850000,-1.535000,31.850000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.850000,-1.535000,35.260000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.850000,-1.535000,33.150000>}
box{<0,0,-0.635000><2.110000,0.035000,0.635000> rotate<0,-90.000000,0> translate<58.850000,-1.535000,33.150000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<56.500000,-1.535000,6.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<59.000000,-1.535000,6.000000>}
box{<0,0,-0.965200><2.500000,0.035000,0.965200> rotate<0,0.000000,0> translate<56.500000,-1.535000,6.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<59.000000,-1.535000,6.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.000000,-1.535000,7.000000>}
box{<0,0,-0.965200><1.414214,0.035000,0.965200> rotate<0,-44.997030,0> translate<59.000000,-1.535000,6.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.000000,-1.535000,7.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.000000,-1.535000,10.570000>}
box{<0,0,-0.965200><3.570000,0.035000,0.965200> rotate<0,90.000000,0> translate<60.000000,-1.535000,10.570000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<60.000000,-1.535000,10.570000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<60.020000,-1.535000,10.590000>}
box{<0,0,-0.635000><0.028284,0.035000,0.635000> rotate<0,-44.997030,0> translate<60.000000,-1.535000,10.570000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<58.850000,-1.535000,20.020000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.020000,-1.535000,18.850000>}
box{<0,0,-0.965200><1.654630,0.035000,0.965200> rotate<0,44.997030,0> translate<58.850000,-1.535000,20.020000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.020000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.020000,-1.535000,18.850000>}
box{<0,0,-0.965200><8.260000,0.035000,0.965200> rotate<0,90.000000,0> translate<60.020000,-1.535000,18.850000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<57.480000,0.000000,62.560000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<60.350000,0.000000,67.430000>}
box{<0,0,-0.406400><5.652769,0.035000,0.406400> rotate<0,-59.484277,0> translate<57.480000,0.000000,62.560000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<60.350000,0.000000,70.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<60.350000,0.000000,67.430000>}
box{<0,0,-0.406400><3.260000,0.035000,0.406400> rotate<0,-90.000000,0> translate<60.350000,0.000000,67.430000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<58.190000,-1.535000,41.190000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.500000,-1.535000,48.000000>}
box{<0,0,-0.965200><7.191120,0.035000,0.965200> rotate<0,-71.257999,0> translate<58.190000,-1.535000,41.190000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.500000,-1.535000,48.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.839325,-1.535000,52.562922>}
box{<0,0,-0.965200><4.575522,0.035000,0.965200> rotate<0,-85.741327,0> translate<60.500000,-1.535000,48.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.839325,-1.535000,52.562922>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<61.000000,-1.535000,58.500000>}
box{<0,0,-0.965200><5.939252,0.035000,0.965200> rotate<0,-88.443947,0> translate<60.839325,-1.535000,52.562922> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<50.000000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<61.000000,-1.535000,59.000000>}
box{<0,0,-0.965200><11.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<50.000000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<61.000000,-1.535000,58.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<61.250000,-1.535000,58.750000>}
box{<0,0,-0.406400><0.353553,0.035000,0.406400> rotate<0,-44.997030,0> translate<61.000000,-1.535000,58.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<61.000000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<61.250000,-1.535000,58.750000>}
box{<0,0,-0.406400><0.353553,0.035000,0.406400> rotate<0,44.997030,0> translate<61.000000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<61.250000,-1.535000,58.750000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<61.500000,-1.535000,59.000000>}
box{<0,0,-0.406400><0.353553,0.035000,0.406400> rotate<0,-44.997030,0> translate<61.250000,-1.535000,58.750000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<60.839325,-1.535000,52.562922>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<61.902247,-1.535000,51.500000>}
box{<0,0,-0.965200><1.503199,0.035000,0.965200> rotate<0,44.997030,0> translate<60.839325,-1.535000,52.562922> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<61.690000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<61.902247,-1.535000,51.500000>}
box{<0,0,-0.965200><0.212247,0.035000,0.965200> rotate<0,0.000000,0> translate<61.690000,-1.535000,51.500000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<58.850000,-1.535000,33.150000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<63.000000,-1.535000,29.000000>}
box{<0,0,-0.965200><5.868986,0.035000,0.965200> rotate<0,44.997030,0> translate<58.850000,-1.535000,33.150000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<64.240000,0.000000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<64.240000,0.000000,51.260000>}
box{<0,0,-0.406400><3.680000,0.035000,0.406400> rotate<0,-90.000000,0> translate<64.240000,0.000000,51.260000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<64.500000,-1.535000,37.680000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<64.780000,-1.535000,37.960000>}
box{<0,0,-0.838200><0.395980,0.035000,0.838200> rotate<0,-44.997030,0> translate<64.500000,-1.535000,37.680000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<62.890000,0.000000,70.690000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<64.890000,0.000000,70.110000>}
box{<0,0,-0.406400><2.082402,0.035000,0.406400> rotate<0,16.171092,0> translate<62.890000,0.000000,70.690000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<58.190000,-1.535000,41.190000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<65.000000,-1.535000,41.190000>}
box{<0,0,-0.965200><6.810000,0.035000,0.965200> rotate<0,0.000000,0> translate<58.190000,-1.535000,41.190000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<64.500000,-1.535000,37.680000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<65.000000,-1.535000,41.190000>}
box{<0,0,-0.965200><3.545434,0.035000,0.965200> rotate<0,-81.887347,0> translate<64.500000,-1.535000,37.680000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<64.240000,0.000000,51.260000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<65.000000,0.000000,49.500000>}
box{<0,0,-0.406400><1.917081,0.035000,0.406400> rotate<0,66.640037,0> translate<64.240000,0.000000,51.260000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<65.000000,0.000000,48.810000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<65.000000,0.000000,49.500000>}
box{<0,0,-0.406400><0.690000,0.035000,0.406400> rotate<0,90.000000,0> translate<65.000000,0.000000,49.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<53.000000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<65.000000,-1.535000,66.000000>}
box{<0,0,-0.406400><12.000000,0.035000,0.406400> rotate<0,0.000000,0> translate<53.000000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<63.000000,-1.535000,29.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.000000,-1.535000,29.000000>}
box{<0,0,-0.965200><3.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<63.000000,-1.535000,29.000000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<61.500000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.500000,-1.535000,59.000000>}
box{<0,0,-0.965200><5.000000,0.035000,0.965200> rotate<0,0.000000,0> translate<61.500000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,54.940000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,52.220000>}
box{<0,0,-0.406400><2.720000,0.035000,0.406400> rotate<0,-90.000000,0> translate<66.780000,-1.535000,52.220000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<65.000000,-1.535000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,65.220000>}
box{<0,0,-0.406400><1.943399,0.035000,0.406400> rotate<0,23.661579,0> translate<65.000000,-1.535000,66.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,62.560000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,65.220000>}
box{<0,0,-0.406400><2.660000,0.035000,0.406400> rotate<0,90.000000,0> translate<66.780000,-1.535000,65.220000> }
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<66.500000,-1.535000,59.000000>}
cylinder{<0,0,0><0,0.035000,0>0.838200 translate<67.000000,-1.535000,59.500000>}
box{<0,0,-0.838200><0.707107,0.035000,0.838200> rotate<0,-44.997030,0> translate<66.500000,-1.535000,59.000000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,62.560000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.000000,-1.535000,62.340000>}
box{<0,0,-0.406400><0.311127,0.035000,0.406400> rotate<0,44.997030,0> translate<66.780000,-1.535000,62.560000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<67.000000,-1.535000,59.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<67.000000,-1.535000,62.340000>}
box{<0,0,-0.965200><2.840000,0.035000,0.965200> rotate<0,90.000000,0> translate<67.000000,-1.535000,62.340000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<66.000000,-1.535000,29.000000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<67.500000,-1.535000,30.500000>}
box{<0,0,-0.965200><2.121320,0.035000,0.965200> rotate<0,-44.997030,0> translate<66.000000,-1.535000,29.000000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<67.320000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<67.500000,-1.535000,37.780000>}
box{<0,0,-0.635000><0.254558,0.035000,0.635000> rotate<0,44.997030,0> translate<67.320000,-1.535000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<67.500000,-1.535000,30.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<67.500000,-1.535000,37.780000>}
box{<0,0,-0.965200><7.280000,0.035000,0.965200> rotate<0,90.000000,0> translate<67.500000,-1.535000,37.780000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.320000,-1.535000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.500000,-1.535000,38.140000>}
box{<0,0,-0.406400><0.254558,0.035000,0.406400> rotate<0,-44.997030,0> translate<67.320000,-1.535000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.500000,-1.535000,50.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.500000,-1.535000,38.140000>}
box{<0,0,-0.406400><11.860000,0.035000,0.406400> rotate<0,-90.000000,0> translate<67.500000,-1.535000,38.140000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<65.000000,0.000000,49.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.500000,0.000000,49.500000>}
box{<0,0,-0.406400><2.500000,0.035000,0.406400> rotate<0,0.000000,0> translate<65.000000,0.000000,49.500000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<66.780000,-1.535000,52.220000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.500000,-1.535000,50.000000>}
box{<0,0,-0.406400><2.333838,0.035000,0.406400> rotate<0,72.026107,0> translate<66.780000,-1.535000,52.220000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<69.000000,0.000000,66.000000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<69.000000,0.000000,62.880000>}
box{<0,0,-0.406400><3.120000,0.035000,0.406400> rotate<0,-90.000000,0> translate<69.000000,0.000000,62.880000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<64.890000,0.000000,70.110000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<69.000000,0.000000,66.000000>}
box{<0,0,-0.406400><5.812418,0.035000,0.406400> rotate<0,44.997030,0> translate<64.890000,0.000000,70.110000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<69.310000,-1.535000,51.500000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<69.310000,-1.535000,54.930000>}
box{<0,0,-0.965200><3.430000,0.035000,0.965200> rotate<0,90.000000,0> translate<69.310000,-1.535000,54.930000> }
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<69.310000,-1.535000,54.930000>}
cylinder{<0,0,0><0,0.035000,0>0.965200 translate<69.320000,-1.535000,54.940000>}
box{<0,0,-0.965200><0.014142,0.035000,0.965200> rotate<0,-44.997030,0> translate<69.310000,-1.535000,54.930000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<69.000000,0.000000,62.880000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<69.320000,0.000000,62.560000>}
box{<0,0,-0.406400><0.452548,0.035000,0.406400> rotate<0,44.997030,0> translate<69.000000,0.000000,62.880000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<69.860000,0.000000,37.960000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<70.000000,0.000000,38.100000>}
box{<0,0,-0.406400><0.197990,0.035000,0.406400> rotate<0,-44.997030,0> translate<69.860000,0.000000,37.960000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<70.000000,0.000000,47.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<70.000000,0.000000,38.100000>}
box{<0,0,-0.406400><9.400000,0.035000,0.406400> rotate<0,-90.000000,0> translate<70.000000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<67.500000,0.000000,49.500000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<70.000000,0.000000,47.500000>}
box{<0,0,-0.406400><3.201562,0.035000,0.406400> rotate<0,38.657257,0> translate<67.500000,0.000000,49.500000> }
//Text
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.830397,0.000000,5.525297>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.635497,0.000000,5.720197>}
box{<0,0,-0.050800><0.275630,0.035000,0.050800> rotate<0,44.997030,0> translate<16.635497,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.635497,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.245697,0.000000,5.720197>}
box{<0,0,-0.050800><0.389800,0.035000,0.050800> rotate<0,0.000000,0> translate<16.245697,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.245697,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.050800,0.000000,5.525297>}
box{<0,0,-0.050800><0.275628,0.035000,0.050800> rotate<0,-44.997489,0> translate<16.050800,0.000000,5.525297> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.050800,0.000000,5.525297>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.050800,0.000000,4.745697>}
box{<0,0,-0.050800><0.779600,0.035000,0.050800> rotate<0,-90.000000,0> translate<16.050800,0.000000,4.745697> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.050800,0.000000,4.745697>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.245697,0.000000,4.550800>}
box{<0,0,-0.050800><0.275626,0.035000,0.050800> rotate<0,44.997030,0> translate<16.050800,0.000000,4.745697> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.245697,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.635497,0.000000,4.550800>}
box{<0,0,-0.050800><0.389800,0.035000,0.050800> rotate<0,0.000000,0> translate<16.245697,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.635497,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.830397,0.000000,4.745697>}
box{<0,0,-0.050800><0.275628,0.035000,0.050800> rotate<0,-44.996571,0> translate<16.635497,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.830397,0.000000,4.745697>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.830397,0.000000,5.135497>}
box{<0,0,-0.050800><0.389800,0.035000,0.050800> rotate<0,90.000000,0> translate<16.830397,0.000000,5.135497> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.830397,0.000000,5.135497>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<16.440597,0.000000,5.135497>}
box{<0,0,-0.050800><0.389800,0.035000,0.050800> rotate<0,0.000000,0> translate<16.440597,0.000000,5.135497> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<17.220197,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<17.220197,0.000000,5.720197>}
box{<0,0,-0.050800><1.169397,0.035000,0.050800> rotate<0,90.000000,0> translate<17.220197,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<17.220197,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<17.999794,0.000000,4.550800>}
box{<0,0,-0.050800><1.405440,0.035000,0.050800> rotate<0,56.306252,0> translate<17.220197,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<17.999794,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<17.999794,0.000000,5.720197>}
box{<0,0,-0.050800><1.169397,0.035000,0.050800> rotate<0,90.000000,0> translate<17.999794,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.389594,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.389594,0.000000,4.550800>}
box{<0,0,-0.050800><1.169397,0.035000,0.050800> rotate<0,-90.000000,0> translate<18.389594,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.389594,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.974291,0.000000,4.550800>}
box{<0,0,-0.050800><0.584697,0.035000,0.050800> rotate<0,0.000000,0> translate<18.389594,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.974291,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<19.169191,0.000000,4.745697>}
box{<0,0,-0.050800><0.275628,0.035000,0.050800> rotate<0,-44.996571,0> translate<18.974291,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<19.169191,0.000000,4.745697>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<19.169191,0.000000,5.525297>}
box{<0,0,-0.050800><0.779600,0.035000,0.050800> rotate<0,90.000000,0> translate<19.169191,0.000000,5.525297> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<19.169191,0.000000,5.525297>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.974291,0.000000,5.720197>}
box{<0,0,-0.050800><0.275630,0.035000,0.050800> rotate<0,44.997030,0> translate<18.974291,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.974291,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<18.389594,0.000000,5.720197>}
box{<0,0,-0.050800><0.584697,0.035000,0.050800> rotate<0,0.000000,0> translate<18.389594,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<25.050800,0.000000,5.135497>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<25.830397,0.000000,5.135497>}
box{<0,0,-0.050800><0.779597,0.035000,0.050800> rotate<0,0.000000,0> translate<25.050800,0.000000,5.135497> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<25.440597,0.000000,5.525297>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<25.440597,0.000000,4.745697>}
box{<0,0,-0.050800><0.779600,0.035000,0.050800> rotate<0,-90.000000,0> translate<25.440597,0.000000,4.745697> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<26.220197,0.000000,5.330397>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<26.609994,0.000000,5.720197>}
box{<0,0,-0.050800><0.551258,0.035000,0.050800> rotate<0,-44.997260,0> translate<26.220197,0.000000,5.330397> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<26.609994,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<26.609994,0.000000,4.550800>}
box{<0,0,-0.050800><1.169397,0.035000,0.050800> rotate<0,-90.000000,0> translate<26.609994,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<26.220197,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<26.999794,0.000000,4.550800>}
box{<0,0,-0.050800><0.779597,0.035000,0.050800> rotate<0,0.000000,0> translate<26.220197,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<27.389594,0.000000,5.330397>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<27.779391,0.000000,5.720197>}
box{<0,0,-0.050800><0.551258,0.035000,0.050800> rotate<0,-44.997260,0> translate<27.389594,0.000000,5.330397> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<27.779391,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<27.779391,0.000000,4.550800>}
box{<0,0,-0.050800><1.169397,0.035000,0.050800> rotate<0,-90.000000,0> translate<27.779391,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<27.389594,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.169191,0.000000,4.550800>}
box{<0,0,-0.050800><0.779597,0.035000,0.050800> rotate<0,0.000000,0> translate<27.389594,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.558991,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.558991,0.000000,4.745697>}
box{<0,0,-0.050800><0.194897,0.035000,0.050800> rotate<0,90.000000,0> translate<28.558991,0.000000,4.745697> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.558991,0.000000,4.745697>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.753888,0.000000,4.745697>}
box{<0,0,-0.050800><0.194897,0.035000,0.050800> rotate<0,0.000000,0> translate<28.558991,0.000000,4.745697> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.753888,0.000000,4.745697>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.753888,0.000000,4.550800>}
box{<0,0,-0.050800><0.194897,0.035000,0.050800> rotate<0,-90.000000,0> translate<28.753888,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.753888,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<28.558991,0.000000,4.550800>}
box{<0,0,-0.050800><0.194897,0.035000,0.050800> rotate<0,0.000000,0> translate<28.558991,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<29.143688,0.000000,5.330397>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<29.533484,0.000000,5.720197>}
box{<0,0,-0.050800><0.551258,0.035000,0.050800> rotate<0,-44.997260,0> translate<29.143688,0.000000,5.330397> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<29.533484,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<29.533484,0.000000,4.550800>}
box{<0,0,-0.050800><1.169397,0.035000,0.050800> rotate<0,-90.000000,0> translate<29.533484,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<29.143688,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<29.923284,0.000000,4.550800>}
box{<0,0,-0.050800><0.779597,0.035000,0.050800> rotate<0,0.000000,0> translate<29.143688,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<30.313084,0.000000,5.720197>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<30.313084,0.000000,4.940597>}
box{<0,0,-0.050800><0.779600,0.035000,0.050800> rotate<0,-90.000000,0> translate<30.313084,0.000000,4.940597> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<30.313084,0.000000,4.940597>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<30.702881,0.000000,4.550800>}
box{<0,0,-0.050800><0.551256,0.035000,0.050800> rotate<0,44.997030,0> translate<30.313084,0.000000,4.940597> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<30.702881,0.000000,4.550800>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<31.092681,0.000000,4.940597>}
box{<0,0,-0.050800><0.551258,0.035000,0.050800> rotate<0,-44.996801,0> translate<30.702881,0.000000,4.550800> }
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<31.092681,0.000000,4.940597>}
cylinder{<0,0,0><0,0.035000,0>0.050800 translate<31.092681,0.000000,5.720197>}
box{<0,0,-0.050800><0.779600,0.035000,0.050800> rotate<0,90.000000,0> translate<31.092681,0.000000,5.720197> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<12.563500,0.000000,84.114225>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<12.563500,0.000000,82.563500>}
box{<0,0,-0.063500><1.550725,0.035000,0.063500> rotate<0,-90.000000,0> translate<12.563500,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<12.563500,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.597316,0.000000,82.563500>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,0.000000,0> translate<12.563500,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,82.821953>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<14.107106,0.000000,82.821953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,82.821953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.365559,0.000000,82.563500>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<14.107106,0.000000,82.821953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.365559,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,82.563500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<14.365559,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,83.597316>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,90.000000,0> translate<15.140922,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.650713,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,83.597316>}
box{<0,0,-0.063500><0.258453,0.035000,0.063500> rotate<0,0.000000,0> translate<15.650713,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,82.563500>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,-90.000000,0> translate<15.909166,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.650713,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.167619,0.000000,82.563500>}
box{<0,0,-0.063500><0.516906,0.035000,0.063500> rotate<0,0.000000,0> translate<15.650713,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,84.372678>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,84.114225>}
box{<0,0,-0.063500><0.258453,0.035000,0.063500> rotate<0,-90.000000,0> translate<15.909166,0.000000,84.114225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.679781,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.455144,0.000000,82.563500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<16.679781,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.455144,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.713597,0.000000,82.821953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<17.455144,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.713597,0.000000,82.821953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.455144,0.000000,83.080406>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<17.455144,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.455144,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.938234,0.000000,83.080406>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<16.938234,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.938234,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.679781,0.000000,83.338863>}
box{<0,0,-0.063500><0.365510,0.035000,0.063500> rotate<0,44.997377,0> translate<16.679781,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.679781,0.000000,83.338863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.938234,0.000000,83.597316>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<16.679781,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.938234,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.713597,0.000000,83.597316>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<16.938234,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<19.766994,0.000000,84.114225>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<19.766994,0.000000,83.080406>}
box{<0,0,-0.063500><1.033819,0.035000,0.063500> rotate<0,-90.000000,0> translate<19.766994,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<19.766994,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.283900,0.000000,82.563500>}
box{<0,0,-0.063500><0.731016,0.035000,0.063500> rotate<0,44.997030,0> translate<19.766994,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.283900,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.800809,0.000000,83.080406>}
box{<0,0,-0.063500><0.731018,0.035000,0.063500> rotate<0,-44.996857,0> translate<20.283900,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.800809,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.800809,0.000000,84.114225>}
box{<0,0,-0.063500><1.033819,0.035000,0.063500> rotate<0,90.000000,0> translate<20.800809,0.000000,84.114225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.310600,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.569053,0.000000,83.597316>}
box{<0,0,-0.063500><0.258453,0.035000,0.063500> rotate<0,0.000000,0> translate<21.310600,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.569053,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.569053,0.000000,82.563500>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,-90.000000,0> translate<21.569053,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.310600,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.827506,0.000000,82.563500>}
box{<0,0,-0.063500><0.516906,0.035000,0.063500> rotate<0,0.000000,0> translate<21.310600,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.569053,0.000000,84.372678>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.569053,0.000000,84.114225>}
box{<0,0,-0.063500><0.258453,0.035000,0.063500> rotate<0,-90.000000,0> translate<21.569053,0.000000,84.114225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.373484,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.598122,0.000000,83.597316>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<22.598122,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.598122,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.339669,0.000000,83.338863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<22.339669,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.339669,0.000000,83.338863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.339669,0.000000,82.821953>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,-90.000000,0> translate<22.339669,0.000000,82.821953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.339669,0.000000,82.821953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.598122,0.000000,82.563500>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<22.339669,0.000000,82.821953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<22.598122,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.373484,0.000000,82.563500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<22.598122,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.658638,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.141728,0.000000,82.563500>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<24.141728,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.141728,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.883275,0.000000,82.821953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<23.883275,0.000000,82.821953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.883275,0.000000,82.821953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.883275,0.000000,83.338863>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,90.000000,0> translate<23.883275,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.883275,0.000000,83.338863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.141728,0.000000,83.597316>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<23.883275,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.141728,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.658638,0.000000,83.597316>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<24.141728,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.658638,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.917091,0.000000,83.338863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<24.658638,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.917091,0.000000,83.338863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.917091,0.000000,83.080406>}
box{<0,0,-0.063500><0.258456,0.035000,0.063500> rotate<0,-90.000000,0> translate<24.917091,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.917091,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.883275,0.000000,83.080406>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,0.000000,0> translate<23.883275,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.426881,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.426881,0.000000,83.597316>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,90.000000,0> translate<25.426881,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.426881,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.202244,0.000000,83.597316>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<25.426881,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.202244,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.460697,0.000000,83.338863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<26.202244,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.460697,0.000000,83.338863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.460697,0.000000,82.563500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<26.460697,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.970488,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.745850,0.000000,82.563500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<26.970488,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.745850,0.000000,82.563500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.004303,0.000000,82.821953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<27.745850,0.000000,82.563500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.004303,0.000000,82.821953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.745850,0.000000,83.080406>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<27.745850,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.745850,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.228941,0.000000,83.080406>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<27.228941,0.000000,83.080406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.228941,0.000000,83.080406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.970488,0.000000,83.338863>}
box{<0,0,-0.063500><0.365510,0.035000,0.063500> rotate<0,44.997377,0> translate<26.970488,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.970488,0.000000,83.338863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.228941,0.000000,83.597316>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<26.970488,0.000000,83.338863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.228941,0.000000,83.597316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.004303,0.000000,83.597316>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<27.228941,0.000000,83.597316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<12.563500,0.000000,81.614225>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<12.563500,0.000000,81.355769>}
box{<0,0,-0.063500><0.258456,0.035000,0.063500> rotate<0,-90.000000,0> translate<12.563500,0.000000,81.355769> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<12.563500,0.000000,81.355769>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.080406,0.000000,80.838863>}
box{<0,0,-0.063500><0.731016,0.035000,0.063500> rotate<0,44.997030,0> translate<12.563500,0.000000,81.355769> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.080406,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.597316,0.000000,81.355769>}
box{<0,0,-0.063500><0.731018,0.035000,0.063500> rotate<0,-44.996857,0> translate<13.080406,0.000000,80.838863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.597316,0.000000,81.355769>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.597316,0.000000,81.614225>}
box{<0,0,-0.063500><0.258456,0.035000,0.063500> rotate<0,90.000000,0> translate<13.597316,0.000000,81.614225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.080406,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<13.080406,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<13.080406,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.365559,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.882469,0.000000,80.063500>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<14.365559,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.882469,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,80.321953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<14.882469,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,80.838863>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,90.000000,0> translate<15.140922,0.000000,80.838863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.140922,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.882469,0.000000,81.097316>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<14.882469,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.882469,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.365559,0.000000,81.097316>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<14.365559,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.365559,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,80.838863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<14.107106,0.000000,80.838863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,80.321953>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,-90.000000,0> translate<14.107106,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.107106,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<14.365559,0.000000,80.063500>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<14.107106,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.650713,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.426075,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<15.650713,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.426075,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.684528,0.000000,80.321953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<16.426075,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.684528,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.426075,0.000000,80.580406>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<16.426075,0.000000,80.580406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.426075,0.000000,80.580406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,80.580406>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<15.909166,0.000000,80.580406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,80.580406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.650713,0.000000,80.838863>}
box{<0,0,-0.063500><0.365510,0.035000,0.063500> rotate<0,44.997377,0> translate<15.650713,0.000000,80.838863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.650713,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,81.097316>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<15.650713,0.000000,80.838863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<15.909166,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<16.684528,0.000000,81.097316>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<15.909166,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.194319,0.000000,81.614225>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.194319,0.000000,80.063500>}
box{<0,0,-0.063500><1.550725,0.035000,0.063500> rotate<0,-90.000000,0> translate<17.194319,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.194319,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.452772,0.000000,81.097316>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<17.194319,0.000000,80.838863> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.452772,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.969681,0.000000,81.097316>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<17.452772,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<17.969681,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.228134,0.000000,80.838863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<17.969681,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.228134,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.228134,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<18.228134,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.737925,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.737925,0.000000,80.321953>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<18.737925,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.737925,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.996378,0.000000,80.063500>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<18.737925,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<18.996378,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<19.771741,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<18.996378,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<19.771741,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<19.771741,0.000000,81.097316>}
box{<0,0,-0.063500><1.033816,0.035000,0.063500> rotate<0,90.000000,0> translate<19.771741,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.539984,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.056894,0.000000,81.097316>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<20.539984,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.056894,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.315347,0.000000,80.838863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<21.056894,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.315347,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.315347,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<21.315347,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.315347,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.539984,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<20.539984,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.539984,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.281531,0.000000,80.321953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<20.281531,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.281531,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.539984,0.000000,80.580406>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<20.281531,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<20.539984,0.000000,80.580406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<21.315347,0.000000,80.580406>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<20.539984,0.000000,80.580406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.368744,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.368744,0.000000,81.614225>}
box{<0,0,-0.063500><1.550725,0.035000,0.063500> rotate<0,90.000000,0> translate<23.368744,0.000000,81.614225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<23.368744,0.000000,81.614225>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.402559,0.000000,80.063500>}
box{<0,0,-0.063500><1.863739,0.035000,0.063500> rotate<0,56.306243,0> translate<23.368744,0.000000,81.614225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.402559,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.402559,0.000000,81.614225>}
box{<0,0,-0.063500><1.550725,0.035000,0.063500> rotate<0,90.000000,0> translate<24.402559,0.000000,81.614225> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.170803,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.687712,0.000000,81.097316>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<25.170803,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.687712,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.946166,0.000000,80.838863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<25.687712,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.946166,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.946166,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<25.946166,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.946166,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.170803,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<25.170803,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.170803,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.912350,0.000000,80.321953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<24.912350,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<24.912350,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.170803,0.000000,80.580406>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<24.912350,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.170803,0.000000,80.580406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<25.946166,0.000000,80.580406>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<25.170803,0.000000,80.580406> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.455956,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.972863,0.000000,80.063500>}
box{<0,0,-0.063500><1.155840,0.035000,0.063500> rotate<0,63.430832,0> translate<26.455956,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<26.972863,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.489772,0.000000,81.097316>}
box{<0,0,-0.063500><1.155842,0.035000,0.063500> rotate<0,-63.430693,0> translate<26.972863,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.258016,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.774925,0.000000,81.097316>}
box{<0,0,-0.063500><0.516909,0.035000,0.063500> rotate<0,0.000000,0> translate<28.258016,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.774925,0.000000,81.097316>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<29.033378,0.000000,80.838863>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<28.774925,0.000000,81.097316> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<29.033378,0.000000,80.838863>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<29.033378,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,-90.000000,0> translate<29.033378,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<29.033378,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.258016,0.000000,80.063500>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<28.258016,0.000000,80.063500> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.258016,0.000000,80.063500>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.999562,0.000000,80.321953>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,44.997030,0> translate<27.999562,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<27.999562,0.000000,80.321953>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.258016,0.000000,80.580406>}
box{<0,0,-0.063500><0.365508,0.035000,0.063500> rotate<0,-44.997030,0> translate<27.999562,0.000000,80.321953> }
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<28.258016,0.000000,80.580406>}
cylinder{<0,0,0><0,0.035000,0>0.063500 translate<29.033378,0.000000,80.580406>}
box{<0,0,-0.063500><0.775362,0.035000,0.063500> rotate<0,0.000000,0> translate<28.258016,0.000000,80.580406> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<26.088900,0.000000,79.097216>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<26.088900,0.000000,77.423619>}
box{<0,0,-0.088900><1.673597,0.035000,0.088900> rotate<0,-90.000000,0> translate<26.088900,0.000000,77.423619> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<26.088900,0.000000,77.423619>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<26.423619,0.000000,77.088900>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,44.997030,0> translate<26.088900,0.000000,77.423619> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<26.423619,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<27.093056,0.000000,77.088900>}
box{<0,0,-0.088900><0.669437,0.035000,0.088900> rotate<0,0.000000,0> translate<26.423619,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<27.093056,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<27.427775,0.000000,77.423619>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,-44.997030,0> translate<27.093056,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<27.427775,0.000000,77.423619>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<27.427775,0.000000,79.097216>}
box{<0,0,-0.088900><1.673597,0.035000,0.088900> rotate<0,90.000000,0> translate<27.427775,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<29.439141,0.000000,78.762497>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<29.104422,0.000000,79.097216>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,44.997030,0> translate<29.104422,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<29.104422,0.000000,79.097216>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.434984,0.000000,79.097216>}
box{<0,0,-0.088900><0.669437,0.035000,0.088900> rotate<0,0.000000,0> translate<28.434984,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.434984,0.000000,79.097216>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.100266,0.000000,78.762497>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,-44.997030,0> translate<28.100266,0.000000,78.762497> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.100266,0.000000,78.762497>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.100266,0.000000,77.423619>}
box{<0,0,-0.088900><1.338878,0.035000,0.088900> rotate<0,-90.000000,0> translate<28.100266,0.000000,77.423619> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.100266,0.000000,77.423619>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.434984,0.000000,77.088900>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,44.997030,0> translate<28.100266,0.000000,77.423619> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<28.434984,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<29.104422,0.000000,77.088900>}
box{<0,0,-0.088900><0.669437,0.035000,0.088900> rotate<0,0.000000,0> translate<28.434984,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<29.104422,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<29.439141,0.000000,77.423619>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,-44.997030,0> translate<29.104422,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<30.111631,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<30.111631,0.000000,78.427775>}
box{<0,0,-0.088900><1.338875,0.035000,0.088900> rotate<0,90.000000,0> translate<30.111631,0.000000,78.427775> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<30.111631,0.000000,78.427775>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<30.781069,0.000000,79.097216>}
box{<0,0,-0.088900><0.946730,0.035000,0.088900> rotate<0,-44.997164,0> translate<30.111631,0.000000,78.427775> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<30.781069,0.000000,79.097216>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<31.450506,0.000000,78.427775>}
box{<0,0,-0.088900><0.946730,0.035000,0.088900> rotate<0,44.997164,0> translate<30.781069,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<31.450506,0.000000,78.427775>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<31.450506,0.000000,77.088900>}
box{<0,0,-0.088900><1.338875,0.035000,0.088900> rotate<0,-90.000000,0> translate<31.450506,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<30.111631,0.000000,78.093056>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<31.450506,0.000000,78.093056>}
box{<0,0,-0.088900><1.338875,0.035000,0.088900> rotate<0,0.000000,0> translate<30.111631,0.000000,78.093056> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<32.122997,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<32.122997,0.000000,79.097216>}
box{<0,0,-0.088900><2.008316,0.035000,0.088900> rotate<0,90.000000,0> translate<32.122997,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<32.122997,0.000000,79.097216>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,79.097216>}
box{<0,0,-0.088900><1.004156,0.035000,0.088900> rotate<0,0.000000,0> translate<32.122997,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,79.097216>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,78.762497>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,44.997030,0> translate<33.127153,0.000000,79.097216> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,78.762497>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,78.427775>}
box{<0,0,-0.088900><0.334722,0.035000,0.088900> rotate<0,-90.000000,0> translate<33.461872,0.000000,78.427775> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,78.427775>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,78.093056>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,-44.997030,0> translate<33.127153,0.000000,78.093056> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,78.093056>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,77.758338>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,44.997030,0> translate<33.127153,0.000000,78.093056> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,77.758338>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,77.423619>}
box{<0,0,-0.088900><0.334719,0.035000,0.088900> rotate<0,-90.000000,0> translate<33.461872,0.000000,77.423619> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.461872,0.000000,77.423619>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,77.088900>}
box{<0,0,-0.088900><0.473364,0.035000,0.088900> rotate<0,-44.997030,0> translate<33.127153,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,77.088900>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<32.122997,0.000000,77.088900>}
box{<0,0,-0.088900><1.004156,0.035000,0.088900> rotate<0,0.000000,0> translate<32.122997,0.000000,77.088900> }
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<32.122997,0.000000,78.093056>}
cylinder{<0,0,0><0,0.035000,0>0.088900 translate<33.127153,0.000000,78.093056>}
box{<0,0,-0.088900><1.004156,0.035000,0.088900> rotate<0,0.000000,0> translate<32.122997,0.000000,78.093056> }
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
cylinder{<45.110000,0.038000,70.690000><45.110000,-1.538000,70.690000>0.508000}
cylinder{<47.650000,0.038000,70.690000><47.650000,-1.538000,70.690000>0.508000}
cylinder{<50.190000,0.038000,70.690000><50.190000,-1.538000,70.690000>0.508000}
cylinder{<52.730000,0.038000,70.690000><52.730000,-1.538000,70.690000>0.508000}
cylinder{<55.270000,0.038000,70.690000><55.270000,-1.538000,70.690000>0.508000}
cylinder{<57.810000,0.038000,70.690000><57.810000,-1.538000,70.690000>0.508000}
cylinder{<60.350000,0.038000,70.690000><60.350000,-1.538000,70.690000>0.508000}
cylinder{<62.890000,0.038000,70.690000><62.890000,-1.538000,70.690000>0.508000}
cylinder{<23.397000,0.038000,72.500000><23.397000,-1.538000,72.500000>0.508000}
cylinder{<20.603000,0.038000,72.500000><20.603000,-1.538000,72.500000>0.508000}
cylinder{<23.397000,0.038000,75.500000><23.397000,-1.538000,75.500000>0.508000}
cylinder{<20.603000,0.038000,75.500000><20.603000,-1.538000,75.500000>0.508000}
cylinder{<23.397000,0.038000,69.500000><23.397000,-1.538000,69.500000>0.508000}
cylinder{<20.603000,0.038000,69.500000><20.603000,-1.538000,69.500000>0.508000}
cylinder{<15.103000,0.038000,75.500000><15.103000,-1.538000,75.500000>0.508000}
cylinder{<17.897000,0.038000,75.500000><17.897000,-1.538000,75.500000>0.508000}
cylinder{<58.850000,0.038000,35.260000><58.850000,-1.538000,35.260000>0.749300}
cylinder{<58.850000,0.038000,20.020000><58.850000,-1.538000,20.020000>0.749300}
cylinder{<40.850000,0.038000,34.940000><40.850000,-1.538000,34.940000>0.749300}
cylinder{<40.850000,0.038000,19.700000><40.850000,-1.538000,19.700000>0.749300}
cylinder{<24.350000,0.038000,35.620000><24.350000,-1.538000,35.620000>0.749300}
cylinder{<24.350000,0.038000,20.380000><24.350000,-1.538000,20.380000>0.749300}
cylinder{<8.460000,0.038000,35.260000><8.460000,-1.538000,35.260000>0.749300}
cylinder{<8.460000,0.038000,20.020000><8.460000,-1.538000,20.020000>0.749300}
cylinder{<40.270000,0.038000,77.500000><40.270000,-1.538000,77.500000>0.508000}
cylinder{<37.730000,0.038000,77.500000><37.730000,-1.538000,77.500000>0.508000}
cylinder{<19.810000,0.038000,48.730000><19.810000,-1.538000,48.730000>0.508000}
cylinder{<19.810000,0.038000,51.270000><19.810000,-1.538000,51.270000>0.508000}
cylinder{<23.460000,0.038000,61.380000><23.460000,-1.538000,61.380000>0.508000}
cylinder{<23.460000,0.038000,58.840000><23.460000,-1.538000,58.840000>0.508000}
cylinder{<23.460000,0.038000,63.920000><23.460000,-1.538000,63.920000>0.508000}
cylinder{<60.020000,0.038000,10.590000><60.020000,-1.538000,10.590000>0.508000}
cylinder{<57.480000,0.038000,10.590000><57.480000,-1.538000,10.590000>0.508000}
cylinder{<54.940000,0.038000,10.590000><54.940000,-1.538000,10.590000>0.508000}
cylinder{<52.400000,0.038000,10.590000><52.400000,-1.538000,10.590000>0.508000}
cylinder{<49.860000,0.038000,10.590000><49.860000,-1.538000,10.590000>0.508000}
cylinder{<47.320000,0.038000,10.590000><47.320000,-1.538000,10.590000>0.508000}
cylinder{<44.780000,0.038000,10.590000><44.780000,-1.538000,10.590000>0.508000}
cylinder{<42.240000,0.038000,10.590000><42.240000,-1.538000,10.590000>0.508000}
cylinder{<69.320000,0.038000,62.560000><69.320000,-1.538000,62.560000>0.406400}
cylinder{<66.780000,0.038000,62.560000><66.780000,-1.538000,62.560000>0.406400}
cylinder{<64.240000,0.038000,62.560000><64.240000,-1.538000,62.560000>0.406400}
cylinder{<64.240000,0.038000,54.940000><64.240000,-1.538000,54.940000>0.406400}
cylinder{<66.780000,0.038000,54.940000><66.780000,-1.538000,54.940000>0.406400}
cylinder{<69.320000,0.038000,54.940000><69.320000,-1.538000,54.940000>0.406400}
cylinder{<57.480000,0.038000,62.560000><57.480000,-1.538000,62.560000>0.406400}
cylinder{<54.940000,0.038000,62.560000><54.940000,-1.538000,62.560000>0.406400}
cylinder{<52.400000,0.038000,62.560000><52.400000,-1.538000,62.560000>0.406400}
cylinder{<52.400000,0.038000,54.940000><52.400000,-1.538000,54.940000>0.406400}
cylinder{<54.940000,0.038000,54.940000><54.940000,-1.538000,54.940000>0.406400}
cylinder{<57.480000,0.038000,54.940000><57.480000,-1.538000,54.940000>0.406400}
cylinder{<45.640000,0.038000,62.560000><45.640000,-1.538000,62.560000>0.406400}
cylinder{<43.100000,0.038000,62.560000><43.100000,-1.538000,62.560000>0.406400}
cylinder{<40.560000,0.038000,62.560000><40.560000,-1.538000,62.560000>0.406400}
cylinder{<40.560000,0.038000,54.940000><40.560000,-1.538000,54.940000>0.406400}
cylinder{<43.100000,0.038000,54.940000><43.100000,-1.538000,54.940000>0.406400}
cylinder{<45.640000,0.038000,54.940000><45.640000,-1.538000,54.940000>0.406400}
cylinder{<33.800000,0.038000,62.560000><33.800000,-1.538000,62.560000>0.406400}
cylinder{<31.260000,0.038000,62.560000><31.260000,-1.538000,62.560000>0.406400}
cylinder{<28.720000,0.038000,62.560000><28.720000,-1.538000,62.560000>0.406400}
cylinder{<28.720000,0.038000,54.940000><28.720000,-1.538000,54.940000>0.406400}
cylinder{<31.260000,0.038000,54.940000><31.260000,-1.538000,54.940000>0.406400}
cylinder{<33.800000,0.038000,54.940000><33.800000,-1.538000,54.940000>0.406400}
cylinder{<67.320000,0.038000,37.960000><67.320000,-1.538000,37.960000>0.558800}
cylinder{<69.860000,0.038000,37.960000><69.860000,-1.538000,37.960000>0.558800}
cylinder{<64.780000,0.038000,37.960000><64.780000,-1.538000,37.960000>0.558800}
cylinder{<49.020000,0.038000,37.960000><49.020000,-1.538000,37.960000>0.558800}
cylinder{<51.560000,0.038000,37.960000><51.560000,-1.538000,37.960000>0.558800}
cylinder{<46.480000,0.038000,37.960000><46.480000,-1.538000,37.960000>0.558800}
cylinder{<32.720000,0.038000,37.960000><32.720000,-1.538000,37.960000>0.558800}
cylinder{<35.260000,0.038000,37.960000><35.260000,-1.538000,37.960000>0.558800}
cylinder{<30.180000,0.038000,37.960000><30.180000,-1.538000,37.960000>0.558800}
cylinder{<16.420000,0.038000,37.960000><16.420000,-1.538000,37.960000>0.558800}
cylinder{<18.960000,0.038000,37.960000><18.960000,-1.538000,37.960000>0.558800}
cylinder{<13.880000,0.038000,37.960000><13.880000,-1.538000,37.960000>0.558800}
cylinder{<65.000000,0.038000,41.190000><65.000000,-1.538000,41.190000>0.406400}
cylinder{<65.000000,0.038000,48.810000><65.000000,-1.538000,48.810000>0.406400}
cylinder{<54.000000,0.038000,41.190000><54.000000,-1.538000,41.190000>0.406400}
cylinder{<54.000000,0.038000,48.810000><54.000000,-1.538000,48.810000>0.406400}
cylinder{<32.500000,0.038000,41.190000><32.500000,-1.538000,41.190000>0.406400}
cylinder{<32.500000,0.038000,48.810000><32.500000,-1.538000,48.810000>0.406400}
cylinder{<24.000000,0.038000,40.690000><24.000000,-1.538000,40.690000>0.406400}
cylinder{<24.000000,0.038000,48.310000><24.000000,-1.538000,48.310000>0.406400}
cylinder{<49.690000,0.038000,51.500000><49.690000,-1.538000,51.500000>0.406400}
cylinder{<57.310000,0.038000,51.500000><57.310000,-1.538000,51.500000>0.406400}
cylinder{<38.190000,0.038000,51.500000><38.190000,-1.538000,51.500000>0.406400}
cylinder{<45.810000,0.038000,51.500000><45.810000,-1.538000,51.500000>0.406400}
cylinder{<61.690000,0.038000,51.500000><61.690000,-1.538000,51.500000>0.406400}
cylinder{<69.310000,0.038000,51.500000><69.310000,-1.538000,51.500000>0.406400}
cylinder{<26.190000,0.038000,51.500000><26.190000,-1.538000,51.500000>0.406400}
cylinder{<33.810000,0.038000,51.500000><33.810000,-1.538000,51.500000>0.406400}
cylinder{<35.660000,0.038000,69.730000><35.660000,-1.538000,69.730000>0.508000}
cylinder{<33.120000,0.038000,69.730000><33.120000,-1.538000,69.730000>0.508000}
cylinder{<30.580000,0.038000,69.730000><30.580000,-1.538000,69.730000>0.508000}
cylinder{<28.040000,0.038000,69.730000><28.040000,-1.538000,69.730000>0.508000}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//+11,1V__BATERIA silk screen
difference{
cylinder{<28.660000,0,9.540000><28.660000,0.036000,9.540000>1.079500 translate<0,0.000000,0>}
cylinder{<28.660000,-0.1,9.540000><28.660000,0.135000,9.540000>0.952500 translate<0,0.000000,0>}}
//ARDUINO silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.840000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.380000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.840000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.380000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.380000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.380000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.380000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.840000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.840000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.840000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.840000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.840000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<45.110000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<45.110000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<45.110000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.380000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.920000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.380000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.920000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.920000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.920000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.920000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.380000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.380000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<47.650000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<47.650000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<47.650000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.920000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.460000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.920000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.460000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.460000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.460000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.460000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.920000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.920000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<50.190000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<50.190000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<50.190000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.460000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.000000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.460000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.000000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.000000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.000000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.000000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.460000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.460000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<52.730000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<52.730000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<52.730000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.000000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.540000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.000000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.540000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.540000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.540000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.540000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.000000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.000000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<55.270000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<55.270000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<55.270000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.540000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.080000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.540000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.080000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.080000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.080000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.080000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.540000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.540000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<57.810000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<57.810000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<57.810000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.080000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.620000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.080000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.620000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.620000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.620000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.620000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.080000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.080000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<60.350000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<60.350000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<60.350000,0.000000,75.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.620000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.160000,0.000000,72.595000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.620000,0.000000,72.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.160000,0.000000,72.595000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.160000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.160000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.160000,0.000000,75.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.620000,0.000000,75.135000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.620000,0.000000,75.135000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.890000,0.000000,81.485000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.890000,0.000000,75.770000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,-90.000000,0> translate<62.890000,0.000000,75.770000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<45.110000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<47.650000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<50.190000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<52.730000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<55.270000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<57.810000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<60.350000,0.000000,75.389000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-0.000000,0> translate<62.890000,0.000000,75.389000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<45.110000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<47.650000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<50.190000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<52.730000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<55.270000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<57.810000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<60.350000,0.000000,72.087000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-0.000000,0> translate<62.890000,0.000000,72.087000>}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.000000,0.000000,71.865000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.000000,0.000000,73.135000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<22.000000,0.000000,73.135000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,71.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,71.230000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<19.333000,0.000000,71.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,71.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,73.770000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<19.333000,0.000000,73.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,73.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,73.770000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<19.333000,0.000000,73.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,73.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,71.230000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,-90.000000,0> translate<24.667000,0.000000,71.230000> }
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.000000,0.000000,74.865000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.000000,0.000000,76.135000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<22.000000,0.000000,76.135000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,74.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,74.230000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<19.333000,0.000000,74.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,74.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,76.770000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<19.333000,0.000000,76.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,76.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,76.770000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<19.333000,0.000000,76.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,76.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,74.230000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,-90.000000,0> translate<24.667000,0.000000,74.230000> }
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.000000,0.000000,68.865000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.000000,0.000000,70.135000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<22.000000,0.000000,70.135000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,68.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,68.230000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<19.333000,0.000000,68.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,68.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,70.770000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<19.333000,0.000000,70.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.333000,0.000000,70.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,70.770000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<19.333000,0.000000,70.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,70.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.667000,0.000000,68.230000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,-90.000000,0> translate<24.667000,0.000000,68.230000> }
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<16.500000,0.000000,76.135000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<16.500000,0.000000,74.865000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<16.500000,0.000000,74.865000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.833000,0.000000,76.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.167000,0.000000,76.770000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.833000,0.000000,76.770000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.167000,0.000000,76.770000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.167000,0.000000,74.230000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,-90.000000,0> translate<19.167000,0.000000,74.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<19.167000,0.000000,74.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.833000,0.000000,74.230000>}
box{<0,0,-0.127000><5.334000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.833000,0.000000,74.230000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.833000,0.000000,74.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.833000,0.000000,76.770000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<13.833000,0.000000,76.770000> }
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,26.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,27.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.850000,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.265800,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,27.640000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<58.265800,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.265800,0.000000,28.783000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<58.265800,0.000000,28.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.265800,0.000000,28.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.434200,0.000000,28.783000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<58.265800,0.000000,28.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.434200,0.000000,28.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,27.640000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<58.850000,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,29.926000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.850000,0.000000,29.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.850000,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.434200,0.000000,27.640000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<58.850000,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.644000,0.000000,22.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.056000,0.000000,22.560000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.056000,0.000000,22.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.056000,0.000000,32.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.644000,0.000000,32.720000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.056000,0.000000,32.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.056000,0.000000,22.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.056000,0.000000,32.720000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.056000,0.000000,32.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.644000,0.000000,32.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.644000,0.000000,22.560000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.644000,0.000000,22.560000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<58.850000,0.000000,35.260000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<58.850000,0.000000,33.863000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<58.850000,0.000000,33.863000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<58.850000,0.000000,20.020000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<58.850000,0.000000,21.417000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<58.850000,0.000000,21.417000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<58.850000,0.000000,23.830000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<58.850000,0.000000,22.115500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<58.850000,0.000000,33.164500>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,26.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,27.320000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.850000,0.000000,27.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.265800,0.000000,27.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,27.320000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<40.265800,0.000000,27.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,27.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.265800,0.000000,28.463000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<40.265800,0.000000,28.463000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.265800,0.000000,28.463000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.434200,0.000000,28.463000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<40.265800,0.000000,28.463000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.434200,0.000000,28.463000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,27.320000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<40.850000,0.000000,27.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,27.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,29.606000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.850000,0.000000,29.606000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.850000,0.000000,27.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.434200,0.000000,27.320000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<40.850000,0.000000,27.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.644000,0.000000,22.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.056000,0.000000,22.240000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.056000,0.000000,22.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.056000,0.000000,32.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.644000,0.000000,32.400000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.056000,0.000000,32.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.056000,0.000000,22.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.056000,0.000000,32.400000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.056000,0.000000,32.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.644000,0.000000,32.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.644000,0.000000,22.240000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.644000,0.000000,22.240000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<40.850000,0.000000,34.940000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<40.850000,0.000000,33.543000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<40.850000,0.000000,33.543000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<40.850000,0.000000,19.700000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<40.850000,0.000000,21.097000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<40.850000,0.000000,21.097000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<40.850000,0.000000,23.510000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<40.850000,0.000000,21.795500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<40.850000,0.000000,32.844500>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,26.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,28.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.350000,0.000000,28.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.765800,0.000000,28.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,28.000000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<23.765800,0.000000,28.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,28.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.765800,0.000000,29.143000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<23.765800,0.000000,29.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.765800,0.000000,29.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.934200,0.000000,29.143000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<23.765800,0.000000,29.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.934200,0.000000,29.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,28.000000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<24.350000,0.000000,28.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,28.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,30.286000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.350000,0.000000,30.286000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350000,0.000000,28.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.934200,0.000000,28.000000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<24.350000,0.000000,28.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.144000,0.000000,22.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.556000,0.000000,22.920000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.556000,0.000000,22.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.556000,0.000000,33.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.144000,0.000000,33.080000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.556000,0.000000,33.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.556000,0.000000,22.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.556000,0.000000,33.080000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.556000,0.000000,33.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.144000,0.000000,33.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.144000,0.000000,22.920000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.144000,0.000000,22.920000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<24.350000,0.000000,35.620000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<24.350000,0.000000,34.223000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<24.350000,0.000000,34.223000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<24.350000,0.000000,20.380000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<24.350000,0.000000,21.777000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<24.350000,0.000000,21.777000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<24.350000,0.000000,24.190000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<24.350000,0.000000,22.475500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<24.350000,0.000000,33.524500>}
//D4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,26.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,27.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.460000,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.875800,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,27.640000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<7.875800,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.875800,0.000000,28.783000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,62.923767,0> translate<7.875800,0.000000,28.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.875800,0.000000,28.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.044200,0.000000,28.783000>}
box{<0,0,-0.076200><1.168400,0.036000,0.076200> rotate<0,0.000000,0> translate<7.875800,0.000000,28.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.044200,0.000000,28.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,27.640000>}
box{<0,0,-0.076200><1.283643,0.036000,0.076200> rotate<0,-62.923767,0> translate<8.460000,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,29.926000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.460000,0.000000,29.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.460000,0.000000,27.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.044200,0.000000,27.640000>}
box{<0,0,-0.076200><0.584200,0.036000,0.076200> rotate<0,0.000000,0> translate<8.460000,0.000000,27.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.254000,0.000000,22.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.666000,0.000000,22.560000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.666000,0.000000,22.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.666000,0.000000,32.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.254000,0.000000,32.720000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.666000,0.000000,32.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.666000,0.000000,22.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.666000,0.000000,32.720000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.666000,0.000000,32.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.254000,0.000000,32.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.254000,0.000000,22.560000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.254000,0.000000,22.560000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<8.460000,0.000000,35.260000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<8.460000,0.000000,33.863000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,-90.000000,0> translate<8.460000,0.000000,33.863000> }
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<8.460000,0.000000,20.020000>}
cylinder{<0,0,0><0,0.036000,0>0.635000 translate<8.460000,0.000000,21.417000>}
box{<0,0,-0.635000><1.397000,0.036000,0.635000> rotate<0,90.000000,0> translate<8.460000,0.000000,21.417000> }
box{<-0.381000,0,-2.794000><0.381000,0.036000,2.794000> rotate<0,-90.000000,0> translate<8.460000,0.000000,23.830000>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<8.460000,0.000000,22.115500>}
box{<-0.444500,0,-0.635000><0.444500,0.036000,0.635000> rotate<0,-90.000000,0> translate<8.460000,0.000000,33.164500>}
//GND__BATERIA silk screen
difference{
cylinder{<18.040000,0,9.540000><18.040000,0.036000,9.540000>1.079500 translate<0,0.000000,0>}
cylinder{<18.040000,-0.1,9.540000><18.040000,0.135000,9.540000>0.952500 translate<0,0.000000,0>}}
//H1 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<6.500000,0.000000,6.500000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<6.500000,0.000000,6.500000>}
difference{
cylinder{<6.500000,0,6.500000><6.500000,0.036000,6.500000>3.505200 translate<0,0.000000,0>}
cylinder{<6.500000,-0.1,6.500000><6.500000,0.135000,6.500000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<6.500000,0,6.500000><6.500000,0.036000,6.500000>0.990600 translate<0,0.000000,0>}
cylinder{<6.500000,-0.1,6.500000><6.500000,0.135000,6.500000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<6.500000,0,6.500000><6.500000,0.036000,6.500000>1.801600 translate<0,0.000000,0>}
cylinder{<6.500000,-0.1,6.500000><6.500000,0.135000,6.500000>1.598400 translate<0,0.000000,0>}}
//H2 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<6.500000,0.000000,80.000000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<6.500000,0.000000,80.000000>}
difference{
cylinder{<6.500000,0,80.000000><6.500000,0.036000,80.000000>3.505200 translate<0,0.000000,0>}
cylinder{<6.500000,-0.1,80.000000><6.500000,0.135000,80.000000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<6.500000,0,80.000000><6.500000,0.036000,80.000000>0.990600 translate<0,0.000000,0>}
cylinder{<6.500000,-0.1,80.000000><6.500000,0.135000,80.000000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<6.500000,0,80.000000><6.500000,0.036000,80.000000>1.801600 translate<0,0.000000,0>}
cylinder{<6.500000,-0.1,80.000000><6.500000,0.135000,80.000000>1.598400 translate<0,0.000000,0>}}
//H3 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<69.000000,0.000000,6.500000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<69.000000,0.000000,6.500000>}
difference{
cylinder{<69.000000,0,6.500000><69.000000,0.036000,6.500000>3.505200 translate<0,0.000000,0>}
cylinder{<69.000000,-0.1,6.500000><69.000000,0.135000,6.500000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<69.000000,0,6.500000><69.000000,0.036000,6.500000>0.990600 translate<0,0.000000,0>}
cylinder{<69.000000,-0.1,6.500000><69.000000,0.135000,6.500000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<69.000000,0,6.500000><69.000000,0.036000,6.500000>1.801600 translate<0,0.000000,0>}
cylinder{<69.000000,-0.1,6.500000><69.000000,0.135000,6.500000>1.598400 translate<0,0.000000,0>}}
//H4 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<69.000000,0.000000,80.000000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<69.000000,0.000000,80.000000>}
difference{
cylinder{<69.000000,0,80.000000><69.000000,0.036000,80.000000>3.505200 translate<0,0.000000,0>}
cylinder{<69.000000,-0.1,80.000000><69.000000,0.135000,80.000000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<69.000000,0,80.000000><69.000000,0.036000,80.000000>0.990600 translate<0,0.000000,0>}
cylinder{<69.000000,-0.1,80.000000><69.000000,0.135000,80.000000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<69.000000,0,80.000000><69.000000,0.036000,80.000000>1.801600 translate<0,0.000000,0>}
cylinder{<69.000000,-0.1,80.000000><69.000000,0.135000,80.000000>1.598400 translate<0,0.000000,0>}}
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.905000,0.000000,76.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.635000,0.000000,76.230000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.635000,0.000000,76.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.635000,0.000000,76.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.000000,0.000000,76.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<39.000000,0.000000,76.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.000000,0.000000,76.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.000000,0.000000,78.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.000000,0.000000,78.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.000000,0.000000,78.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.635000,0.000000,78.770000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.000000,0.000000,78.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.540000,0.000000,76.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.540000,0.000000,78.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.540000,0.000000,78.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.905000,0.000000,76.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.540000,0.000000,76.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.905000,0.000000,76.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.540000,0.000000,78.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.905000,0.000000,78.770000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.905000,0.000000,78.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.635000,0.000000,78.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.905000,0.000000,78.770000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.635000,0.000000,78.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.000000,0.000000,76.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.365000,0.000000,76.230000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.365000,0.000000,76.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.365000,0.000000,76.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.095000,0.000000,76.230000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.095000,0.000000,76.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.095000,0.000000,76.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.460000,0.000000,76.865000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<36.460000,0.000000,76.865000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.460000,0.000000,76.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.460000,0.000000,78.135000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.460000,0.000000,78.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.460000,0.000000,78.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.095000,0.000000,78.770000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.460000,0.000000,78.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.095000,0.000000,78.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.365000,0.000000,78.770000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.095000,0.000000,78.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.365000,0.000000,78.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.000000,0.000000,78.135000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<38.365000,0.000000,78.770000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<40.270000,0.000000,77.500000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<37.730000,0.000000,77.500000>}
//JP2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,47.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,50.000000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.905000,0.000000,50.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,50.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,50.000000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.365000,0.000000,50.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,50.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,47.460000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.365000,0.000000,47.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,47.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,47.460000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.365000,0.000000,47.460000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<9.015000,0.000000,48.730000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<14.730000,0.000000,48.730000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,0.000000,0> translate<9.015000,0.000000,48.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,50.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,52.540000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.905000,0.000000,52.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.905000,0.000000,52.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,52.540000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.365000,0.000000,52.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,52.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.365000,0.000000,50.000000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.365000,0.000000,50.000000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<9.015000,0.000000,51.270000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<14.730000,0.000000,51.270000>}
box{<0,0,-0.381000><5.715000,0.036000,0.381000> rotate<0,0.000000,0> translate<9.015000,0.000000,51.270000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<15.111000,0.000000,48.730000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<15.111000,0.000000,51.270000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-90.000000,0> translate<18.413000,0.000000,48.730000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-90.000000,0> translate<18.413000,0.000000,51.270000>}
//LM7809 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,56.173000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,66.587000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.920000,0.000000,66.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,66.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,56.173000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.045000,0.000000,56.173000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,66.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,66.587000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.474000,0.000000,66.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,66.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,65.698000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.474000,0.000000,65.698000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,65.698000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,65.698000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.950000,0.000000,65.698000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,65.698000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,66.587000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.950000,0.000000,66.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,66.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,66.587000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.045000,0.000000,66.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.920000,0.000000,56.173000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,56.173000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.474000,0.000000,56.173000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,56.173000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,57.062000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.474000,0.000000,57.062000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.474000,0.000000,57.062000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,57.062000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.950000,0.000000,57.062000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,57.062000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,56.173000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.950000,0.000000,56.173000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.950000,0.000000,56.173000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.045000,0.000000,56.173000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.045000,0.000000,56.173000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,56.808000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,65.952000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,90.000000,0> translate<20.285000,0.000000,65.952000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,65.952000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,65.952000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<12.030000,0.000000,65.952000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,65.952000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,56.808000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,-90.000000,0> translate<12.030000,0.000000,56.808000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.285000,0.000000,56.808000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<12.030000,0.000000,56.808000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<12.030000,0.000000,56.808000> }
difference{
cylinder{<8.474000,0,61.380000><8.474000,0.036000,61.380000>1.879600 translate<0,0.000000,0>}
cylinder{<8.474000,-0.1,61.380000><8.474000,0.135000,61.380000>1.727200 translate<0,0.000000,0>}}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<21.364500,0.000000,63.920000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<22.634500,0.000000,63.920000>}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<21.364500,0.000000,61.380000>}
box{<-0.635000,0,-0.444500><0.635000,0.036000,0.444500> rotate<0,-90.000000,0> translate<21.364500,0.000000,58.840000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<22.634500,0.000000,61.380000>}
box{<-0.635000,0,-0.825500><0.635000,0.036000,0.825500> rotate<0,-90.000000,0> translate<22.634500,0.000000,58.840000>}
//MOTORES silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.290000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.750000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.750000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.290000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.750000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.290000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.290000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.290000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.210000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.210000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.210000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.210000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.210000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.210000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.210000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.210000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.670000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.670000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.670000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.670000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.670000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.670000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.210000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.670000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.670000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.130000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<51.130000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.670000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.130000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.590000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.590000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.590000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.050000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.050000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.050000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.050000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.050000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.050000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.050000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.050000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.510000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.510000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.510000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.510000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.510000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.510000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.050000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.510000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.510000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.970000,0.000000,8.685000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.970000,0.000000,8.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.970000,0.000000,8.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.970000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.970000,0.000000,6.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.970000,0.000000,6.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.510000,0.000000,6.145000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.970000,0.000000,6.145000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<60.020000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<57.480000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<54.940000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<52.400000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<49.860000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<47.320000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<44.780000,0.000000,5.891000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<42.240000,0.000000,5.891000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<60.020000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<57.480000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<54.940000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<52.400000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<49.860000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<47.320000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<44.780000,0.000000,9.193000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<42.240000,0.000000,9.193000>}
//OK1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.970000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.590000,0.000000,55.829000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.970000,0.000000,55.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.590000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.970000,0.000000,61.671000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.970000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.970000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.970000,0.000000,61.671000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.970000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.590000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.590000,0.000000,57.734000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.590000,0.000000,57.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.590000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.590000,0.000000,59.766000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.590000,0.000000,59.766000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<70.590000,0.000000,58.750000>}
//OK2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,55.829000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.130000,0.000000,55.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,61.671000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.130000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.130000,0.000000,61.671000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.130000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,57.734000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.750000,0.000000,57.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.750000,0.000000,59.766000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.750000,0.000000,59.766000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<58.750000,0.000000,58.750000>}
//OK3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.290000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.910000,0.000000,55.829000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.290000,0.000000,55.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.910000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.290000,0.000000,61.671000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.290000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.290000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.290000,0.000000,61.671000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.290000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.910000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.910000,0.000000,57.734000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.910000,0.000000,57.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.910000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.910000,0.000000,59.766000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.910000,0.000000,59.766000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<46.910000,0.000000,58.750000>}
//OK4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,55.829000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.450000,0.000000,55.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,61.671000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.450000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.450000,0.000000,61.671000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.450000,0.000000,61.671000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,55.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,57.734000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.070000,0.000000,57.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,61.671000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.070000,0.000000,59.766000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.070000,0.000000,59.766000> }
object{ARC(1.016000,0.152400,90.000000,270.000000,0.036000) translate<35.070000,0.000000,58.750000>}
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,32.880000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.113000,0.000000,32.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,17.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,17.005000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.113000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.113000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.002000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.113000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.002000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.002000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.002000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.002000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.113000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.113000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.113000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.527000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.638000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.638000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.638000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.638000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.638000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.638000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.638000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.527000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.527000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.892000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.748000,0.000000,32.245000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<62.748000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.748000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.748000,0.000000,32.245000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<62.748000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.748000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.892000,0.000000,23.990000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<62.748000,0.000000,23.990000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.892000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.892000,0.000000,23.990000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<71.892000,0.000000,23.990000> }
difference{
cylinder{<67.320000,0,20.434000><67.320000,0.036000,20.434000>1.879600 translate<0,0.000000,0>}
cylinder{<67.320000,-0.1,20.434000><67.320000,0.135000,20.434000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<64.780000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<67.320000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<69.860000,0.000000,35.991500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<69.860000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<67.320000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<64.780000,0.000000,34.277000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<69.860000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<67.320000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<64.780000,0.000000,37.261500>}
//Q2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,32.880000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.813000,0.000000,32.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,17.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,17.005000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.813000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.813000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.702000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.813000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.702000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.702000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.702000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.702000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.813000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.813000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.813000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.227000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.338000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.338000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.338000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.338000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.338000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.338000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.338000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.227000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.227000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<53.592000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.448000,0.000000,32.245000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<44.448000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.448000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.448000,0.000000,32.245000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<44.448000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.448000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<53.592000,0.000000,23.990000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<44.448000,0.000000,23.990000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<53.592000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<53.592000,0.000000,23.990000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<53.592000,0.000000,23.990000> }
difference{
cylinder{<49.020000,0,20.434000><49.020000,0.036000,20.434000>1.879600 translate<0,0.000000,0>}
cylinder{<49.020000,-0.1,20.434000><49.020000,0.135000,20.434000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<46.480000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<49.020000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<51.560000,0.000000,35.991500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<51.560000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<49.020000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<46.480000,0.000000,34.277000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<51.560000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<49.020000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<46.480000,0.000000,37.261500>}
//Q3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,32.880000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.513000,0.000000,32.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,17.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,17.005000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.513000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.513000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.402000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.513000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.402000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.402000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.402000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.402000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.513000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.513000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.513000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.927000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.038000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.038000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.038000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.038000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.038000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.038000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.038000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.927000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.927000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.292000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<28.148000,0.000000,32.245000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<28.148000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<28.148000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<28.148000,0.000000,32.245000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<28.148000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<28.148000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.292000,0.000000,23.990000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<28.148000,0.000000,23.990000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.292000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.292000,0.000000,23.990000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<37.292000,0.000000,23.990000> }
difference{
cylinder{<32.720000,0,20.434000><32.720000,0.036000,20.434000>1.879600 translate<0,0.000000,0>}
cylinder{<32.720000,-0.1,20.434000><32.720000,0.135000,20.434000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<30.180000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<32.720000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<35.260000,0.000000,35.991500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<35.260000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<32.720000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<30.180000,0.000000,34.277000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<35.260000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<32.720000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<30.180000,0.000000,37.261500>}
//Q4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,32.880000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,32.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,17.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,17.005000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.213000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.102000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.102000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.213000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.213000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.213000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,32.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,20.434000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.627000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,20.434000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.738000,0.000000,20.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,20.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,18.910000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.738000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.738000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,18.910000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.738000,0.000000,18.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,18.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.627000,0.000000,17.005000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.627000,0.000000,17.005000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,32.245000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<11.848000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,32.245000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,90.000000,0> translate<11.848000,0.000000,32.245000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<11.848000,0.000000,23.990000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,23.990000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,0.000000,0> translate<11.848000,0.000000,23.990000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,32.245000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<20.992000,0.000000,23.990000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,-90.000000,0> translate<20.992000,0.000000,23.990000> }
difference{
cylinder{<16.420000,0,20.434000><16.420000,0.036000,20.434000>1.879600 translate<0,0.000000,0>}
cylinder{<16.420000,-0.1,20.434000><16.420000,0.135000,20.434000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<13.880000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<16.420000,0.000000,35.991500>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-180.000000,0> translate<18.960000,0.000000,35.991500>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<18.960000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<16.420000,0.000000,34.277000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-180.000000,0> translate<13.880000,0.000000,34.277000>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<18.960000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<16.420000,0.000000,37.261500>}
box{<-0.381000,0,-0.952500><0.381000,0.036000,0.952500> rotate<0,-180.000000,0> translate<13.880000,0.000000,37.261500>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.000000,0.000000,41.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.000000,0.000000,41.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<65.000000,0.000000,41.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<64.111000,0.000000,42.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<65.889000,0.000000,42.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<65.889000,0.000000,47.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<64.111000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.889000,0.000000,41.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.111000,0.000000,41.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.111000,0.000000,41.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.857000,0.000000,42.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.857000,0.000000,42.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.857000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.984000,0.000000,42.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.857000,0.000000,42.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<63.857000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.143000,0.000000,42.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.143000,0.000000,42.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.143000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.016000,0.000000,42.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.143000,0.000000,42.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<66.016000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.984000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.857000,0.000000,47.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<63.857000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.984000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.984000,0.000000,42.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.984000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.016000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.143000,0.000000,47.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<66.016000,0.000000,47.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.016000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.016000,0.000000,42.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.016000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.857000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.857000,0.000000,47.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.857000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.143000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.143000,0.000000,47.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.143000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.889000,0.000000,48.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.111000,0.000000,48.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.111000,0.000000,48.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.000000,0.000000,48.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<65.000000,0.000000,48.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<65.000000,0.000000,48.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<65.000000,0.000000,41.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<65.000000,0.000000,48.302000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.000000,0.000000,41.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.000000,0.000000,41.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<54.000000,0.000000,41.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.111000,0.000000,42.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<54.889000,0.000000,42.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<54.889000,0.000000,47.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.111000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.889000,0.000000,41.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.111000,0.000000,41.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.111000,0.000000,41.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.857000,0.000000,42.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.857000,0.000000,42.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.857000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.984000,0.000000,42.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.857000,0.000000,42.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.857000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.143000,0.000000,42.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.143000,0.000000,42.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.143000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.016000,0.000000,42.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.143000,0.000000,42.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<55.016000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.984000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.857000,0.000000,47.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<52.857000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.984000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.984000,0.000000,42.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.984000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.016000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.143000,0.000000,47.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<55.016000,0.000000,47.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.016000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.016000,0.000000,42.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.016000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.857000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.857000,0.000000,47.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.857000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.143000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.143000,0.000000,47.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.143000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.889000,0.000000,48.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.111000,0.000000,48.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.111000,0.000000,48.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.000000,0.000000,48.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.000000,0.000000,48.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<54.000000,0.000000,48.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<54.000000,0.000000,41.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<54.000000,0.000000,48.302000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.500000,0.000000,41.190000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.500000,0.000000,41.571000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.500000,0.000000,41.571000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<31.611000,0.000000,42.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<33.389000,0.000000,42.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<33.389000,0.000000,47.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<31.611000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.389000,0.000000,41.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.611000,0.000000,41.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.611000,0.000000,41.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.357000,0.000000,42.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.357000,0.000000,42.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.357000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.484000,0.000000,42.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.357000,0.000000,42.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.357000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.643000,0.000000,42.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.643000,0.000000,42.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.643000,0.000000,42.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.516000,0.000000,42.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.643000,0.000000,42.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<33.516000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.484000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.357000,0.000000,47.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<31.357000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.484000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.484000,0.000000,42.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.484000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.516000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.643000,0.000000,47.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.516000,0.000000,47.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.516000,0.000000,47.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.516000,0.000000,42.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.516000,0.000000,42.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.357000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.357000,0.000000,47.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.357000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.643000,0.000000,47.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.643000,0.000000,47.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.643000,0.000000,47.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.389000,0.000000,48.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.611000,0.000000,48.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.611000,0.000000,48.175000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.500000,0.000000,48.429000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.500000,0.000000,48.810000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.500000,0.000000,48.810000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.500000,0.000000,41.698000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.500000,0.000000,48.302000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,40.690000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,41.071000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<24.000000,0.000000,41.071000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<23.111000,0.000000,41.579000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<24.889000,0.000000,41.579000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<24.889000,0.000000,47.421000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<23.111000,0.000000,47.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.889000,0.000000,41.325000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.111000,0.000000,41.325000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.111000,0.000000,41.325000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,41.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,41.960000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.857000,0.000000,41.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,42.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,41.960000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.857000,0.000000,41.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,41.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,41.960000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.143000,0.000000,41.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,42.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,41.960000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.016000,0.000000,42.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,46.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,47.040000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.857000,0.000000,47.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,46.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,42.087000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.984000,0.000000,42.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,46.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,47.040000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.016000,0.000000,46.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,46.913000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,42.087000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.016000,0.000000,42.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,47.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,47.040000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.857000,0.000000,47.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,47.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,47.040000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.143000,0.000000,47.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.889000,0.000000,47.675000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.111000,0.000000,47.675000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.111000,0.000000,47.675000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,47.929000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,48.310000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<24.000000,0.000000,48.310000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.000000,0.000000,41.198000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.000000,0.000000,47.802000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.690000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<50.071000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<49.690000,0.000000,51.500000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<50.579000,0.000000,52.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<50.579000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<56.421000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<56.421000,0.000000,52.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.325000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.325000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.325000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.579000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.960000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.579000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.087000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.960000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.960000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.579000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.960000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.579000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.087000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.960000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.960000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.913000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.040000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<55.913000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.913000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.087000,0.000000,52.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.087000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.913000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.040000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<55.913000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.913000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.087000,0.000000,50.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.087000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.421000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.040000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.040000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.421000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.040000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.040000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.675000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.675000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.675000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<56.929000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<57.310000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<56.929000,0.000000,51.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<50.198000,0.000000,51.500000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<56.802000,0.000000,51.500000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.190000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.571000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<38.190000,0.000000,51.500000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<39.079000,0.000000,52.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<39.079000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<44.921000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<44.921000,0.000000,52.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.825000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.825000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.825000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.079000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.460000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.079000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.587000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.460000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<39.460000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.079000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.460000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.079000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.587000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.460000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.460000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.413000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.540000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.413000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.413000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.587000,0.000000,52.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.587000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.413000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.540000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<44.413000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.413000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.587000,0.000000,50.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.587000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.921000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.540000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.540000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.921000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.540000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.540000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.175000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.175000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.175000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.429000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.810000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<45.429000,0.000000,51.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<38.698000,0.000000,51.500000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<45.302000,0.000000,51.500000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.690000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<62.071000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<61.690000,0.000000,51.500000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<62.579000,0.000000,52.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<62.579000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<68.421000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<68.421000,0.000000,52.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.325000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.325000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.325000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.579000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.960000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.579000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.087000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.960000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<62.960000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.579000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.960000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.579000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.087000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.960000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.960000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.913000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.040000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.913000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.913000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.087000,0.000000,52.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.087000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.913000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.040000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<67.913000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.913000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.087000,0.000000,50.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.087000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.421000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.040000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.040000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.421000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.040000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.040000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.675000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.675000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.675000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<68.929000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<69.310000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<68.929000,0.000000,51.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<62.198000,0.000000,51.500000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<68.802000,0.000000,51.500000>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.190000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.571000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<26.190000,0.000000,51.500000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<27.079000,0.000000,52.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<27.079000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<32.921000,0.000000,50.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<32.921000,0.000000,52.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.825000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.825000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.825000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.079000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.460000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.079000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.587000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.460000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<27.460000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.079000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.460000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.079000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.587000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.460000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.460000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.413000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.540000,0.000000,52.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.413000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.413000,0.000000,52.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.587000,0.000000,52.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.587000,0.000000,52.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.413000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.540000,0.000000,50.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<32.413000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.413000,0.000000,50.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.587000,0.000000,50.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.587000,0.000000,50.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.921000,0.000000,52.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.540000,0.000000,52.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.540000,0.000000,52.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.921000,0.000000,50.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.540000,0.000000,50.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.540000,0.000000,50.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.175000,0.000000,50.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.175000,0.000000,52.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.175000,0.000000,52.389000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.429000,0.000000,51.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.810000,0.000000,51.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<33.429000,0.000000,51.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<26.698000,0.000000,51.500000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<33.302000,0.000000,51.500000>}
//XBEE silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.850000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.215000,0.000000,68.460000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.215000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.215000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.945000,0.000000,68.460000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.945000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.945000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.310000,0.000000,69.095000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.310000,0.000000,69.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.310000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.310000,0.000000,70.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<29.310000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.310000,0.000000,70.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.945000,0.000000,71.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.310000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.945000,0.000000,71.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.215000,0.000000,71.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.945000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.215000,0.000000,71.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.850000,0.000000,70.365000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.215000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.295000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.025000,0.000000,68.460000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.025000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.025000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.390000,0.000000,69.095000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<34.390000,0.000000,69.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.390000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.390000,0.000000,70.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.390000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.390000,0.000000,70.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.025000,0.000000,71.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.390000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.390000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.755000,0.000000,68.460000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.755000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.755000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.485000,0.000000,68.460000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.485000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.485000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.850000,0.000000,69.095000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.850000,0.000000,69.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.850000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.850000,0.000000,70.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.850000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.850000,0.000000,70.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.485000,0.000000,71.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.850000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.485000,0.000000,71.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.755000,0.000000,71.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.485000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.755000,0.000000,71.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.390000,0.000000,70.365000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.755000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.930000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.930000,0.000000,70.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.930000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.295000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.930000,0.000000,69.095000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.295000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.930000,0.000000,70.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.295000,0.000000,71.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<36.295000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.025000,0.000000,71.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.295000,0.000000,71.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.025000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.675000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.405000,0.000000,68.460000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.405000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.405000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.770000,0.000000,69.095000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<26.770000,0.000000,69.095000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.770000,0.000000,69.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.770000,0.000000,70.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.770000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.770000,0.000000,70.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.405000,0.000000,71.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.770000,0.000000,70.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.675000,0.000000,68.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.310000,0.000000,69.095000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<28.675000,0.000000,68.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.310000,0.000000,70.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.675000,0.000000,71.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<28.675000,0.000000,71.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.405000,0.000000,71.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.675000,0.000000,71.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.405000,0.000000,71.000000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<30.580000,0.000000,69.730000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<33.120000,0.000000,69.730000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<35.660000,0.000000,69.730000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<28.040000,0.000000,69.730000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  PROTOTIPO_2X_DOBLECAPA(-37.750000,0,-43.250000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//+11,1V__BATERIA	M01-SMTSO-256-ET	SMTSO-256-ET
//C1	0.1uF	CAP-PTH-SMALL-KIT
//C2	0.1uF	CAP-PTH-SMALL-KIT
//C3	0.1uF	CAP-PTH-SMALL-KIT
//C4		CAP-PTH-SMALL-KIT
//GND__BATERIA	M01-SMTSO-256-ET	SMTSO-256-ET
//H1	MOUNT-HOLE3.2	3,2
//H2	MOUNT-HOLE3.2	3,2
//H3	MOUNT-HOLE3.2	3,2
//H4	MOUNT-HOLE3.2	3,2
