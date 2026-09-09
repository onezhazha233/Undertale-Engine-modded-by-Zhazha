if(char_player.moveable = true){
	bell = Event_Create();
	Event_AddFunction(bell,function(){
		char_player.moveable = false;
		audio_play_sound(snd_bell,0,0);
		image_speed = 0.2;
		with(char_bridgeseed){
			Anim_Create(id,"image_alpha",0,0,1,-1,25);
		}
	});
	Event_AddSleep(bell,30);
	Event_AddFunction(bell,function(){
		with(char_bridgeseed){
			x = xstart;
			y = ystart;
			Anim_Create(id,"image_alpha",0,0,0,1,25);
			state = 0;
			image_index = 0;
			interact_enabled = true;
		}
		with(block){
			if(variable_instance_exists(id,"open")){
				block_enabled = true;
				open = 0;
			}
		}
	});
	Event_AddSleep(bell,30);
	Event_AddFunction(bell,function(){
		char_player.moveable = true;
		image_speed = 0;
		image_index = 0;
	});
	Event_Launch(bell);
}