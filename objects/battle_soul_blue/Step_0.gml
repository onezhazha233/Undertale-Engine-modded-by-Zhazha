event_inherited();

image_angle = (dir + 90) mod 360

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	var SPD=Player_GetSpdTotal()*1.25;
	var SPD=(Input_IsHeld(INPUT.CANCEL) ? SPD/2 : SPD);

	//重力方向单位向量（供 block 碰撞与移动用）
	xx = lengthdir_x(dir, 1);
	yy = lengthdir_y(dir, 1);

	jump_input = 0;
	
	//统一重力角：父类 Step_2 的钳制也用同一角度
	soul_gravity_angle = dir + 90;
	soul_touching_ceiling = false;
	Xpoly_Booleanation(battle_board.objs);
	var result = Xpoly_Collision_Check(x, y, sprite_width/2, soul_gravity_angle);
	if(is_array(result)){
		on_board             = result[3];
		soul_touching_ceiling = result[2];
		//只在真正出框时才钳回，避免在角落/边界被钉到错误位置
		if(result[0] == 0){
			x = result[4];
			y = result[5];
		}
	}

	//跳跃键 = 重力反方向
	switch(dir){
		case 0:   jump_input = INPUT.LEFT;  break;
		case 90:  jump_input = INPUT.DOWN;  break;
		case 180: jump_input = INPUT.RIGHT; break;
		case 270: jump_input = INPUT.UP;    break;
	}

	if(!instance_position(x+xx*(sprite_width/2+1),y+yy*(sprite_height/2+1),block)){
		on_block = 0;
	}
	if(!place_meeting(x+xx,y+yy,battle_platform)){
		on_platform = 0;
		inst_plat = noone;
	}
	//底部无支撑时

	if(on_block == 0 && on_board == 0 && on_platform == 0 && jump_state == 0){
		jump_state = 2;
		move = 0;
	}
	//底部无支撑时自然下落

	if(jump_state != 0 && soul_touching_ceiling){
		jump_state = 2;
		if(impact == 0)move = 0;
	}
	if(jump_state != 0 && instance_position(x-xx*(sprite_width/2+1),y-yy*(sprite_height/2+1),block)){
		jump_state = 2;
		if(impact == 0)move = 0;
	}
	//碰到顶时强制下落
	
	if(jump_state == 1){
		if(Input_IsReleased(jump_input)){
			jump_state = 2;
			move = -1;
		}
		if(move >= 0){
			jump_state = 2;
		}
	}
	//松开跳跃键时改变状态
	if(jump_state == 2){
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
			if(impact == 1){
				audio_play_sound(snd_dong,0,0);
				Camera_Shake(8,8,1,1,1,1);
				impact = 0;
			}
		}
		if(on_board = 1){
			jump_state = 0;
			move = 1;
			if(impact == 1){
				audio_play_sound(snd_dong,0,0);
				Camera_Shake(8,8,1,1,1,1);
				impact = 0;
			}
		}
		inst_plat = instance_place(x+xx,y+yy,battle_platform);
		if(instance_exists(inst_plat) && move > 0 && !(abs(inst_plat.angle)-abs(dir)==0 && abs(inst_plat.angle)-abs(dir)==180)){
			on_platform = 1;
			jump_state = 0;
			move = 0;
			if(impact == 1){
				audio_play_sound(snd_dong,0,0);
				Camera_Shake(8,8,1,1,1,1);
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
	if(instance_exists(inst_plat) && !(abs(abs(inst_plat.angle)-abs(dir))==0 || abs(abs(inst_plat.angle)-abs(dir))==180)){
		while(place_meeting(x+fx,y+fy,inst_plat)&&place_meeting(x,y,inst_plat)){
			move = 0;
			jump_state = 0;
	        mx = 0;
	        my = 0;
	        if(dir == 270)my = -1;
			if(dir == 90)my = 1;
	        if(dir == 180)mx = 1;
	        if(dir == 0)mx = -1;
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

	global.is_moving = 0;
	if(Input_IsHeld(INPUT.LEFT)){
		switch(dir){
			case 0:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state == 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 90:
			case 270:
				repeat(10){
					if!(position_meeting(x-sprite_width/2,y,block)){
						x -= SPD/10;
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
				if(jump_state == 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 90:
			case 270:
				repeat(10){
					if!(position_meeting(x+sprite_width/2,y,block)){
					  x += SPD/10;
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
				if(jump_state == 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 0:
			case 180:
				repeat(10){
					if!(position_meeting(x,y-sprite_height/2,block)){
					  y -= SPD/10;
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
				if(jump_state == 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 0:
			case 180:
				repeat(10){
					if!(position_meeting(x,y+sprite_height/2,block)){
					  y += SPD/10;
					}
					else{
						y = yprevious;	
					}
				}
				break;
		}
	}
	//移动和开始跳跃

	//框内钳制：移动结束后，只在真正出框时拉回（防止在角落/边界掉出）
	if(instance_exists(battle_board) && Xpoly_Is_Initialized()){
		Xpoly_Booleanation(battle_board.objs);
		var result = Xpoly_Collision_Check(x, y, sprite_width/2, soul_gravity_angle);
		if(is_array(result) && result[0] == 0){
			x = result[4];
			y = result[5];
		}
	}
}