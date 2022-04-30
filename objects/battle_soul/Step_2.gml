if(Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP)<=0){
	Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.GAMEOVER_SOUL_X,x-camera.x);
	Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.GAMEOVER_SOUL_Y,y-camera.y);
	room_goto(room_gameover);
}
global.borderCount = array_length(global.borders);
var STATE=Battle_GetState();
if(STATE==BATTLE_STATE.TURN_PREPARATION||STATE==BATTLE_STATE.IN_TURN){
	if(instance_exists(battle_soul)){
		var isInside1 = false;
		var isInside2 = false;
		var isInside3 = false;
		var isInside4 = false;
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x - sprite_width/2, battle_soul.y)) {
				isInside1 = true;
				break;
			}
		}
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x + sprite_width/2, battle_soul.y)) {
				isInside2 = true;
				break;
			}
		}
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x, battle_soul.y - sprite_height/2)) {
				isInside3 = true;
				break;
			}
		}
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x, battle_soul.y + sprite_height/2)) {
				isInside4 = true;
				break;
			}
		}

		if(!isInside1) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				var pos = global.borders[i].limit(battle_soul.x - sprite_width/2, battle_soul.y);
				var dis = point_distance(battle_soul.x - sprite_width/2, battle_soul.y, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			battle_soul.x = nearestPos[0] + sprite_width/2;
			battle_soul.y = nearestPos[1];
		}
		if(!isInside2) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				var pos = global.borders[i].limit(battle_soul.x + sprite_width/2, battle_soul.y);
				var dis = point_distance(battle_soul.x + sprite_width/2, battle_soul.y, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			battle_soul.x = nearestPos[0] - sprite_width/2;
			battle_soul.y = nearestPos[1];
		}
		if(!isInside3) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				var pos = global.borders[i].limit(battle_soul.x, battle_soul.y - sprite_height/2);
				var dis = point_distance(battle_soul.x, battle_soul.y - sprite_height/2, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			battle_soul.x = nearestPos[0];
			battle_soul.y = nearestPos[1] + sprite_height/2;
		}
		if(!isInside4) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				var pos = global.borders[i].limit(battle_soul.x,battle_soul.y + sprite_height/2);
				var dis = point_distance(battle_soul.x, battle_soul.y + sprite_height/2, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			battle_soul.x = nearestPos[0];
			battle_soul.y = nearestPos[1] - sprite_height/2;
		}
	}
}