function Flag_CustomStatic(){
	with(Flag_GetStorage(FLAG_STATIC)){
		Set("name","PLAYER");
		Set("lv",1);
		Set("hp",20);
		Set("hp_max",20);
		Set("atk",10);
		Set("atk_item",0);
		Set("def",10);
		Set("def_item",0);
		Set("spd",2);
		Set("spd_item",0);
		Set("inv",40);
		Set("inv_item",0);
		Set("exp",0);
		Set("gold",0);
		Set("battle_menu_fight_obj","knife");
		Set("kills",0);
		Set("room","room_null");
		Set("time",0);
		Set("fun",0);
		
		Set("item",new Flag_Inventory(8,0));
		Set("phone",new Flag_Inventory(8,0));
		Set("box0",new Flag_Inventory(10,0));
		Set("box1",new Flag_Inventory(10,0));
	}
	Item_SetWeapon(item_stick);
	Item_SetArmor(item_bandage);
	
	Item_Add(item_tml);
	Item_Add(item_stick);
	Item_Add(item_faded_ribbon);
	Item_Add(item_bandage);
	
	Phone_Add(phone_toriel)
	
	Player_SetKills(1)
}