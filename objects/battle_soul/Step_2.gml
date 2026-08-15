if(Player_GetHp()<=0){
	Flag_Set(FLAG_TEMP,"gameover_soul_position",[x-camera.x,y-camera.y]);
	room_goto(room_gameover);
}

var STATE=Battle_GetState();
if(STATE==BATTLE_STATE.TURN_PREPARATION||STATE==BATTLE_STATE.IN_TURN){
	Xpoly_Booleanation(battle_board.objs);
	var result = Xpoly_Collision_Check(x,y,sprite_get_width(sprite_index)/2,-90);
	if(!result[0]){
		x = result[4];
		y = result[5];
	}
}