event_inherited();
mask_index=sprite_index
switch(dir){
	case 0:
		image_angle = 90;
		break;
		
	case 90:
		image_angle = 180;
		break;
		
	case 180:
		image_angle = -90;
		break;
		
	case 270:
		image_angle = 0;
		break;
}

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	var isInside1 = false;
	var isInside2 = false;
	var isInside3 = false;
	var isInside4 = false;
	for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
		bb = ds_list_find_value(global.borders_list,i);
		if(bb.contains(battle_soul.x - sprite_width/2-1, battle_soul.y)) {
			isInside1 = true;
			break;
		}
	}
	for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
		bb = ds_list_find_value(global.borders_list,i);
		if(bb.contains(battle_soul.x + sprite_width/2, battle_soul.y)) {
			isInside2 = true;
			break;
		}
	}
	for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
		bb = ds_list_find_value(global.borders_list,i);
		if(bb.contains(battle_soul.x, battle_soul.y - sprite_height/2-1)) {
			isInside3 = true;
			break;
		}
	}
	for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
		bb = ds_list_find_value(global.borders_list,i);
		if(bb.contains(battle_soul.x, battle_soul.y + sprite_height/2+1)) {
			isInside4 = true;
			break;
		}
	}

	xx = 0;
	yy = 0;
	ii = 0;
	jump_input = 0;
	opposite_dir = 0;
	if(dir = 0){
		xx = 1;
		ii = isInside2;
		jump_input = INPUT.LEFT;
		opposite_dir = isInside1;
	}
	if(dir = 90){
		yy = -1;
		ii = isInside3;
		jump_input = INPUT.DOWN;
		opposite_dir = isInside4;
	}
	if(dir = 180){
		xx = -1;
		ii = isInside1;
		jump_input = INPUT.RIGHT;
		opposite_dir = isInside2;
	}
	if(dir = 270){
		yy = 1;
		ii = isInside4;
		jump_input = INPUT.UP;
		opposite_dir = isInside3;
	}

	if!(instance_position(x+xx*(sprite_width/2+1),y+yy*(sprite_height/2+1),block)){
		on_block = 0;
	}
	if!(ii = 0){
		on_board = 0;
	}
	if!(place_meeting(x+xx,y+yy,battle_platform)){
		on_platform = 0;
		inst_plat = noone;
	}
	//底部无支撑时

	if(on_block = 0&&on_board = 0&&on_platform = 0&&jump_state = 0){
		jump_state = 2;
		move = 0;
	}
	//底部无支撑时自然下落

	if(jump_state != 0&&opposite_dir = 0){
		jump_state = 2;
		if(impact = 0)move = 0;
	}
	if(jump_state != 0&&instance_position(x-xx*(sprite_width/2+1),y-yy*(sprite_height/2+1),block)){
		jump_state = 2;
		if(impact = 0)move = 0;
	}
	//碰到顶时强制下落
	
	if(jump_state = 1){
		if(Input_IsReleased(jump_input)){
			jump_state = 2;
			move = -1;
		}
		if(move >= 0){
			jump_state = 2;
		}
	}
	//松开跳跃键时改变状态
	if(jump_state = 2){
		if(move <= max_speed){
			move += gravity_fall;
		}
		else{
			move = max_speed;
		}
		//自然下落
	
		if(instance_position(x+xx*(sprite_width/2+1),y+yy*(sprite_height/2+1),block)){
			on_block = 1;
			jump_state = 0;
			move = 0;
			if(impact = 1){
				audio_play_sound(snd_dong,0,0);
				if(impact_shake){Camera_Shake(8,8,1,1,1,1);}
				if(impact_damage&&Player_GetHp()>1){Player_Hurt(1)}else if(Player_GetHp()=1&&Player_GetKR()>0){Player_SetKR(Player_GetKR()-1)}
				impact = 0;
			}
		}
		if(ii = 0){
			on_board = 1;
			jump_state = 0;
			move = 1;
			if(impact = 1){
				audio_play_sound(snd_dong,0,0);
				if(impact_shake){Camera_Shake(8,8,1,1,1,1);}
				if(impact_damage&&Player_GetHp()>1){Player_Hurt(1)}else if(Player_GetHp()=1&&Player_GetKR()>0){Player_SetKR(Player_GetKR()-1)}
				impact = 0;
			}
		}
		inst_plat = instance_place(x+xx,y+yy,battle_platform);
		if(instance_exists(inst_plat)&&move > 0&&!(abs(inst_plat.angle)-abs(dir)=0&&abs(inst_plat.angle)-abs(dir)=180)){
			on_platform = 1;
			jump_state = 0;
			move = 0;
			if(impact = 1){
				audio_play_sound(snd_dong,0,0);
				if(impact_shake){Camera_Shake(8,8,1,1,1,1);}
				if(impact_damage&&Player_GetHp()>1){Player_Hurt(1)}else if(Player_GetHp()=1&&Player_GetKR()>0){Player_SetKR(Player_GetKR()-1)}
				impact = 0;
			}
			
		}
		//碰到支撑物时停止下落并改变状态
	}

	fx = 0
    fy = 0
    if (dir == 270)
        fy = 1//(sprite_height / 2)
    else if (dir == 90)
        fy = -1//((- sprite_height) / 2)
    else if (dir == 180)
        fx = -1//((- sprite_height) / 2)
    else if (dir == 0)
        fx = 1//(sprite_height / 2)
	if(instance_exists(inst_plat)&&!(abs(abs(inst_plat.angle)-abs(dir))=0||abs(abs(inst_plat.angle)-abs(dir))=180)){
		while(place_meeting(x+fx,y+fy,inst_plat)&&place_meeting(x,y,inst_plat)){
			move = 0;
			jump_state = 0;
	        mx = 0;
	        my = 0;
	        if(dir = 270)my = -1;
			if(dir = 90)my = 1;
	        if(dir = 180)mx = 1;
	        if(dir = 0)mx = -1;
	        x += mx;
	        y += my;
		}
	}

	switch(dir){
		case 0:
			x += move;
			break;
			
		case 90:
			y -= move;
			break;
			
		case 180:
			x -= move;
			break;
			
		case 270:
			y += move;
			break;
	}

	moving = 0;
	if(Input_IsHeld(INPUT.LEFT)){
		switch(dir){
			case 0:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 90:
			case 270:
				repeat(10){
					if!(position_meeting(x-sprite_width/2,y,block)){
						x -= (Input_IsHeld(INPUT.CANCEL) ? Player_GetSpdTotal()/2 : Player_GetSpdTotal())/10;
					}
					else{
						x = xprevious;	
					}
				}
				break;
		}
	}
	if(Input_IsHeld(INPUT.RIGHT)){
		switch(dir){
			case 180:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 90:
			case 270:
				repeat(10){
					if!(position_meeting(x+sprite_width/2,y,block)){
					  x += (Input_IsHeld(INPUT.CANCEL) ? Player_GetSpdTotal()/2 : Player_GetSpdTotal())/10;
					}
					else{
						x = xprevious;	
					}
				}
				break;
		}
	}
	if(Input_IsHeld(INPUT.UP)){
		switch(dir){
			case 270:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 0:
			case 180:
				repeat(10){
					if!(position_meeting(x,y-sprite_height/2,block)){
					  y -= (Input_IsHeld(INPUT.CANCEL) ? Player_GetSpdTotal()/2 : Player_GetSpdTotal())/10;
					}
					else{
						y = yprevious;	
					}
				}
				break;
		}
	}
	if(Input_IsHeld(INPUT.DOWN)){
		switch(dir){
			case 90:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 0:
			case 180:
				repeat(10){
					if!(position_meeting(x,y+sprite_height/2,block)){
					  y += (Input_IsHeld(INPUT.CANCEL) ? Player_GetSpdTotal()/2 : Player_GetSpdTotal())/10;
					}
					else{
						y = yprevious;	
					}
				}
				break;
		}
	}
	//移动和开始跳跃
}
mask_index=spr_battle_soul_mask
