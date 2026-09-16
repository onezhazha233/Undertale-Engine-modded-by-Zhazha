text="";

Typer_VoiceStop();

if(variable_instance_exists(id,"_list_inst")&&ds_exists(_list_inst,ds_type_list)){
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			instance_destroy(INST);
		}
		proc+=1;
	}
	ds_list_destroy(_list_inst);
}

if(instance_exists(_face)){
	instance_destroy(_face);
	_face=noone;
}

if(variable_instance_exists(id,"_list_cmd")&&ds_exists(_list_cmd,ds_type_list)){
	ds_list_destroy(_list_cmd);
}

if(variable_instance_exists(id,"_list_mini")&&ds_exists(_list_mini,ds_type_list)){
	var mi=0;
	repeat(ds_list_size(_list_mini)){
		var MINST=ds_list_find_value(_list_mini,mi);
		if(instance_exists(MINST)){
			instance_destroy(MINST);
		}
		mi+=1;
	}
	ds_list_destroy(_list_mini);
}

if(variable_instance_exists(id,"_list_choice")&&ds_exists(_list_choice,ds_type_list)){
	Typer_ChoiceDestroyChildren();
	ds_list_destroy(_list_choice);
}

if(variable_instance_exists(id,"_surface")&&surface_exists(_surface)){
	surface_free(_surface);
	_surface=-1;
}
