///@arg def_item
function Player_SetDefItem(DEF){
	Flag_Set(FLAG_STATIC,"def_item", DEF);
	return DEF;
}
