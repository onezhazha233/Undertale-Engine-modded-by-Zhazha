event_inherited();

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	if(xprevious = x&&yprevious = y){
		moving = 0;
	}
	else{
		moving = 1;
	}
}
else{
	moving = 0;
}