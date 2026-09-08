depth=-2000-y;

if(place_meeting(x,y,char_player)){
	if(c == 0){
		with(bg_grass){
			if(soundtimer < 0){
				if(sounder = 1)sound = 1;
			}
		}
	}
	c = 4;
	yscale = 1.9;
	xscale = 1.1;
}
else{
	yscale = 2;
	xscale = 1;
	place = 0;
}

if(c == 0){
	yscale = 2;
	xscale = 1;
}
else{
    c -= 1;
}

if(sounder = 1){
	if (sound == 1 && soundtimer < 0){
	    audio_play_sound(snd_splash,0,0);
	    sound = 0;
	    soundtimer = 6;
	}

	soundtimer -= 1;
}