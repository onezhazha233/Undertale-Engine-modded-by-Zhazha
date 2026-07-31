///@arg lang_name
function Lang_LoadManifest(LANG){
	if(!file_exists(GMU_LANG_PATH_BASE+LANG+".json")){
		return false;
	}

	var str=Lang_LoadFileToString(GMU_LANG_PATH_BASE+LANG+".json");
	if(str==""){
		return false;
	}

	var obj=json_parse(str);
	if(typeof(obj)!="struct"){
		return false;
	}

	global._gmu_lang_manifest=obj;
	return true;
}
