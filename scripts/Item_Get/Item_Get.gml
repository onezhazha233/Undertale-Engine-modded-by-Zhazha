function Item_Get(SLOT){
	if(Item_IsSlotValid(SLOT)){
		return Flag_Get(FLAG_STATIC,"item").Get(SLOT);
	}
	return noone;
}