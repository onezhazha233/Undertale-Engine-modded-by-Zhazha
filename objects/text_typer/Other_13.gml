///@desc Clear
var is_mini=variable_instance_exists(id,"_is_mini")&&_is_mini;
var clearing=variable_instance_exists(id,"_clearing")&&_clearing;
if(!clearing&&!is_mini){
	Typer_Callback(1);
}
Typer_VoiceStop();
_char_x=_align_offset_x;
_char_y=_align_offset_y;
_line=0;
_line_char_count=0;
width=0;
height=0;

if(variable_instance_exists(id,"_list_inst")&&ds_exists(_list_inst,ds_type_list)){
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			instance_destroy(INST);
		}
		proc+=1;
	}
	ds_list_clear(_list_inst);
}

if(!is_mini&&variable_instance_exists(id,"_list_mini")&&ds_exists(_list_mini,ds_type_list)){
	var mi=0;
	repeat(ds_list_size(_list_mini)){
		var MINST=ds_list_find_value(_list_mini,mi);
		if(instance_exists(MINST)){
			instance_destroy(MINST);
		}
		mi+=1;
	}
	ds_list_clear(_list_mini);
}

if(!is_mini){
	Typer_ChoiceDestroyChildren();
}

if(!clearing&&!is_mini){
	_segment_index+=1;
	_callback_end_done=false;
	Typer_Callback(0);
}
