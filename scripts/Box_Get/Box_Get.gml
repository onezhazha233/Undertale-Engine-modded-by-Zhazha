function Box_Get(BOX_SLOT,SLOT){
	return (Box_IsBoxSlotValid(BOX_SLOT) && Box_IsSlotValid(SLOT)) ? Flag_Get(FLAG_STATIC,"box"+string(BOX_SLOT)).Get(SLOT) : -1;
}