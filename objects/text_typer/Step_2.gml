_voice_played=false;

event_user(4);

if(!_text_measured&&text!=""){
	var m=Measure(text);
	_measure_w=m[0];
	_measure_h=m[1];
	_text_measured=true;
	AlignApply();
	if(_mini_auto_layout){
        _mini_positions=ScanMinis(text);
        _mini_pos_index=0;
    }
}

if(_paused&&Input_IsPressed(INPUT.CONFIRM)&&!_choice_active){
	_paused=false;
}
if(_skip&&_skip_enabled&&!_paused&&Input_IsPressed(INPUT.CANCEL)){
	_skipping=true;
	_sleep=0;
	_char_frame_remain=0;
}

if(_skip&&_super_skip&&Input_IsHeld(INPUT.MENU)&&!_choice_active&&_char_proc<=string_length(text)){
	if(_super_skip_mode==0){
		_paused=false;
		_skipping=true;
		_sleep=0;
		_char_frame_remain=0;
	}else{
		_paused=false;
		_sleep=0;
		_char_frame_remain=0;
	}
}
ChoiceStep();

if(_char_proc<string_length(text)+1){
	if(!_paused){
		if(_sleep>0){
			_sleep-=1;
		}else{
			if(_char_frame_remain>0){
				_char_frame_remain-=1;
			}else{
				do{
					repeat(_char_per_frame){
						while((string_char_at(text,_char_proc)=="{"||string_char_at(text,_char_proc)=="&"||(_skip_space&&(string_char_at(text,_char_proc)==" "||string_char_at(text,_char_proc)=="　")))&&((_sleep==0||_skipping||_instant)&&!_paused&&_char_proc<=string_length(text))){
							while(string_char_at(text,_char_proc)=="{"&&((_sleep==0||_skipping||_instant)&&!_paused&&_char_proc<=string_length(text))){
								_char_proc+=1;
								ds_list_clear(_list_cmd);
								var loop=true;
								var cmd="";
								var str_mode=false;
								var str_input=false;
								while(_char_proc<=string_length(text)&&loop){
									var cmd_char=string_char_at(text,_char_proc);
									if((cmd_char==" "||cmd_char=="}")&&!str_input){
										if(!str_mode){
											if(!ds_list_empty(_list_cmd)){
												if(variable_struct_exists(_map_macro,cmd)){
													cmd=_map_macro[$ cmd];
												}else{
													cmd=real(cmd);
												}
											}
										}
										ds_list_add(_list_cmd,cmd);
										str_mode=false;
										str_input=false;
										cmd="";
									}else if(cmd_char=="`"){
										str_mode=true;
										str_input=!str_input;
									}else{
										if(!str_mode||(str_mode&&str_input)){
											if(cmd_char=="\\"){
												_char_proc+=1;
												cmd_char=string_char_at(text,_char_proc);
											}
											cmd+=cmd_char;
										}
									}
									if(cmd_char=="}"&&!str_input){
										event_user(2);
										loop=false;
									}
									_char_proc+=1;
								}
								if(loop){
									show_debug_message("WARNING! Text typer command is not valid in \""+text+"\"!");
								}
							}
							
							while(string_char_at(text,_char_proc)=="&"&&((_sleep==0||_skipping||_instant)&&!_paused&&_char_proc<=string_length(text))){
								event_user(1);
								_char_proc+=1;
							}
							
							while(_skip_space&&(string_char_at(text,_char_proc)==" "||string_char_at(text,_char_proc)=="　")&&((_sleep==0||_skipping||_instant)&&!_paused&&_char_proc<=string_length(text))){
								_char=" ";
								event_user(0);
								_char_proc+=1;
							}
						}
						
						if((_sleep==0||_skipping||_instant)&&!_paused&&_char_proc<=string_length(text)){
							_char=string_char_at(text,_char_proc);
							if(_char=="\\"){
								_char_proc+=1;
								_char=string_char_at(text,_char_proc);
							}
							event_user(0);
							_char_frame_remain=_speed;
							_char_proc+=1;
						}
					}
				}until(_char_proc>string_length(text)||_paused||(!_skipping&&!_instant));
			}
		}
	}
}

if(_auto_destroy&&_char_proc>string_length(text)){
	if(_auto_destroy_timer==-1){
		_auto_destroy_timer=_auto_destroy_delay;
	}
	if(_auto_destroy_timer>0){
		_auto_destroy_timer-=1;
	}else{
		instance_destroy();
	}
}

if(_char_proc>string_length(text)&&!_end_callback_fired){
	_end_callback_fired=true;
	TriggerCallback(1);
}

if(instance_exists(_face)){
	_face.gui=_gui;
	_face.depth=depth;
	if(variable_instance_exists(id,"_is_mini")&&_is_mini){
		_face.talking=false;
	}else{
		_face.talking=(!_sleep&&!_paused&&_char_proc<=string_length(text));
	}
	if(override_alpha_enabled){
		_face.image_alpha=override_alpha;
	}
}

if(_face_linked!=-1){
	if(instance_exists(face)){
		var fid=_face_linked;
		var ftalking=(!_sleep&&!_paused&&_char_proc<=string_length(text));
		with(face){
			if(face_id==fid){
				talking=ftalking;
			}
		}
	}
}

if(_char_linked!=-1){
	if(instance_exists(char)){
		var cid=_char_linked;
		var ctalking=(!_sleep&&!_paused&&_char_proc<=string_length(text));
		with(char){
			if(char_id==cid){
				talking=ctalking;
			}
		}
	}
}

if(override_alpha_enabled||override_color_text_enabled){
	if(!ds_exists(_list_inst,ds_type_list)) exit;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			if(override_alpha_enabled){
				INST.alpha=override_alpha;
			}
			if(override_color_text_enabled){
				if(is_array(override_color_text)){
					INST.color_text[0]=override_color_text[0];
					INST.color_text[1]=override_color_text[1];
					INST.color_text[2]=override_color_text[2];
					INST.color_text[3]=override_color_text[3];
				}else{
					INST.color_text[0]=override_color_text;
					INST.color_text[1]=override_color_text;
					INST.color_text[2]=override_color_text;
					INST.color_text[3]=override_color_text;
				}
			}
		}
		proc+=1;
	}
}

if(_position_follow||_angle_follow){
	if(!ds_exists(_list_inst,ds_type_list)) exit;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			var rot=RotateXY(x+INST._deltaX, y+INST._deltaY, x, y, _angle);
			INST.x=rot[0];
			INST.y=rot[1];
			if(_angle_follow){
				INST.angle=_angle;
			}
		}
		proc+=1;
	}
}

_time+=1;

for(_i=0;_i<10;_i+=1){
	torder[_i]=_time*9+_i*36;
}

if(_voice_mode==1&&_voice>=0){
	var typing=_char_proc<=string_length(text)&&!_paused&&_sleep==0&&!_skipping&&!_instant;
	if(typing){
		_voice_mode_timer-=1;
		if(_voice_mode_timer<=0){
			_voice_mode_timer=_voice_mode_interval;
			var sound_index=-1;
			if(_voice_single>=0&&_voice_single<array_length(_group_voice[_voice])){
				sound_index=_voice_single;
			}else{
				sound_index=irandom(array_length(_group_voice[_voice])-1);
			}
			var sound=_group_voice[_voice,sound_index];
			if(audio_exists(sound)){
				if(_group_voice_stop[_voice,sound_index]){
					audio_stop_sound(sound);
				}
				_voice_loop_snd=audio_play_sound(sound,0,false);
				var _pitch=_audio_pitch;
				if(is_method(_pitch)){
					_pitch=_pitch();
				}
				if(_super_skip&&_super_skip_mode==1&&Input_IsHeld(INPUT.MENU)){
					_pitch+=0.3;
				}
				if(_pitch!=1){
					audio_sound_pitch(_voice_loop_snd,_pitch);
				}
			}
		}
	}else{
		_voice_mode_timer=0;
		if(_voice_loop_snd!=-1){
			audio_stop_sound(_voice_loop_snd);
			_voice_loop_snd=-1;
		}
	}
}