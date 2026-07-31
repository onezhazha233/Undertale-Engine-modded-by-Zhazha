function Box_Set(BOX_SLOT, SLOT, ITEM){
	if(Box_IsBoxSlotValid(BOX_SLOT) && Box_IsSlotValid(SLOT) && (Item_IsValid(ITEM) || ITEM==-1)){
		Flag_Get(FLAG_STATIC,"box"+string(BOX_SLOT)).Set(SLOT,ITEM);
		Box_Update();
		return true;
	}else{
		return false;
	}
}