if(!surface_exists(_surface1)){
	_surface1=surface_create(640,480);
}
if(!surface_exists(_surface2)){
	_surface2=surface_create(640,480);
}
if(!surface_exists(_surface3)){
	_surface3=surface_create(640,480);
}
if(!surface_exists(_surface4)){
	_surface4=surface_create(640,480);
}

surface_set_target(_surface1);{
	draw_clear_alpha(c_black,0);
	surface_reset_target();
	surface_set_target(_surface3);
	draw_clear_alpha(c_black,0);
}surface_reset_target();
if(!surface_exists(_surface)){
	_surface=surface_create(640,480);
}

surface_set_target(_surface);{
	draw_clear_alpha(color_bg,0);
}surface_reset_target();

surface_set_target(_surface4);{
	draw_clear_alpha(color_bg,0);
}surface_reset_target();
