if(_state==-1){
	if(!instance_exists(ui_dialog)){
		_state=0;
		event_user(0);
	}
}else if(_state==0){
	if(Input_IsPressed(INPUT.LEFT)){
		_choice-=1;
		if(_choice<0){
			_choice=1+menu_enabled;
		}
		audio_play_sound(snd_menu_switch,0,false);
	}else if(Input_IsPressed(INPUT.RIGHT)){
		_choice+=1;
		if(_choice>1+menu_enabled){
			_choice=0;
		}
		audio_play_sound(snd_menu_switch,0,false);
	}else if(Input_IsPressed(INPUT.CONFIRM)){
		if(_choice==0){
			_state=1;
			event_user(0);
		}else if(_choice==1){
			instance_destroy();
		}
		else{
			if(file_exists(Flag_GetPath(FLAG_INFO))){
				BGM_Stop(0);
				room_goto(room_menu);
			}
		}
	}else if(Input_IsPressed(INPUT.CANCEL)){
		instance_destroy();
	}
}else if(_state==1){
	if(Input_IsPressed(INPUT.CONFIRM)||Input_IsPressed(INPUT.CANCEL)){
		instance_destroy();
	}
}