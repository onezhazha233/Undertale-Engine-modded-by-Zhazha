///@arg characters
///@arg char
///@arg next_char*
/// Returns [before, after, width_add]
function Typer_CharSpacing() {
	var CHARS=argument[0];
	var CH=argument[1];
	var NEXT="";
	if(argument_count>=3){
		NEXT=argument[2];
	}

	var BEFORE=0;
	var AFTER=0;
	var AFTER_SAME=0;
	var WIDTH_ADD=0;

	if(!is_struct(CHARS)){
		return [0,0,0];
	}

	if(is_array(CHARS.offsets_default)&&array_length(CHARS.offsets_default)>=3){
		AFTER=CHARS.offsets_default[0];
		BEFORE=CHARS.offsets_default[1];
		AFTER_SAME=CHARS.offsets_default[2];
	}

	if(variable_struct_exists(CHARS,"offsets")){
		var OFF=CHARS.offsets;
		var O=undefined;
		if(variable_struct_exists(OFF,CH)){
			O=OFF[$ CH];
		}else{
			var ORD_KEY="#"+string(ord(CH));
			if(variable_struct_exists(OFF,ORD_KEY)){
				O=OFF[$ ORD_KEY];
			}
		}
		if(is_array(O)&&array_length(O)>=3){
			AFTER=O[0];
			BEFORE=O[1];
			AFTER_SAME=O[2];
		}
	}

	if(NEXT!=""&&NEXT==CH){
		AFTER=AFTER_SAME;
	}

	if(variable_struct_exists(CHARS,"widths")&&variable_struct_exists(CHARS.widths,CH)){
		WIDTH_ADD=CHARS.widths[$ CH];
	}

	return [BEFORE,AFTER,WIDTH_ADD];
}
