///@arg sprite_name
function Lang_IsSpriteExists(KEY){
	var VALUE=ds_map_find_value(global._gmu_lang_sprite,KEY);
	if(is_string(VALUE)) VALUE=real(VALUE);
	return sprite_exists(is_real(VALUE) ? VALUE : -1);
}
