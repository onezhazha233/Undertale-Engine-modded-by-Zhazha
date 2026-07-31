///@arg group_index
///@arg group_key
function Lang_BindTyperGroup(GI, GKEY) {
	var G=Lang_GetTyper(GKEY);
	if(!is_struct(G)){
		return false;
	}

	Lang_BindTyperFace(GI,0,variable_struct_exists(G,"ascii") ? G[$ "ascii"] : undefined);
	Lang_BindTyperFace(GI,1,variable_struct_exists(G,"other") ? G[$ "other"] : undefined);

	var SY=0;
	if(variable_struct_exists(G,"space_y")){
		SY=real(G[$ "space_y"]);
	}
	_group_font_space_y[GI]=SY;
	return true;
}

///@arg group_index
///@arg face_index
///@arg face_struct
function Lang_BindTyperFace(GI, FI, FACE) {

	if(!is_struct(FACE)){
		_group_font[GI,FI]=-1;
		_group_font_scale_x[GI,FI]=1;
		_group_font_scale_y[GI,FI]=1;
		_group_font_space_x[GI,FI]=0;
		_group_font_chars[GI,FI]=undefined;
		return;
	}

	var FNAME=variable_struct_exists(FACE,"font") ? FACE[$ "font"] : "";
	_group_font[GI,FI]=is_string(FNAME) ? Lang_GetFont(FNAME) : -1;

	var SX=1;
	var SY=1;
	if(variable_struct_exists(FACE,"scale")){
		SX=real(FACE[$ "scale"]);
		SY=SX;
	}
	if(variable_struct_exists(FACE,"scale_x")){
		SX=real(FACE[$ "scale_x"]);
	}
	if(variable_struct_exists(FACE,"scale_y")){
		SY=real(FACE[$ "scale_y"]);
	}
	_group_font_scale_x[GI,FI]=SX;
	_group_font_scale_y[GI,FI]=SY;
	_group_font_space_x[GI,FI]=variable_struct_exists(FACE,"space_x") ? real(FACE[$ "space_x"]) : 0;

	if(variable_struct_exists(FACE,"characters")){
		_group_font_chars[GI,FI]=Lang_ParseTyperCharacters(FACE[$ "characters"]);
	}else{
		_group_font_chars[GI,FI]=undefined;
	}
}
