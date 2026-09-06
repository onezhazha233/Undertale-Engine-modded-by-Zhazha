function Player_Load(SLOT){
	Flag_SetSlot(SLOT);
	Flag_Load(FLAG_STATIC);
	Flag_Load(FLAG_DYNAMIC);
	Flag_Load(FLAG_INFO);
	Flag_Load(FLAG_PLOT);
	Flag_Set(FLAG_TEMP,"trigger_warp_landmark",Flag_Get(FLAG_INFO,"landmark"));
	return true;
}
