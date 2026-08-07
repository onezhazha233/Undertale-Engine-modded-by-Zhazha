if(!global.debug){
	exit;
}

if(global.debug_show_blocks){
	with(block){
		var enabled=true;
		if(variable_instance_exists(id,"block_enabled")){
			enabled=block_enabled;
		}
		draw_set_color(enabled?c_aqua:c_orange);
		var x1=floor(bbox_left);
		var y1=floor(bbox_top);
		var x2=floor(bbox_right);
		var y2=floor(bbox_bottom);
		draw_set_alpha(0.35);
		draw_rectangle(x1,y1,x2,y2,false);
		draw_set_alpha(0.9);
		draw_rectangle(x1,y1,x2,y2,true);
	}
	with(block_corner_bottomleft){
		draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,0.5);
	}
	with(block_corner_bottomright){
		draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,0.5);
	}
	with(block_corner_topleft){
		draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,0.5);
	}
	with(block_corner_topright){
		draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,0.5);
	}
	with(trigger){
		draw_set_color(c_fuchsia);
		var x1=floor(bbox_left);
		var y1=floor(bbox_top);
		var x2=floor(bbox_right);
		var y2=floor(bbox_bottom);
		draw_set_alpha(0.35);
		draw_rectangle(x1,y1,x2,y2,false);
		draw_set_alpha(0.9);
		draw_rectangle(x1,y1,x2,y2,true);
	}

	with(battle_bullet){
		draw_set_color(c_lime);
		var x1=floor(bbox_left);
		var y1=floor(bbox_top);
		var x2=floor(bbox_right);
		var y2=floor(bbox_bottom);
		draw_set_alpha(0.35);
		draw_rectangle(x1,y1,x2,y2,false);
		draw_set_alpha(0.9);
		draw_rectangle(x1,y1,x2,y2,true);
	}
	with(battle_soul){
		draw_set_color(c_yellow);
		var x1=floor(bbox_left);
		var y1=floor(bbox_top);
		var x2=floor(bbox_right);
		var y2=floor(bbox_bottom);
		draw_set_alpha(0.35);
		draw_rectangle(x1,y1,x2,y2,false);
		draw_set_alpha(0.9);
		draw_rectangle(x1,y1,x2,y2,true);
	}
	draw_set_alpha(1);
	draw_set_color(c_white);
}

if(global.debug_show_char_pos){
	draw_set_font(font_crypt_of_tomorrow);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1);
	var list=char_pos_list;
	for(var i=0;i<array_length(list);i++){
		with(list[i]){
			draw_text(x-20,y-20,string(floor(x))+"\n"+string(floor(y)));
		}
	}
}
