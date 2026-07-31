///@arg lang_id/name
function Lang_IsExists(LANG) {
	if(is_real(LANG)){
		return is_string(ds_list_find_value(global._gmu_lang_list,LANG));
	}
	return Lang_ResolveName(LANG)!="";
}
