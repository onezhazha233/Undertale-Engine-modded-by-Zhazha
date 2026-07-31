///@arg font_name
///@arg default*
function Lang_GetFont(KEY, DEF=-1){

	if(!font_exists(DEF)&&DEF!=-1){
		DEF=-1;
	}

	if(!Lang_IsFontExists(KEY)){
		return DEF;
	}

	var VALUE=ds_map_find_value(global._gmu_lang_font,KEY);
	if(is_string(VALUE)){
		VALUE=real(VALUE);
	}
	return is_real(VALUE) ? VALUE : DEF;
}
