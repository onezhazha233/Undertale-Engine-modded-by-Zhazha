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

	// 加载新语言
	var LANG_NAME=ds_list_find_value(global._gmu_lang_list,LANG_ID);
	Lang_LoadManifest(LANG_NAME);
	Lang_LoadString(LANG_ID);
	Lang_LoadSprite(LANG_ID);
	Lang_LoadFont(LANG_ID);

	return true;
}
