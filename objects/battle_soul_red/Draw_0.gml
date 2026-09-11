event_inherited();

var STATE=Battle_GetState();
if(STATE==BATTLE_STATE.TURN_PREPARATION||STATE==BATTLE_STATE.IN_TURN){
	Xpoly_Booleanation(battle_board.objs);
	for(i=0;i<4;i+=1){
		var result = Xpoly_Collision_Check(x+lengthdir_x(1,90*i),y+lengthdir_y(1,90*i),sprite_get_width(sprite_index)/2,-90);
		draw_text(x+lengthdir_x(20,90*i),y+lengthdir_y(20,90*i),result[0]);
	}
}