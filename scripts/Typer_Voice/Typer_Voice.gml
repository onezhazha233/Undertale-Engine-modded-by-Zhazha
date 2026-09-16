///@desc Voice helpers for text_typer

function Typer_VoiceApply() {
	Typer_VoiceStop();
	_voice_mode=0;
	_voice_mode_interval=6;
	_audio_pitch=1;
	_audio_pitch_random=0;
	_voice_stop=true;
	if(_voice<0)return;
	if(variable_instance_exists(id,"_group_voice_interval")&&is_array(_group_voice_interval)&&_voice<array_length(_group_voice_interval)&&_group_voice_interval[_voice]>0){
		_voice_mode=1;
		_voice_mode_interval=_group_voice_interval[_voice];
	}
	if(variable_instance_exists(id,"_group_voice_pitch")&&is_array(_group_voice_pitch)&&_voice<array_length(_group_voice_pitch)&&_group_voice_pitch[_voice]!=0){
		_audio_pitch=_group_voice_pitch[_voice];
	}
	if(variable_instance_exists(id,"_group_voice_pitch_random")&&is_array(_group_voice_pitch_random)&&_voice<array_length(_group_voice_pitch_random)){
		_audio_pitch_random=_group_voice_pitch_random[_voice];
	}
	if(variable_instance_exists(id,"_group_voice_stop")&&is_array(_group_voice_stop)&&_voice<array_length(_group_voice_stop)){
		if(is_bool(_group_voice_stop[_voice])){
			_voice_stop=_group_voice_stop[_voice];
		}
	}
}

function Typer_VoiceStop() {
	if(variable_instance_exists(id,"_voice_loop_snd")&&_voice_loop_snd!=-1){
		audio_stop_sound(_voice_loop_snd);
		_voice_loop_snd=-1;
	}
	_voice_mode_timer=0;
}

function Typer_VoicePlay() {
	if(_voice<0)return -1;
	var sound=-1;
	if(_voice_single>=0&&_voice_single<array_length_2d(_group_voice,_voice)){
		sound=_group_voice[_voice,_voice_single];
	}else{
		sound=_group_voice[_voice,irandom(array_length_2d(_group_voice,_voice)-1)];
	}
	if(!audio_exists(sound))return -1;
	if(_voice_stop)audio_stop_sound(sound);
	var _audio=audio_play_sound(sound,0,false);
	var pitch=_audio_pitch;
	if(_audio_pitch_random!=0){
		pitch=_audio_pitch+random(_audio_pitch_random);
	}
	if(pitch!=1)audio_sound_pitch(_audio,pitch);
	return _audio;
}
