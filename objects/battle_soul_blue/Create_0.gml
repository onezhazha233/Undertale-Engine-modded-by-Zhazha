event_inherited();
moveable=true;
dir=DIR.DOWN;
move=0;
impact=0;
on_block=0;
on_platform=0;
on_board=0;
inst_plat=noone;

soul_touching_ceiling=false;

jump_state=0;
//0为在地上不动 1为向上跳 2为自由下落
gravity_jump=0.15;
gravity_fall=0.15;
jump_speed=4.8;
max_speed=20;

Land = function(){
	jump_state=0;
	move=0;
	if(impact==1){
		audio_play_sound(snd_impact,0,0);
		Camera_Shake(8,8,1,1,1,1);
		impact=0;
	}
}

Slide = function(_sx,_sy){
	var SPD=Player_GetSpdTotal()*1.25;
	SPD=(Input_IsHeld(INPUT.CANCEL) ? SPD/2 : SPD)
	
	repeat(10){
		if(!position_meeting(x+sprite_width/2*_sx,y+sprite_height/2*_sy,block)){
			x+=_sx*SPD/10;
			y+=_sy*SPD/10;
		}
		else{
			x=xprevious;
			y=yprevious;
		}
	}
}

/*
这是一个甩灵魂的代码示例，最后四行不能漏掉

Here is a example of slaming soul, last 4 lines mustn't be omitted

battle_soul.dir = 90;
battle_soul.move = 6;
battle_soul.impact = 1;
battle_soul.jump_state = 2;
battle_soul.on_block = 0;
battle_soul.on_board = 0;
battle_soul.on_platform = 0;
*/