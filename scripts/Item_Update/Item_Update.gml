function Item_Update(){
	Flag_Get(FLAG_STATIC,"item").Sort();
	return true;
}