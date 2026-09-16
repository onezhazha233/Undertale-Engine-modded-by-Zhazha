///@arg characters
///@arg char
/// Returns vertical offset
function Typer_CharOffsetY() {
	var CHARS=argument[0];
	var CH=argument[1];

	var DOWN=0;
	var UP=0;

	if(!is_struct(CHARS)){
		return 0;
	}

	if(is_array(CHARS.offsets_y_default)&&array_length(CHARS.offsets_y_default)>=2){
		DOWN=CHARS.offsets_y_default[0];
		UP=CHARS.offsets_y_default[1];
	}

	if(variable_struct_exists(CHARS,"offsets_y")){
		var OFF=CHARS.offsets_y;
		var O=undefined;
		if(variable_struct_exists(OFF,CH)){
			O=OFF[$ CH];
		}else{
			var ORD_KEY="#"+string(ord(CH));
			if(variable_struct_exists(OFF,ORD_KEY)){
				O=OFF[$ ORD_KEY];
			}
		}
		if(is_array(O)&&array_length(O)>=2){
			DOWN=O[0];
			UP=O[1];
		}
	}

	return DOWN-UP;
}
