function Player_Save(SLOT){
	Flag_SetSlot(SLOT);
	Flag_Save(FLAG_PLOT);
	Flag_Save(FLAG_STATIC);
	Flag_Set(FLAG_INFO,"lv", Flag_Get(FLAG_STATIC,"lv"));
	Flag_Set(FLAG_INFO,"time", Flag_Get(FLAG_STATIC,"time"));
	Flag_Set(FLAG_INFO,"room", Flag_Get(FLAG_STATIC,"room"));
	Flag_Set(FLAG_INFO,"name", Flag_Get(FLAG_STATIC,"name"));
	Flag_Save(FLAG_INFO);
	return true;
}
