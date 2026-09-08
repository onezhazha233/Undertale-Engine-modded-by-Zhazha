event_inherited();

if(fall_rot = 1){
	fall_time += 1;
	if(fall_time mod 8 == 1){
		switch(rot mod 4){
			case 0: char_player.dir = DIR.DOWN; break;
			case 1: char_player.dir = DIR.RIGHT; break;
			case 2: char_player.dir = DIR.UP; break;
			case 3: char_player.dir = DIR.LEFT; break;
		}
		rot++;
	}
}
else{
	fall_time = 0;
	rot = 0;
}