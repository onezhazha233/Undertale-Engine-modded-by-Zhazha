if(char_player.moveable = true){
	char_player.moveable = false;
	event_inherited();
	fall = Event_Create();
	Event_AddFunction(fall, function(){
		with(trigger_ruins_fall)if(main = true){
			if(array_length(hole) < 10){
				array_push(hole,[char_player.x,char_player.y]);
				audio_play_sound(snd_noise,0,false);
			}
			else{
				char_player.moveable = true;
				audio_play_sound(snd_legendary_hero,0,0);
				with(trigger_ruins_fall){
					_triggered = true;
					hole = [];
				}
				Event_Stop(fall);
				Event_Delete(fall);
			}
		}
	});
	Event_AddSleep(fall,20);
	Event_AddFunction(fall, function(){
		char_player.dir = DIR.DOWN;
		char_player.image_alpha = 0.5;
		char_player.collision = false;
		audio_play_sound(snd_fall,0,0);
		Anim_Create(char_player,"y",0,0,char_player.y,400,162);
		fall_rot = 1;
	});
	Event_AddSleep(fall,162);
	Event_AddFunction(fall, function(){
		fall_rot = 0;
		char_player.image_alpha = 1;
		char_player.collision = true;
		char_player.moveable = true;
		_triggered = false;
	});
	Event_Launch(fall);
}