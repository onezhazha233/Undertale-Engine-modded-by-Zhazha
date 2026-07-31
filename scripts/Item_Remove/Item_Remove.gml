function Item_Remove(SLOT){
	if(Item_IsSlotValid(SLOT)&&Item_IsValid(Item_Get(SLOT))){
		Flag_Get(FLAG_STATIC,"item").Del(SLOT);
	}
}