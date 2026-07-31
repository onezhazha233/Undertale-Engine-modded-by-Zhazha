///@arg border
function Border_GetName(BORDER) {
	if(BORDER<0||BORDER>=array_length(global._border_types)){
		return "";
	}

	return Lang_GetString(global._border_types[BORDER].name,"unknow_name");
}
