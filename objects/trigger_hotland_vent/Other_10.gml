if(char_player.moveable = true){
	event_inherited();
	
	vent = Event_Create();
	Event_AddFunction(vent,function(){
		Anim_Create(char_player,"x",0,0,char_player.x,x-char_player.x,10);
		Anim_Create(char_player,"y",0,0,char_player.y,y-char_player.y,10);
		char_player.moveable=false;
		char_player.res_override=true;
		char_player.image_speed=1/6;
		state = 1;
	});
	Event_AddSleep(vent,10);
	Event_AddFunction(vent,function(){
		char_player.res_override=false;
		char_player.image_speed=0;
		char_player.image_index=0;
		char_player.dir = image_angle;
	});
	Event_AddSleep(vent,20);
	Event_AddFunction(vent,function(){
		audio_play_sound(snd_vaporize,0,0);
		fakegrav = 0.95;
		fakevspeed = 10;
		char_player.direction = image_angle;
		char_player.speed = 3;
		char_player.auto_depth = false;
		state = 2;
		faceoff = -2;
	});
	Event_AddSleep(vent,40);
	Event_AddFunction(vent,function(){
		state = 3;
		char_player.speed = 0;
		char_player.moveable = true;
		char_player.auto_depth = true;
		alarm[0] = 40;
	});
	Event_AddSleep(vent,40);
	Event_AddFunction(vent,function(){
		state = 0;
		_triggered = false;
		tt = 0;
	});
	Event_Launch(vent);
	
}