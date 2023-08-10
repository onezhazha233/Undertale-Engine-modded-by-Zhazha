surface_set_target(_surface3)
draw_surface(application_surface,0,0)
surface_reset_target()
surface_set_target(_surface3)
gpu_set_alphatestenable(0)
gpu_set_blendmode(bm_normal)
gpu_set_blendenable(false)
gpu_set_colorwriteenable(0, 0, 0, 1)
draw_set_alpha(1)
draw_surface(_surface1, 0, 0)
draw_set_alpha(1)
gpu_set_blendenable(true)
gpu_set_colorwriteenable(1, 1, 1, 1)
surface_reset_target()

surface_set_target(_surface4)
draw_surface(_surface,0,0);
surface_reset_target();

surface_set_target(_surface)
	draw_clear_alpha(color_bg,0);
surface_reset_target();

surface_set_target(_surface)
draw_surface_ext(application_surface,0,0,1,1,0,c_white,1-alpha_bg);
draw_surface(_surface4,0,0);
surface_reset_target();


for(var i = 0; i < global.borderCount; i++){
	bb = ds_list_find_value(global.borders_list,i);
	if(instance_exists(bb)){
		bb.replaceSurfaceAlpha(_surface, 0, 0, i == 0);
	}
}

for(var i = 0; i < global.borderCount; i++){	//遍历所有框，应用遮罩效果
	bb = ds_list_find_value(global.borders_list,i);
	if(instance_exists(bb)){
		bb.replaceSurfaceAlpha(_surface, 0, 0, i == 0);
		with(bb){
			drawBorder();
		}
	}
}
draw_surface(_surface,0,0);
draw_surface(_surface3,0,0);
