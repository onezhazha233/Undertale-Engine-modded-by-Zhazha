///@arg font_name
function Lang_IsFontExists(KEY){
	var VALUE=ds_map_find_value(global._gmu_lang_font,KEY);
	if(is_string(VALUE)){
		VALUE=real(VALUE);
	}
	return font_exists(is_real(VALUE) ? VALUE : -1);
}
