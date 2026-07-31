///@arg border
function Border_IsDynamic(BORDER) {
	if(BORDER<0||BORDER>=array_length(global._border_types)){
		return false;
	}

	var ENTRY=global._border_types[BORDER];
	return variable_struct_exists(ENTRY,"dynamic")&&ENTRY.dynamic;
}
