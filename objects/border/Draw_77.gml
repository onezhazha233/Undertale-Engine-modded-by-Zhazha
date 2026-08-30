if(_enabled){
	var SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
	var SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
	var SX=SW/960;
	var SY=SH/540;
	var SF=min(SX,SY);
	// 画面内：相机正常震动；边框：取反偏移，两者相反
	var shake_ox=0;
	var shake_oy=0;
	if(instance_exists(camera)){
		shake_ox=floor(camera._shake_pos_x*SF);
		shake_oy=floor(camera._shake_pos_y*SF);
	}
	var base_x=(SW-960*SF)/2;
	var base_y=(SH-540*SF)/2;
	var border_x=base_x-shake_ox;
	var border_y=base_y-shake_oy;
	display_set_gui_maximize(SF,SF,base_x+160*SF,base_y+30*SF);
	if(Border_IsDynamic(Flag_Get(FLAG_SETTINGS,"border"))){
		if(sprite_exists(_sprite_previous)){
			draw_sprite_ext(_sprite_previous,0,border_x,border_y,960/sprite_get_width(_sprite_previous)*SF,540/sprite_get_height(_sprite_previous)*SF,0,c_white,1);
		}else{
			draw_sprite_ext(spr_pixel,0,border_x,border_y,SW,SH,0,c_black,1);
		}
		if(sprite_exists(_sprite)){
			draw_sprite_ext(_sprite,0,border_x,border_y,960/sprite_get_width(_sprite)*SF,540/sprite_get_height(_sprite)*SF,0,c_white,_alpha);
		}else{
			draw_sprite_ext(spr_pixel,0,border_x,border_y,SW,SH,0,c_black,_alpha);
		}
	}else{
		var BORDERS=Border_GetSprite(Flag_Get(FLAG_SETTINGS,"border"));
		draw_sprite_ext(BORDERS,0,border_x,border_y,960/sprite_get_width(Border_GetSprite(Flag_Get(FLAG_SETTINGS,"border")))*SF,540/sprite_get_height(Border_GetSprite(Flag_Get(FLAG_SETTINGS,"border")))*SF,0,c_white,1);
	}

	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface_ext(application_surface,base_x+160*SF,base_y+30*SF,SF,SF,0,c_white,1);
	gpu_set_blendmode(bm_normal);
}else{
	var SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
	var SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
	var SX=SW/640;
	var SY=SH/480;
	var SF=min(SX,SY);
	display_set_gui_maximize(SF,SF,(SW-640*SF)/2,(SH-480*SF)/2);
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface_ext(application_surface,(SW-640*SF)/2,(SH-480*SF)/2,SF,SF,0,c_white,1);
	gpu_set_blendmode(bm_normal);
}

/*if(_enabled){
	var SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
	var SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
	var SX=SW/960;
	var SY=SH/540;
	var SF=min(SX,SY);
	display_set_gui_maximize(SF,SF,(SW-960*SF)/2+160*SF,(SH-540*SF)/2+30*SF);
	if(Border_IsDynamic(Flag_Get(FLAG_SETTINGS,"border"))){
		if(sprite_exists(_sprite_previous)){
			draw_sprite_ext(_sprite_previous,0,(SW-960*SF)/2,(SH-540*SF)/2,960/sprite_get_width(_sprite_previous)*SF,540/sprite_get_height(_sprite_previous)*SF,0,c_white,1);
		}else{
			draw_sprite_ext(spr_pixel,0,(SW-960*SF)/2,(SH-540*SF)/2,SW,SH,0,c_black,1);
		}
		if(sprite_exists(_sprite)){
			draw_sprite_ext(_sprite,0,(SW-960*SF)/2,(SH-540*SF)/2,960/sprite_get_width(_sprite)*SF,540/sprite_get_height(_sprite)*SF,0,c_white,_alpha);
		}else{
			draw_sprite_ext(spr_pixel,0,(SW-960*SF)/2,(SH-540*SF)/2,SW,SH,0,c_black,_alpha);
		}
	}else{
		var BORDER=Flag_Get(FLAG_SETTINGS,"border");
		var BSPR=Border_GetSprite(BORDER);
		draw_sprite_ext(BSPR,0,(SW-960*SF)/2,(SH-540*SF)/2,960/sprite_get_width(BSPR)*SF,540/sprite_get_height(BSPR)*SF,0,c_white,1);
	}
	gpu_set_blendmode_ext(bm_one,bm_inv_src_alpha);
	draw_surface_ext(application_surface,(SW-960*SF)/2+160*SF,(SH-540*SF)/2+30*SF,SF,SF,0,c_white,1);
	gpu_set_blendmode(bm_normal);
}else{
	var SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
	var SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
	var SX=SW/640;
	var SY=SH/480;
	var SF=min(SX,SY);
	display_set_gui_maximize(SF,SF,(SW-640*SF)/2,(SH-480*SF)/2);
	gpu_set_blendmode_ext(bm_one,bm_inv_src_alpha);
	draw_surface_ext(application_surface,(SW-640*SF)/2,(SH-480*SF)/2,SF,SF,0,c_white,1);
	gpu_set_blendmode(bm_normal);
}