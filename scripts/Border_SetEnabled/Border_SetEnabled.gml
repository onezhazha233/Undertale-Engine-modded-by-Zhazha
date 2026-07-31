function Border_SetEnabled(ENABLED) {
	if(ENABLED){
		window_set_size(960,540);
		border._enabled=true;
	}else{
		window_set_size(640,480);
		border._enabled=false;
	}
	border.alarm[0] = 1;
	return true;
}
