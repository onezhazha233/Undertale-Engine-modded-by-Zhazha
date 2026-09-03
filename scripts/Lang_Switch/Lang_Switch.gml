///@arg lang_id
function Lang_Switch(LANG_ID){
	if(LANG_ID<0||LANG_ID>=Lang_GetNumber()){
		return false;
	}

	// 保存语言设置
	Flag_Set(FLAG_SETTINGS, "language", LANG_ID);

	// 清除旧语言资源
	Lang_ClearString();
	Lang_ClearSprite();
	Lang_ClearFont();
	Lang_ClearAudio();
	
	// 加载新语言
	Lang_LoadLanguage(Language());
	
	Encounter_Custom();
	Shop_Custom();

	return true;
}