///@arg ascii_name
function Lang_ResolveName(LANG) {
	if(!is_string(LANG)){
		return "";
	}
	return ds_list_find_index(global._gmu_lang_list,LANG)!=-1 ? LANG : "";
}
