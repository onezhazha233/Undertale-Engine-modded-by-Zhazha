function Language(){
	var LANG=Flag_Get(FLAG_SETTINGS,"language","english");
	// 兼容整数索引存储（设置界面切换时存的是索引）
	if(is_real(LANG)){
		var NAME=Lang_GetName(LANG);
		if(is_string(NAME)&&NAME!=""){
			return NAME;
		}
		return "english";
	}
	if(!is_string(LANG)||!Lang_IsExists(LANG)){
		return "english";
	}
	return LANG;
}
