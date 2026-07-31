///@arg audio_name
function Lang_IsAudioExists(KEY) {
	var VALUE=ds_map_find_value(global._gmu_lang_audio,KEY);
	if(is_string(VALUE)) VALUE=real(VALUE);
	return audio_exists(is_real(VALUE) ? VALUE : -1);
}
