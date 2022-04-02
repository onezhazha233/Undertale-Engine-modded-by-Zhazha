if(pushSoulEnabled){
	// Game frozen protector, as well as the count of pixels each frame can move at most.
	var tryTimes=10000;
	if(Battle_GetState()==BATTLE_STATE.TURN_PREPARATION||Battle_GetState()==BATTLE_STATE.IN_TURN){
		while(place_meeting(x,y,battle_soul)&&tryTimes>0){
			battle_soul.x+=lengthdir_x(0.1,pushSoulDirection+image_angle);
			battle_soul.y+=lengthdir_y(0.1,pushSoulDirection+image_angle);
			tryTimes-=1;
		}
	}
}