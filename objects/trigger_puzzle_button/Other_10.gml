event_inherited();

audio_play_sound(snd_puzzle_reset,0,0)
image_index = 1
wrong = 0
with(trigger_puzzle_xo){
	if!(image_index = 1)other.wrong = 1;
}
if(wrong = 0){
	with(trigger_puzzle_xo){
		_triggered = true;
		image_index = 3;
	}
	if(Player_GetPlot("puzzle_test") = 0){
		char_player.moveable = false;
		solve = Event_Create();
		Event_AddSleep(solve,30);
		Event_AddFunction(solve,function(){
			cx = camera.x;
			cy = camera.y;
			camera.target = noone;
			Anim_Create(camera,"x",0,0,cx,-cx,60);
			Anim_Create(camera,"y",0,0,cy,-cy,60);
		});
		Event_AddSleep(solve,27);
		Event_AddFunction(solve,function(){
			char_sans.x = 80;
			char_sans.y = 70;
			Player_SetPlot("sans",4);
		});
		Event_AddSleep(solve,63);
		Event_AddFunction(solve,function(){
			audio_play_sound(snd_spike_disable,0,0);
			Camera_Shake(3,0,2);
			char_door.image_index = 1;
			Player_SetPlot("puzzle_test",1);
		});
		Event_AddSleep(solve,60);
		Event_AddFunction(solve,function(){
			Anim_Create(camera,"x",0,0,0,cx,60);
			Anim_Create(camera,"y",0,0,0,cy,60);
		});
		Event_AddSleep(solve,60);
		Event_AddFunction(solve,function(){
			char_player.moveable = true;
			char_player.dir = DIR.DOWN;
			camera.target = char_player.id;
		});
		Event_Launch(solve);
	}
}
else{
	with(trigger_puzzle_xo){
		_triggered = false;
		image_index = 0;
	}
}