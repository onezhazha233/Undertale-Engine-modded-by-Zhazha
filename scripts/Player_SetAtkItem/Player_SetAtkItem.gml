///@arg atk_item
function Player_SetAtkItem(ATK){
	Flag_Set(FLAG_STATIC,"atk_item", ATK);
	return ATK;
}
