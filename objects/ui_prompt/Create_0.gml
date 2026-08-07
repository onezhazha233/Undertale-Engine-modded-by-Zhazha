depth=DEPTH_UI.PANEL;

_surface_ui=noone; // aliases global.prompt_surface each Pre-Draw


_text="";
_prefix="{shadow false}{scale 2}{font 1}{instant true}{gui true}{outline true}{color_outline `black`}{depth "+string(DEPTH_UI.TEXT)+"}";
_inst=noone;
_pos=PROMPT_POS.BOT_LEFT;
_anchor_y=0;

fade_in_time=0;

hold_enabled=false;
hold_input=INPUT.CANCEL;
hold_duration=90;
hold_ring_fade_in=15;
hold_color_end=make_color_rgb(255,82,82);
hold_ring_gap=4;
hold_ring_offset_x=0;
hold_ring_offset_y=0;

_hold_progress=0;
_hold_alpha=0;
_hold_latched=false;
_hold_pending=false;
_hold_ring_surface=-1;

function draw_hold_sector(_x, _y, _r, _a0, _a1){
	if(_a1<=_a0){
		return;
	}
	var _steps=max(3, ceil(abs(_a1-_a0)/10));
	draw_primitive_begin(pr_trianglefan);
	draw_vertex(_x, _y);
	for(var i=0;i<=_steps;i++){
		var _a=lerp(_a0, _a1, i/_steps);
		draw_vertex(_x+lengthdir_x(_r, _a), _y+lengthdir_y(_r, _a));
	}
	draw_primitive_end();
}
