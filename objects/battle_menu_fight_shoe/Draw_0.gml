surface_set_target(Battle_GetBoardSurface());{
	draw_self();
	if(image_alpha==1){
		for(var i=0;i<_num_targets;i++){
			var t=_targets[i];
			if(t.active&&!t.hit){
				var _frame=(i==_current_target)?0:1;
				draw_sprite_ext(spr_battle_menu_fight_aim,_frame,t.x,y,1,1,0,c_white,t.alpha);
			}
		}
	}
}surface_reset_target();

for(var i=0;i<_num_targets;i++){
	var t=_targets[i];
	if(t.fadebar_alpha>0){
		var _fframe=(t.fadebar_image_speed>0)?floor(t.fadebar_image_index)%3:t.fadebar_frame;
		draw_sprite_ext(spr_battle_menu_fight_aim_fade,_fframe,t.x,y,t.fadebar_scale,t.fadebar_scale,0,c_white,t.fadebar_alpha);
	}
}