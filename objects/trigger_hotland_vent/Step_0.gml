event_inherited();

if(state = 2){
	if(tt = 0){
		stm = instance_create_depth(x,y,-2001-y,trigger_hotland_vent_steam);
		stm.speed = 3.5;
		stm.direction = ((90 + image_angle) / 2);
		if(image_angle = DIR.DOWN){
			stm.direction = 180;
			stm.speed = 1;
		}
		faceoff += 1;
		if(floor((faceoff / 4)) >= 1){
			char_player.dir += 90;
			char_player.dir = char_player.dir mod 360;
			faceoff = 0;
		}
	}
	char_player.depth = -3000;
	fakevspeed -= fakegrav/2;
	char_player.y -= fakevspeed/2;
	tt = !tt;
}