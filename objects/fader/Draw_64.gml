if(gui){
	draw_sprite_ext(spr_pixel,0,0,0,640,480,0,color,alpha);
}

if(room=room_battle){
	if(draw_soul){
		var STATE=Battle_GetState();
		var MENU=Battle_GetMenu();
		if(STATE==BATTLE_STATE.IN_TURN || STATE==BATTLE_STATE.TURN_PREPARATION || (STATE==BATTLE_STATE.MENU && MENU!=BATTLE_MENU.FIGHT_AIM && MENU!=BATTLE_MENU.FIGHT_ANIM && MENU!=BATTLE_MENU.FIGHT_DAMAGE)){
			if(battle_soul.visible)draw_sprite_ext(battle_soul.sprite_index,battle_soul.image_index,battle_soul.x,battle_soul.y,battle_soul.image_xscale,battle_soul.image_yscale,battle_soul.image_angle,battle_soul.image_blend,battle_soul.image_alpha);
		}
	}
}