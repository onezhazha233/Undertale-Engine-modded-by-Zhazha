function Player_SetKrEnabled(ENABLED){
	Flag_Set(FLAG_STATIC,"kr_enabled",ENABLED);
	return ENABLED;
}