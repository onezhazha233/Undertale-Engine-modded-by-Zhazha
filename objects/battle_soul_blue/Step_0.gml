event_inherited();

image_angle=dir+90;

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	var SPD=Player_GetSpdTotal()*1.25;
	SPD=(Input_IsHeld(INPUT.CANCEL) ? SPD/2 : SPD);

	//重力方向单位向量（供 block 碰撞与移动用）
	xx=lengthdir_x(1,dir);
	yy=lengthdir_y(1,dir);

	jump_input=INPUT.UP;

	soul_gravity_angle=dir+90;
	soul_touching_ceiling=false;
	Xpoly_Booleanation(battle_board.objs);
	var result=Xpoly_Collision_Check(x,y,sprite_width/2,soul_gravity_angle);
	if(is_array(result)){
		on_board=result[3];
		soul_touching_ceiling=result[2];
		//只在真正出框时才钳回，避免在角落/边界被钉到错误位置
		if(result[0]==0){
			x=result[4];
			y=result[5];
		}
	}

	//跳跃键 = 重力反方向
	switch(dir){
		case DIR.RIGHT: jump_input=INPUT.LEFT;  break;
		case DIR.UP:    jump_input=INPUT.DOWN;  break;
		case DIR.LEFT:  jump_input=INPUT.RIGHT; break;
		case DIR.DOWN:  jump_input=INPUT.UP;    break;
	}

	if(!instance_position(x+xx*(sprite_width/2+1),y+yy*(sprite_height/2+1),block)){
		on_block=0;
	}
	if(!place_meeting(x+xx,y+yy,battle_platform)){
		on_platform=0;
		inst_plat=noone;
	}

	//底部无支撑时自然下落
	if(on_block==0 && on_board==0 && on_platform==0 && jump_state==0){
		jump_state=2;
		move=0;
	}

	if(jump_state!=0 && soul_touching_ceiling){
		jump_state=2;
		if(impact==0){
			move=0;
		}
	}
	if(jump_state!=0 && instance_position(x-xx*(sprite_width/2+1),y-yy*(sprite_height/2+1),block)){
		jump_state=2;
		if(impact==0){
			move=0;
		}
	}
	//碰到顶时强制下落

	if(jump_state==1){
		if(Input_IsReleased(jump_input)){
			jump_state=2;
			move=-1;
		}
		if(move>=0){
			jump_state=2;
		}
	}
	//松开跳跃键时改变状态

	if(jump_state==2){
		if(move<=max_speed){
			move+=gravity_fall;
		}
		else{
			move=max_speed;
		}
		//自然下落

		if(instance_position(x+xx*(sprite_width/2+1),y+yy*(sprite_height/2+1),block)){
			on_block=1;
			Land();
		}
		if(on_board==1){
			Land();
			move=1;
		}
		inst_plat=instance_place(x+xx,y+yy,battle_platform);
		if(instance_exists(inst_plat) && move>0 && !(abs(inst_plat.image_angle)-abs(dir)==0 || abs(inst_plat.image_angle)-abs(dir)==180)){
			//单向板：仅当灵魂中心在板子的反重力侧(上方)才算落地；从下方跳入(中心还在板内/下侧)则不落地、直接穿过
			var _above=-(x-inst_plat.x)*xx-(y-inst_plat.y)*yy;
			if(_above>0){
				on_platform=1;
				Land();
				move=0;   // 清掉残余下落：避免水平移开再回来时把灵魂一点点往下钻进板里
				// 若中心仍嵌在板里(下落较深)，沿反重力推回顶面
				var _g=0;
				while(place_meeting(x+xx,y+yy,inst_plat) && place_meeting(x,y,inst_plat) && _g<40){
					x-=xx;
					y-=yy;
					_g++;
				}
			}
		}
		//碰到支撑物时停止下落并改变状态
	}

	x += xx*move;
	y += yy*move;

	global.is_moving=0;

	//跳跃轴：只有重力反方向的键(jump_input)能起跳
	if(Input_IsHeld(jump_input)){
		if(move<0){
			move+=gravity_jump;
		}
		if(jump_state==0){
			move=-jump_speed;
			jump_state=1;
		}
	}

	//贴墙滑动：沿与重力垂直的轴(sx,sy)细步移动，撞到 block 就回退
	if(dir==DIR.UP || dir==DIR.DOWN){   // 竖直重力 → 左右贴墙滑
		if(Input_IsHeld(INPUT.LEFT)) Slide(-1,0);
		if(Input_IsHeld(INPUT.RIGHT)) Slide(1,0);
	}
	else{                               // 水平重力 → 上下贴墙滑
		if(Input_IsHeld(INPUT.UP)) Slide(0,-1);
		if(Input_IsHeld(INPUT.DOWN)) Slide(0,1);
	}
	//移动和开始跳跃

	//框内钳制：移动结束后，只在真正出框时拉回（防止在角落/边界掉出）
	if(instance_exists(battle_board) && Xpoly_Is_Initialized()){
		Xpoly_Booleanation(battle_board.objs);
		var result=Xpoly_Collision_Check(x,y,sprite_width/2,soul_gravity_angle);
		if(is_array(result) && result[0]==0){
			x=result[4];
			y=result[5];
		}
	}
}