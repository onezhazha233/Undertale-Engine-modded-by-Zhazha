if(instance_exists(battle_board)){
	surface_set_target(battle_board._surface1)
	gpu_set_alphatestenable(0)
	gpu_set_blendmode(bm_normal)
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(0, 0, 0, 1)
	draw_set_alpha(1)
	draw_sprite_ext(spr_pixel_big,0,x,y,xscale/2,yscale/2,angle,c_white,1);
	draw_set_alpha(1)
	gpu_set_blendenable(true)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	surface_reset_target()
		
	surface_set_target(battle_board._surface)
	_point_x = x-xscale/2;
	_point_y = y-yscale/2;
	event_user(0);
	draw_sprite_ext(spr_pixel,0,_point_x,_point_y,5,xscale+5,angle+90,battle_board.color_frame,1)
	_point_x = x+xscale/2;
	_point_y = y-yscale/2;
	event_user(0);
	draw_sprite_ext(spr_pixel,0,_point_x,_point_y,5,yscale+5,angle,battle_board.color_frame,1)
	_point_x = x+xscale/2;
	_point_y = y+yscale/2;
	event_user(0);
	draw_sprite_ext(spr_pixel,0,_point_x,_point_y,5,xscale+5,angle-90,battle_board.color_frame,1)
	_point_x = x-xscale/2;
	_point_y = y+yscale/2;
	event_user(0);
	draw_sprite_ext(spr_pixel,0,_point_x,_point_y,5,yscale+5,angle-180,battle_board.color_frame,1)
	surface_reset_target();
}