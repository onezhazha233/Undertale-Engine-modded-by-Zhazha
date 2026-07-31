function Lang_ClearAudio() {
	while(!ds_map_empty(global._gmu_lang_audio)){
		var KEY=ds_map_find_last(global._gmu_lang_audio);
		var VALUE=ds_map_find_value(global._gmu_lang_audio,KEY);
		ds_map_delete(global._gmu_lang_audio,KEY);
		if(is_string(VALUE)) VALUE=real(VALUE);
		if(is_real(VALUE)&&VALUE>=0&&audio_exists(VALUE)){
			audio_destroy_stream(VALUE);
		}
	}
	ds_map_clear(global._gmu_lang_audio);
	return true;
}
