if(image_index = 0){
	Dialog_Add(Lang_GetString("door.0"));
	Dialog_Start();
}
if(image_index = 1){
	door_room_list = [
		room_test_waterfall,
		room_test_ruins,
		room_test_hotland,
		room_test_cutscene
	];
	door_choice = -1;

	_door_event = Event_Create();

	Event_AddFunction(_door_event, function(){
		char_player.moveable = false;
	});

	Event_Dialog(_door_event, Lang_GetString("door.1"));

	Event_Choice(_door_event, Lang_GetString("door.choices"), function(result){
		door_choice = result;
		var _target = door_room_list[door_choice];
		if (_target == room) {
			tt = Lang_GetString("door.3");
			Event_Stop(_door_event);
			Event_Delete(_door_event);
			char_player.moveable = true;
		} else {
			tt = Lang_GetString("door.2");
			image_index = 2;
			audio_play_sound(snd_dooropen, 0, false);
		}
		StartDialog(tt);
	});

	Event_AddFunction(_door_event,
		function(){
			var _target = door_room_list[door_choice];
			if (_target != room) {
				fader.alpha = 1;
				audio_play_sound(snd_doorclose, 0, false);
				BGM_StopAll();
			}
		}
	);

	Event_AddSleep(_door_event, 60);

	Event_AddFunction(_door_event,
		function(){
			var _target = door_room_list[door_choice];
			if (_target != room) {
				Flag_Set(FLAG_TEMP, "trigger_warp_landmark", 2);
				room_goto(_target);
				Fader_Fade(-1, 0, 20);
				audio_play_sound(snd_dooropen, 0, false);
			}
		}
	);

	Event_AddFunction(_door_event, function(){
		char_player.moveable = true;
	});

	Event_Launch(_door_event);
}