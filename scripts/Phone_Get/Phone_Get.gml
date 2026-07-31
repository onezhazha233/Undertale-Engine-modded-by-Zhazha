function Phone_Get(SLOT){
	return (Phone_IsSlotValid(SLOT)) ? Flag_Get(FLAG_STATIC,"phone").Get(SLOT) : -1;
}