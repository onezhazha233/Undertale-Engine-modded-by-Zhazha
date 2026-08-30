if(!surface_exists(_surface_ui)){
	_surface_ui = surface_create(640,480);
	_inst.SetSurface(_surface_ui);
}
if(surface_exists(_surface_ui)){
	surface_set_target(_surface_ui);
	draw_clear_alpha(0,0);
	surface_reset_target();
}