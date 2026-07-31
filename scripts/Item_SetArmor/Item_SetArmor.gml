function Item_SetArmor(ITEM){
	if(Item_IsValid(ITEM)){
		Flag_Set(FLAG_STATIC,"item_armor",ITEM);
		return true;
	}else{
		return false;
	}
}
