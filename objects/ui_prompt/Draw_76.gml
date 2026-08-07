if(!variable_global_exists("prompt_surface")||!surface_exists(global.prompt_surface)){
	global.prompt_surface=surface_create(640,480);
}
_surface_ui=global.prompt_surface;
if(instance_exists(_inst)&&!surface_exists(_inst._surface)){
	_inst._surface_enabled=true;
	_inst._surface=_surface_ui;
}