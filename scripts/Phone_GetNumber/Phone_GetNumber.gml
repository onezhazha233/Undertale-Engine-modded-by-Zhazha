function Phone_GetNumber(){
	return Flag_GetStorage(FLAG_STATIC).Get("phone").GetNumber();
}