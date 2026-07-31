///@arg heal_hp
///@arg new_line*
function Item_GetTextHeal(HEAL, LINE=true){
	var result=(LINE ? "&" : "");
	result+="{define `HP` "+string(HEAL)+"}";

	if(Flag_Get(FLAG_STATIC,"hp")>=Flag_Get(FLAG_STATIC,"hp_max")){
		result+=Lang_GetString("item.heal.all");
	}else{
		result+=Lang_GetString("item.heal.part");
	}

	return result;
}
