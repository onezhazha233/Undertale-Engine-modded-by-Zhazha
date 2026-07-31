///@desc Clear
if(!_clearing_for_new_text){
    TriggerCallback(1);
}
_char_x=_align_offset_x;
_char_y=_align_offset_y;
_line=0;
_last_aligned_line=-1;
_line_char_count=0;

if(ds_exists(_list_inst,ds_type_list)){
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
if(!_clearing_for_new_text){
    _segment_index+=1;
    _end_callback_fired=false;
    TriggerCallback(0);
}

var is_mini=variable_instance_exists(id,"_is_mini")&&_is_mini;
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