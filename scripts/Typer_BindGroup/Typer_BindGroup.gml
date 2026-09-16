///@arg group_index
///@arg group_key
///@arg fallback*
///@arg fallback_other*
function Typer_BindGroup() {
	var GI=argument[0];
	var GKEY=argument[1];
	var FB=undefined;
	var FB_OTHER=undefined;
	if(argument_count>=3){
		FB=argument[2];
	}
	if(argument_count>=4){
		FB_OTHER=argument[3];
	}

	var FB_GROUP;
	if(argument_count>=4&&!is_struct(FB)){
		FB_GROUP=Typer_BindGroupFallback(FB,FB_OTHER);
	}else{
		FB_GROUP=Typer_BindGroupFallback(FB);
	}

	var LOC=Lang_GetTyper(GKEY,undefined);
	var G=Typer_BindGroupMerge(FB_GROUP,LOC);

	Typer_BindGroupApplyFont(GI,0,G[$ "ascii"]);
	Typer_BindGroupApplyFont(GI,1,G[$ "other"]);

	_group_font_space_y[GI]=0;
	if(variable_struct_exists(G,"space_y")){
		_group_font_space_y[GI]=real(G[$ "space_y"]);
	}

	return is_struct(LOC);
}

///@arg fallback
///@arg fallback_other*
function Typer_BindGroupFallback() {
	var FB=argument[0];
	var OUT={};
	OUT[$ "ascii"]=undefined;
	OUT[$ "other"]=undefined;
	OUT[$ "space_y"]=0;

	if(is_struct(FB)){
		if(variable_struct_exists(FB,"ascii")){
			OUT[$ "ascii"]=FB[$ "ascii"];
		}
		if(variable_struct_exists(FB,"other")){
			OUT[$ "other"]=FB[$ "other"];
		}else if(variable_struct_exists(FB,"ascii")){
			OUT[$ "other"]=FB[$ "ascii"];
		}
		if(variable_struct_exists(FB,"space_y")){
			OUT[$ "space_y"]=real(FB[$ "space_y"]);
		}
		return OUT;
	}

	if(is_real(FB)&&font_exists(FB)){
		var OTHER=FB;
		if(argument_count>=2&&is_real(argument[1])&&font_exists(argument[1])){
			OTHER=argument[1];
		}
		var FACE_A={};
		FACE_A[$ "font"]=FB;
		FACE_A[$ "scale"]=1;
		FACE_A[$ "space_x"]=0;
		var FACE_B={};
		FACE_B[$ "font"]=OTHER;
		FACE_B[$ "scale"]=1;
		FACE_B[$ "space_x"]=0;
		OUT[$ "ascii"]=FACE_A;
		OUT[$ "other"]=FACE_B;
		return OUT;
	}

	return OUT;
}

///@arg fallback_group
///@arg locale_group
function Typer_BindGroupMerge() {
	var FB=argument[0];
	var LOC=argument[1];
	var OUT={};
	var FB_ASCII=undefined;
	var FB_OTHER=undefined;
	var LOC_ASCII=undefined;
	var LOC_OTHER=undefined;
	var SY=0;

	if(is_struct(FB)){
		if(variable_struct_exists(FB,"ascii")){
			FB_ASCII=FB[$ "ascii"];
		}
		if(variable_struct_exists(FB,"other")){
			FB_OTHER=FB[$ "other"];
		}
		if(variable_struct_exists(FB,"space_y")){
			SY=real(FB[$ "space_y"]);
		}
	}
	if(is_struct(LOC)){
		if(variable_struct_exists(LOC,"ascii")){
			LOC_ASCII=LOC[$ "ascii"];
		}
		if(variable_struct_exists(LOC,"other")){
			LOC_OTHER=LOC[$ "other"];
		}
		if(variable_struct_exists(LOC,"space_y")){
			SY=real(LOC[$ "space_y"]);
		}
	}

	OUT[$ "ascii"]=Typer_BindGroupMergeFace(FB_ASCII,LOC_ASCII);
	OUT[$ "other"]=Typer_BindGroupMergeFace(FB_OTHER,LOC_OTHER);
	OUT[$ "space_y"]=SY;
	return OUT;
}

///@arg fallback_face
///@arg locale_face
function Typer_BindGroupMergeFace() {
	var FB=argument[0];
	var LOC=argument[1];
	if(!is_struct(FB)&&!is_struct(LOC)){
		return undefined;
	}

	var OUT={};
	var I=0;
	var NAMES;
	if(is_struct(FB)){
		NAMES=variable_struct_get_names(FB);
		for(I=0;I<array_length(NAMES);I+=1){
			OUT[$ NAMES[I]]=FB[$ NAMES[I]];
		}
	}
	if(is_struct(LOC)){
		NAMES=variable_struct_get_names(LOC);
		for(I=0;I<array_length(NAMES);I+=1){
			OUT[$ NAMES[I]]=LOC[$ NAMES[I]];
		}
	}
	return OUT;
}

///@arg group_index
///@arg face_index
///@arg face_struct
function Typer_BindGroupApplyFont() {
	var GI=argument[0];
	var FI=argument[1];
	var FACE=argument[2];

	if(!is_struct(FACE)){
		_group_font[GI,FI]=-1;
		_group_font_scale_x[GI,FI]=1;
		_group_font_scale_y[GI,FI]=1;
		_group_font_space_x[GI,FI]=0;
		_group_font_chars[GI,FI]=undefined;
		return;
	}

	var FONT=-1;
	if(variable_struct_exists(FACE,"font")){
		var FVAL=FACE[$ "font"];
		if(is_string(FVAL)){
			FONT=Lang_GetFont(FVAL);
		}else if(is_real(FVAL)&&font_exists(FVAL)){
			FONT=FVAL;
		}
	}
	_group_font[GI,FI]=FONT;

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
