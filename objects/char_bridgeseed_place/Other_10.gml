with(char_bridgeseed){
	if(state = 1){
		x = (other.x div 10)*10 + 10;
		y = (other.y div 10)*10 + 10;
		state = 2;
		direction = char_player.dir;
		if!(place_meeting(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),bg_bridgeseed_stop)||place_meeting(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),char_bridgeseed)){
			speed = 1;
		}
		else{
			state = 3;
			Check();
		}
		
	}
}