event_inherited();

if(move = 0){
	if(blockk = 0&&plat = 0){
		moving = 1;
	}
	else{
		moving = 0;
	}
	if((dir == 180) || (dir == 0)){
        if Input_IsHeld(INPUT.UP)&&!Input_IsHeld(INPUT.DOWN){
            if(!position_meeting(x, (y - (sprite_height / 2)), block))
				moving = 1;
        }
        if Input_IsHeld(INPUT.DOWN)&&!Input_IsHeld(INPUT.UP){
            if (!position_meeting(x, (y + (sprite_height / 2)), block))
				moving = 1;
        }
    }
    if ((dir == 90) || (dir == 270)){
        if Input_IsHeld(INPUT.LEFT)&&!Input_IsHeld(INPUT.RIGHT){
            if (!position_meeting((x - (sprite_width / 2)), y, block))
				moving = 1;
        }
        if Input_IsHeld(INPUT.RIGHT)&&!Input_IsHeld(INPUT.LEFT){
            if (!position_meeting((x + (sprite_width / 2)), y, block))
				moving = 1;
		}
    }
}
else{
	moving = 1;
}

if(xprevious = x&&yprevious = y){
	if(bbb = 0&&move > -0.1&&move < 0.1){
		if!(blockk||plat)moving = 1;
	}
	else{
		moving = 0;
	}
}