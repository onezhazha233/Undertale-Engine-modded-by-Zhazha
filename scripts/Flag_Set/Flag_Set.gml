function Flag_Set(TYPE, NAME, VALUE){
	Flag_GetStorage(TYPE).Set(NAME,VALUE);
	return true;
}
