function Item_SetWeapon(ITEM){
	if(Item_IsValid(ITEM)){
		Flag_Set(FLAG_STATIC,"item_weapon",ITEM);
		return true;
	}else{
		return false;
	}
}
