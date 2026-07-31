///@arg lang_name
///@arg key
///@arg default*
function Lang_GetInfo(LANG, KEY, DEF="") {
	var NAME=Lang_ResolveName(LANG);
	if(NAME==""){
		return DEF;
	}
	var MANIFEST=Lang_GetManifest(NAME);
	if(!is_struct(MANIFEST)){
		return DEF;
	}
	if(!variable_struct_exists(MANIFEST,"info")){
		return DEF;
	}
	var INFO=variable_struct_get(MANIFEST,"info");
	if(!variable_struct_exists(INFO,KEY)){
		return DEF;
	}
	return variable_struct_get(INFO,KEY);
}
