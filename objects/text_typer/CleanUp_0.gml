text="";

event_user(3);

if(_voice_loop_snd!=-1){
	audio_stop_sound(_voice_loop_snd);
	_voice_loop_snd=-1;
}

if(instance_exists(_face)){
	instance_destroy(_face);
}

ds_list_destroy(_list_inst);
ds_list_destroy(_list_cmd);
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

surface_free(_surface)