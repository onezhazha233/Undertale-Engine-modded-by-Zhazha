if(state = 1){
	x = floor(char_player.x) + 1;
	y = floor(char_player.y) - 30;
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)