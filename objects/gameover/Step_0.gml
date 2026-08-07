if(text = 1&&!instance_exists(_inst)){
	text = 2;
}
else if(text = 2){
	if(Input_IsPressed(INPUT.CONFIRM)){
		Fader_Fade(0,1,100);
		alarm[4] = 100;
		//BGM_SetVolume(0,0,30);
	}
}