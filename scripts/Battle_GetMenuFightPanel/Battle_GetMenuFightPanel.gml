function Battle_GetMenuFightPanel(){
	return asset_get_index("battle_menu_fight_"+string(Flag_Get(FLAG_STATIC,"battle_menu_fight_obj","knife")));
}