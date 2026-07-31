function Lang_LoadAgain() {
	if(global._gmu_lang_loading){
		return false;
	}
	global._gmu_lang_loading=true;

	Lang_ClearSprite();
	Lang_ClearAudio();
	Lang_ClearFont();
	ds_map_clear(global._gmu_lang_string);
	Lang_LoadLanguage(Language());

	global._gmu_lang_loading=false;
	return true;
}
