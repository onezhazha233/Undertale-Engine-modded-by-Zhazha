///@arg group_index
///@arg sound_or_config
///@arg sound*
function Typer_BindVoice() {
	var GI=argument[0];
	var A=argument[1];

	if(is_struct(A)){
		var SNDS=undefined;
		if(variable_struct_exists(A,"sounds")){
			SNDS=A[$ "sounds"];
		}else if(variable_struct_exists(A,"sound")){
			SNDS=A[$ "sound"];
		}
		if(is_array(SNDS)){
			var I=0;
			repeat(array_length(SNDS)){
				_group_voice[GI,I]=SNDS[I];
				I+=1;
			}
		}else if(is_real(SNDS)&&audio_exists(SNDS)){
			_group_voice[GI,0]=SNDS;
		}
		if(variable_struct_exists(A,"stop")){
			if(!variable_instance_exists(id,"_group_voice_stop")||!is_array(_group_voice_stop)){
				_group_voice_stop=[];
			}
			_group_voice_stop[GI]=bool(A[$ "stop"]);
		}
		if(variable_struct_exists(A,"pitch")){
			if(!variable_instance_exists(id,"_group_voice_pitch")||!is_array(_group_voice_pitch)){
				_group_voice_pitch=[];
			}
			_group_voice_pitch[GI]=real(A[$ "pitch"]);
		}
		if(variable_struct_exists(A,"pitch_random")){
			if(!variable_instance_exists(id,"_group_voice_pitch_random")||!is_array(_group_voice_pitch_random)){
				_group_voice_pitch_random=[];
			}
			_group_voice_pitch_random[GI]=real(A[$ "pitch_random"]);
		}
		if(variable_struct_exists(A,"interval")){
			if(!variable_instance_exists(id,"_group_voice_interval")||!is_array(_group_voice_interval)){
				_group_voice_interval=[];
			}
			_group_voice_interval[GI]=real(A[$ "interval"]);
		}
		return;
	}

	var SLOT=0;
	var I=1;
	repeat(argument_count-1){
		var S=argument[I];
		if(is_real(S)&&audio_exists(S)){
			_group_voice[GI,SLOT]=S;
			SLOT+=1;
		}
		I+=1;
	}
}
