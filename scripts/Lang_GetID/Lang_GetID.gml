///@arg lang_name
function Lang_GetID(LANG) {
	var NAME=Lang_ResolveName(LANG);
	if(NAME==""){
		return -1;
	}
	return ds_list_find_index(global._gmu_lang_list,NAME);
}
