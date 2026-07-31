if(keyboard_check(vk_escape)){
	if(room=room_logo||room=room_menu||room=room_settings||room=room_battle||room=room_gameover){
		game_end();
	}else{
		_quitting += 1;
	}
}else{
	_quitting += (0-_quitting)/2;
}
if(_quitting >= 60){
	game_end();
}