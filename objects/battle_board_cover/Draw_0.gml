surface_set_target(battle_board._surface1)
gpu_set_alphatestenable(0)
gpu_set_blendmode(bm_normal)
gpu_set_blendenable(false)
gpu_set_colorwriteenable(0,0,0,1)
draw_set_alpha(1)
draw_sprite_ext(spr_pixel,0,_bg_x,_bg_y,_bg_width,_bg_height,_angle,c_white,1);
draw_set_alpha(1)
gpu_set_blendenable(true)
gpu_set_colorwriteenable(1,1,1,1)
surface_reset_target()
		
surface_set_target(battle_board._surface)
af = battle_board.alpha_frame/2+0.5
draw_sprite_ext(spr_pixel,0,_frame_up_x,_frame_up_y,_frame_up_width,_frame_up_height,_angle,battle_board.color_frame,af);
draw_sprite_ext(spr_pixel,0,_frame_left_x,_frame_left_y,_frame_left_width,_frame_left_height,_angle,battle_board.color_frame,af);
draw_sprite_ext(spr_pixel,0,_frame_down_x,_frame_down_y,_frame_down_width,_frame_down_height,_angle,battle_board.color_frame,af);
draw_sprite_ext(spr_pixel,0,_frame_right_x,_frame_right_y,_frame_right_width,_frame_right_height,_angle,battle_board.color_frame,af);
surface_reset_target();

/*draw_sprite_ext(spr_pixel,0,_frame_up_x,_frame_up_y,_frame_up_width,_frame_up_height,_angle,battle_board.color_frame,1);
draw_sprite_ext(spr_pixel,0,_frame_left_x,_frame_left_y,_frame_left_width,_frame_left_height,_angle,battle_board.color_frame,1);
draw_sprite_ext(spr_pixel,0,_frame_down_x,_frame_down_y,_frame_down_width,_frame_down_height,_angle,battle_board.color_frame,1);
draw_sprite_ext(spr_pixel,0,_frame_right_x,_frame_right_y,_frame_right_width,_frame_right_height,_angle,battle_board.color_frame,1);*/

/*draw_sprite_ext(_inst_frame_up.sprite_index,0,_inst_frame_up.x,_inst_frame_up.y,_inst_frame_up.image_xscale,_inst_frame_up.image_yscale,_inst_frame_up.image_angle,_inst_frame_up.image_blend,0.5)
draw_sprite_ext(_inst_frame_down.sprite_index,0,_inst_frame_down.x,_inst_frame_down.y,_inst_frame_down.image_xscale,_inst_frame_down.image_yscale,_inst_frame_down.image_angle,_inst_frame_down.image_blend,0.5)
draw_sprite_ext(_inst_frame_left.sprite_index,0,_inst_frame_left.x,_inst_frame_left.y,_inst_frame_left.image_xscale,_inst_frame_left.image_yscale,_inst_frame_left.image_angle,_inst_frame_left.image_blend,0.5)
draw_sprite_ext(_inst_frame_right.sprite_index,0,_inst_frame_right.x,_inst_frame_right.y,_inst_frame_right.image_xscale,_inst_frame_right.image_yscale,_inst_frame_right.image_angle,_inst_frame_right.image_blend,0.5)