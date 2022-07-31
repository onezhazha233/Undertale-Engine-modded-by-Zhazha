/// @description Insert description here
// You can write your code in this editor
var SPD, xx, yy, input, fx, fy, mx, my, cx, cy, inst, m, _temp_local_var_9;
event_inherited()
if (dir == 270)
    image_angle = 0
else if (dir == 90)
    image_angle = 180
else if (dir == 180)
    image_angle = -90
else if (dir == 0)
    image_angle = 90
	/*var */isInside1 = false;
	/*var */isInside2 = false;
	/*var */isInside3 = false;
	/*var */isInside4 = false;

var STATE=Battle_GetState();
if(STATE==BATTLE_STATE.TURN_PREPARATION||STATE==BATTLE_STATE.IN_TURN){
	if(instance_exists(battle_soul)){
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x - sprite_width/2-1, battle_soul.y)){
				isInside1 = true;
				break;
			}
		}
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x + sprite_width/2+1, battle_soul.y)){
				isInside2 = true;
				break;
			}
		}
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x, battle_soul.y - sprite_height/2 - 1 )){
				isInside3 = true;
				break;
			}
		}
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			if(global.borders[i].contains(battle_soul.x, battle_soul.y + sprite_height/2 + 1)){
				isInside4 = true;
				break;
			}
		}
	
		if(!isInside4&&dir = 270){	//方向为下时碰到下方框
			bbb = 1;
			move = 0;
		}
		if(!isInside3&&dir = 90){	//方向为上时碰到上方框
			bbb = 1;
			move = 0;
		}
		if(!isInside2&&dir = 0){	//方向为右时碰到右方框
			bbb = 1;
			move = 0;
		}
		if(!isInside1&&dir = 180){	//方向为左时碰到左方框
			bbb = 1;
			move = 0;
		}
		
		if(!isInside3&&dir = 270){	//方向为下时碰到上方框
			move = 0;
			Anim_Create(id,"move",0,0,0,-0.001,4);
		}
		if(!isInside4&&dir = 90){	//方向为上时碰到下方框
			move = 0;
			Anim_Create(id,"move",0,0,0,-0.001,4);
		}
		if(!isInside3&&dir = 270){	//方向为下时碰到上方框
			move = 0;
			Anim_Create(id,"move",0,0,0,-0.001,4);
		}
		if(!isInside3&&dir = 270){	//方向为下时碰到上方框
			move = 0;
			Anim_Create(id,"move",0,0,0,-0.001,4);
		}
	}
}
if((Battle_GetState() == 3)&&moveable){
    SPD = Player_GetSpdTotal()
    SPD = (Input_IsHeld(INPUT.CANCEL) ? (SPD / 2) : SPD)
    repeat(SPD * 10){
        if((dir == 180) || (dir == 0)){
            if Input_IsHeld(INPUT.UP){
                if(!position_meeting(x, (y - (sprite_height / 2)), block))
                    y = (y - 0.1);
            }
            if Input_IsHeld(INPUT.DOWN){
                if (!position_meeting(x, (y + (sprite_height / 2)), block))
                    y = (y + 0.1);
            }
        }
        if ((dir == 90) || (dir == 270)){
            if Input_IsHeld(INPUT.LEFT){
                if (!position_meeting((x - (sprite_width / 2)), y, block))
                    x = (x - 0.1);
            }
            if Input_IsHeld(INPUT.RIGHT){
                if (!position_meeting((x + (sprite_width / 2)), y, block))
                    x = (x + 0.1);
			}
        }
    }
    xx = 0
    yy = 0
    if (dir == 270)
        yy = ((sprite_height / 2) + 1)
    else if (dir == 90)
        yy = (((- sprite_height) / 2) - 0.1)
    else if (dir == 180)
        xx = (((- sprite_height) / 2) - 0.1)
    else if (dir == 0)
        xx = ((sprite_height / 2) + 0.1)
    blockk = position_meeting((x + xx), (y + yy), block)
    plat = position_meeting((x + xx), (y + yy), battle_platform)
    input = -1
    if (dir == 270)
        input = INPUT.UP
    else if (dir == 90)
        input = INPUT.DOWN
    else if (dir == 180)
        input = INPUT.RIGHT
    else if (dir == 0)
        input = INPUT.LEFT
    if ((blockk || plat || bbb) && (move >= 0)){
		aaa = 0;
        fx = 0
        fy = 0
        if (dir == 270)
            fy = (sprite_height / 2)
        else if (dir == 90)
            fy = ((- sprite_height) / 2)
        else if (dir == 180)
            fx = ((- sprite_height) / 2)
        else if (dir == 0)
            fx = (sprite_height / 2)
        while (position_meeting((x + fx), (y + fy), block) || position_meeting((x + fx), (y + fy), battle_platform)){
			move = 0;
            mx = 0
            my = 0
            if (dir == 270)
                my = -0.1
            else if (dir == 90)
                my = 0.1
            else if (dir == 180)
                mx = 0.1
            else if (dir == 0)
                mx = -0.1
            x = (x + mx)
            y = (y + my)
        }
        if (position_meeting((x + xx), (y + yy), block) || position_meeting((x + xx), (y + yy), battle_platform)) || (bbb){
            move = 0
            if impact
            {
                impact = 0
                audio_play_sound(snd_dong, 0, 0)
                Camera_Shake(8, 8, 1, 1, 1, 1)
            }
            if position_meeting((x + xx), (y + yy), battle_platform)
            {
                cx = 0
                cy = 0
                if (dir == 270)
                    cy = ((sprite_height / 2) + 1)
                else if (dir == 90)
                    cy = (((- sprite_height) / 2) - 1)
                else if (dir == 180)
                    cx = (((- sprite_height) / 2) - 1)
                else if (dir == 0)
                    cx = ((sprite_height / 2) + 1)
                inst = instance_position((x + cx), (y + cy), battle_platform)
                if instance_exists(inst)
                {
                    if inst.sticky
                        x = (x + (inst.x - inst.xprevious))
                }
            }
            if Input_IsHeld(input)
                move = (- _speed_jump)
        }
    }
    if (move < 0){
        move = (move + _gravity_jump)
        if (! Input_IsHeld(input))
			if(aaa = 0){
				if(move < -1){
					move = -1;
				}
				aaa = 1;
			}
        if (move > 0)
            move = 0
		else if(position_meeting(x-xx,y-yy,block)){
			move = 0;
		}
    }
    else if(move < _gravity_fall_max){
        move = (move + _gravity_fall);
	}
	if(move < 10&&move >= 0&&blockk = 0&&plat = 0){
		aa += 1;
		move += 0.02;
		if(aa mod 4 = 0){
			move += 0.68;
		}
	}
	else{
		aa = 0;
	}
    repeat (abs(move) * 10)
    {
        xx = 0
        yy = 0
        if (dir == 270)
            yy = ((sprite_height / 2) * sign(move))
        else if (dir == 90)
            yy = ((- (sprite_height / 2)) * sign(move))
        else if (dir == 180)
            xx = ((- (sprite_width / 2)) * sign(move))
        else if (dir == 0)
            xx = ((sprite_width / 2) * sign(move))
        if (! position_meeting((x + xx), (y + yy), block)) || (isInside4)
        {
           bbb = 0; 
		   _temp_local_var_9 = ((move > 0) && position_meeting((x + xx), (y + yy), battle_platform))
            m = (! _temp_local_var_9)
        }
        else
            m = 0
        if m
        {
            xx = 0
            yy = 0
            if (dir == 270)
                yy = (0.1 * sign(move))
            else if (dir == 90)
                yy = (-0.1 * sign(move))
            else if (dir == 180)
                xx = (-0.1 * sign(move))
            else if (dir == 0)
                xx = (0.1 * sign(move))
            x = (x + xx)
            y = (y + yy)
        }
    }
    xx = 0
    yy = 0
    if (dir == 270)
        yy = (-0.1 * sign(move))
    else if (dir == 90)
        yy = (0.1 * sign(move))
    else if (dir == 180)
        xx = (0.1 * sign(move))
    else if (dir == 0)
        xx = (-0.1 * sign(move))
    if place_meeting((x + xx), (y + yy), block)
        move = 0
}
else{
	move = 0;
}