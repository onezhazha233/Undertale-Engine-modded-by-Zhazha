event_inherited();

if!(surface_exists(surf))surf = surface_create(200,150);

surface_set_target(surf)
draw_clear_alpha(c_gray,1)

draw_set_color(make_color_rgb(240, 130, 130));
for(var i = 0; i < array_length(debris); i++){
	var _d = debris[i];
	var _r = _d.radius * (_d.life / _d.max_life);
	if(_r > 0.5) draw_circle(_d.x, _d.y, _r, false);
}

draw_set_color(make_color_rgb(210, 90, 90));
if(!dying){
	for(var i = 0; i < array_length(asteroids); i++){
		var _a = asteroids[i];
		draw_circle(_a.x, _a.y, _a.radius, false);
	}
}

draw_set_color(c_black);
if(!dying){
	for(var i = 0; i < array_length(bullets); i++){
		var _b = bullets[i];
		var _hx = lengthdir_x(6, _b.angle);
		var _hy = lengthdir_y(6, _b.angle);
		var _px = lengthdir_x(6, _b.angle + 90);
		var _py = lengthdir_y(6, _b.angle + 90);
		draw_line_width(_b.x - _hx, _b.y - _hy, _b.x + _hx, _b.y + _hy, 2);
		draw_line_width(_b.x - _px, _b.y - _py, _b.x + _px, _b.y + _py, 2);
	}
}

if(!dying){
	draw_sprite_ext(spr_char_prompt_test_arrow,0,arrow_x,arrow_y,1,1,arrow_angle,-1,1);
}

if(dying){
	var _fcount = sprite_get_number(spr_char_prompt_test_explosion);
	var _frame;
	if(!screen_closing){
		_frame = floor(explosion_timer) % _fcount;
	}else{
		_frame = _fcount - 1;
	}
	draw_sprite_ext(spr_char_prompt_test_explosion, _frame, explosion_x, explosion_y, 1, 1, 0, c_white, 1);
}

if(paused){
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	draw_rectangle(0, 0, 200, 150, false);
	draw_set_alpha(1);
}

surface_reset_target()