///@arg inv_item
function Player_SetInvItem(INV){
	Flag_Set(FLAG_STATIC,"inv_item", INV);
	return INV;
}
