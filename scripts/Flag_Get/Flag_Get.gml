function Flag_Get(TYPE, NAME, DEFAULT=0){
	return Flag_GetStorage(TYPE).Get(NAME,DEFAULT);
}