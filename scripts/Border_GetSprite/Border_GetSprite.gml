function Border_GetSprite(BORDER) {
	var sprite=spr_default;

	if(BORDER<0||BORDER>=array_length(global._border_types)){
		return sprite;
	}

	var ENTRY=global._border_types[BORDER];
	if(variable_struct_exists(ENTRY,"dynamic")&&ENTRY.dynamic){
		return border._sprite;
	}
	if(is_real(ENTRY.sprite)&&sprite_exists(ENTRY.sprite)){
		sprite=ENTRY.sprite;
	}
	return sprite;
}
