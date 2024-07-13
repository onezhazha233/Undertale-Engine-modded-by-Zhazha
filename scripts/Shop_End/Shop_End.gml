function Shop_End(){
	var room_return=Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP_ROOM_RETURN);
	if(room_exists(room_return)){
		fader.color=c_black;
		Fader_Fade(0,1,20);
		BGM_SetVolume(4,0,20);
		BGM_SetVolume(0,1,20,20);
	}
}