event_inherited();

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	if(jump_state = 0){
		if(on_platform = 1){
			if(instance_exists(inst_plat)){
				if(inst_plat.sticky = 1){
					x += inst_plat.x - inst_plat.xprevious;
					y += inst_plat.y - inst_plat.yprevious;
				}
			}
		}
	}//随板子移动
	
	if(jump_state = 0){
		if(xprevious != x||yprevious != y){
			moving = 1;
		}
		else{
			moving = 0;
		}
	}
	else{
		moving = 1;
	}//是否在移动
}
