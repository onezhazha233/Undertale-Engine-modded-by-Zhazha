var SW,SH,SX,SY,SF;

if(instance_exists(border)){
	if(border._enabled){
		SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
		SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
		SX=SW/960;
		SY=SH/540;
		SF=min(SX,SY);
	}else{
		SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
		SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
		SX=SW/640;
		SY=SH/480;
		SF=min(SX,SY);
	}
}

if(surface_exists(_surface_ui)){
	draw_surface_ext(_surface_ui,0,0,1,1,0,c_white,1);
}

if(!hold_enabled||!instance_exists(_inst)){
	exit;
}
if(_hold_progress<=0&&!_hold_latched&&_hold_alpha<=0){
	exit;
}
if(!surface_exists(_surface_ui)){
	exit;
}

// Larger than 14 so outline circle (r=8) is not clipped on the sides.
if(!surface_exists(_hold_ring_surface)){
	_hold_ring_surface=surface_create(18,18);
}

var _ang=360*_hold_progress;
var _cc=8;
var _sc=9;

surface_set_target(_hold_ring_surface);
draw_clear_alpha(c_black,0);

draw_set_color(c_black);
draw_circle(_cc,_cc,8,true);
draw_hold_sector(_sc,_sc,6,0,_ang);

draw_set_color(c_white);
draw_circle(_cc,_cc,7,true);
draw_hold_sector(_sc,_sc,5,0,_ang);
surface_reset_target();

var _sw=18*2;
var _edge=Prompt_GetTextEdgeX(_inst,_pos);
var _cx=Prompt_IsRightPos(_pos) ? _edge-hold_ring_gap-_sw : _edge+hold_ring_gap;
_cx+=hold_ring_offset_x;
var _cy=_anchor_y-2+hold_ring_offset_y;
var _tint=_hold_latched?1:_hold_progress;
var _col=merge_color(c_white,hold_color_end,_tint);
var _text_alpha=(_inst.override_alpha_enabled?_inst.override_alpha:1);

var _prev_filter=gpu_get_tex_filter();
gpu_set_tex_filter(false);
surface_set_target(_surface_ui);
draw_surface_ext(_hold_ring_surface,_cx,_cy,2,2,0,_col,_hold_alpha*_text_alpha);
surface_reset_target();
gpu_set_tex_filter(_prev_filter);