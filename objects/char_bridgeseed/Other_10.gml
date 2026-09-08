if(state = 0){
	s1 = 0;
	with(char_bridgeseed){
		if(state = 1){
			other.s1 = 1;
		}
	}
	if(s1 = 0){
		audio_play_sound(snd_mushroom,0,0);
		state = 1;
	}
}