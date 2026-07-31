function Item_Set(SLOT,ITEM){
	if(Item_IsSlotValid(SLOT)&&Item_IsValid(ITEM)){
		Flag_Get(FLAG_STATIC,"item").Set(SLOT,ITEM);
	}
}