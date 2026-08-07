function Border_SetEnabled(ENABLED){
	var scale=Flag_Get(FLAG_SETTINGS,"window_scale",1);
	if(ENABLED){
		window_set_size(960*scale,540*scale);
		border._enabled=true;
	}else{
		window_set_size(640*scale,480*scale);
		border._enabled=false;
	}
	border.alarm[0] = 1;
	return true;
}
