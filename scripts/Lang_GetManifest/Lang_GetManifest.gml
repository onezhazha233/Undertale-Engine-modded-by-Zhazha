///@arg ascii_name
function Lang_GetManifest(LANG) {
	var NAME=Lang_ResolveName(LANG);
	if(NAME==""){
		return undefined;
	}
	return ds_map_find_value(global._gmu_lang_manifest,NAME);
}
