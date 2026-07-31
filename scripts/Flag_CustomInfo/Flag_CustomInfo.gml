function Flag_CustomInfo(){
	with(Flag_GetStorage(FLAG_INFO)){
		Set("name",Player_GetName());
		Set("lv",Player_GetLv());
		Set("time",Flag_GetStorage(FLAG_STATIC).Get("time"));
		Set("room",Flag_GetStorage(FLAG_STATIC).Get("room"));
	}
}