function Lang_GetString(KEY,DEF="",PROCESS=true){
	if(DEF = "")DEF = KEY;
	
	if(Lang_IsStringExists(KEY)){
		var STR = ds_map_find_value(global._gmu_lang_string,KEY);
		if(PROCESS){
			STR = Lang_ProcessString(STR);
		}
	}
	else{
		STR = DEF;
	}
	
	return STR;
}