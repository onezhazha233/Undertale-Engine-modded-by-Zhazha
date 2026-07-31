///@arg spd_item
function Player_SetSpdItem(SPD){
	Flag_Set(FLAG_STATIC,"spd_item", SPD);
	return SPD;
}
