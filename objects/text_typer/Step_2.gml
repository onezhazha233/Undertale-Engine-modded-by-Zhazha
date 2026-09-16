_voice_played=false;

event_user(4);

if(!_measured&&text!=""){
	var m=Typer_Measure(text);
	_measure_w=m[0];
	_measure_h=m[1];
	height=_measure_h;
	_measured=true;
	Typer_Align();
	if(_mini_auto_layout){
		_mini_positions=Typer_MiniScan(text);
		_mini_pos_index=0;
	}
	if(_callback_start_pend){
		_callback_start_pend=false;
		Typer_Callback(0);
	}
}

var _hold_skip_held=_hold_skip&&Input_IsHeld(INPUT.MENU)&&!_choice_active&&_char_proc<=string_length(text);
if(_hold_skip_held){
	if(_hold_skip_mode==0){
		_skipping=true;
		_sleep=0;
		_char_frame_remain=0;
		if(_paused){
			_hold_skip_timer-=1;
			if(_hold_skip_timer<=0){
				_paused=false;
				_hold_skip_timer=_hold_skip_interval;
			}
		}else{
			_hold_skip_timer=_hold_skip_interval;
		}
	}else{
		_paused=false;
		_sleep=0;
		_char_frame_remain=0;
	}
}else{
	_hold_skip_timer=_hold_skip_interval;
}

if(_skippable&&!_paused&&Input_IsPressed(INPUT.CANCEL)){
	_skipping=true;
	_sleep=0;
	_char_frame_remain=0;
}

Typer_ChoiceStep();

if(_paused&&Input_IsPressed(INPUT.CONFIRM)&&!_choice_active){
	_paused=false;
}

if(_char_proc<string_length(text)+1){
	if(!_paused){
		if(_sleep>0){
			_sleep-=1;
		}else{
			if(_char_frame_remain>0){
				_char_frame_remain-=1;
			}else{
				do{
					var _cpf=_char_per_frame;
					if(_hold_skip_held&&_hold_skip_mode==1){
						_cpf=_hold_skip_speed;
					}
					repeat(_cpf){
						var _choice_collecting=(_choice_dir==3&&_choice_skip_render);
						if(_choice_collecting){
							_sleep=0;
							_char_frame_remain=0;
						}
						var _fast=((_sleep==0||_skipping||_instant||_choice_collecting)&&!_paused&&_char_proc<=string_length(text));
						while((string_char_at(text,_char_proc)=="{"||(!_choice_collecting&&(string_char_at(text,_char_proc)=="\n"||string_char_at(text,_char_proc)=="&"))||(!_choice_collecting&&_skip_space&&(string_char_at(text,_char_proc)==" "||string_char_at(text,_char_proc)=="　")))&&_fast){
							while(string_char_at(text,_char_proc)=="{"&&_fast){
								var cmd_start=_char_proc;
								_char_proc+=1;
								ds_list_clear(_list_cmd);
								var loop=true;
								var cmd="";
								var str_mode=false;
								var str_input=false;
								while(_char_proc<=string_length(text)&&loop){
									var cmd_char=string_char_at(text,_char_proc);
									if((cmd_char==" "||cmd_char=="}")&&!str_input){
										if(cmd!=""){
											if(!str_mode){
												if(!ds_list_empty(_list_cmd)){
													if(variable_struct_exists(_macro,cmd)){
														cmd=_macro[$ cmd];
													}else{
														cmd=real(cmd);
													}
												}
											}
											ds_list_add(_list_cmd,cmd);
										}
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
										var cmd_name=ds_list_empty(_list_cmd) ? "" : _list_cmd[|0];
										if(_choice_dir==3&&_choice_skip_render&&is_string(cmd_name)&&!Typer_ChoiceCmdIsControl(cmd_name)){
											_choice_collect_text+=string_copy(text,cmd_start,_char_proc-cmd_start+1);
										}else{
											event_user(2);
										}
										loop=false;
										_choice_collecting=(_choice_dir==3&&_choice_skip_render);
										_fast=((_sleep==0||_skipping||_instant||_choice_collecting)&&!_paused&&_char_proc<=string_length(text));
									}
									_char_proc+=1;
								}
								if(loop){
									show_debug_message("WARNING! Text typer command is not valid in \""+text+"\"!");
								}
							}
							
							while(!_choice_collecting&&(string_char_at(text,_char_proc)=="\n"||string_char_at(text,_char_proc)=="&")&&_fast){
								event_user(1);
								_char_proc+=1;
							}
							
							while(!_choice_collecting&&_skip_space&&(string_char_at(text,_char_proc)==" "||string_char_at(text,_char_proc)=="　")&&_fast){
								_char=" ";
								event_user(0);
								_char_proc+=1;
							}
							_choice_collecting=(_choice_dir==3&&_choice_skip_render);
							_fast=((_sleep==0||_skipping||_instant||_choice_collecting)&&!_paused&&_char_proc<=string_length(text));
						}
						
						if(_fast){
							_char=string_char_at(text,_char_proc);
							if(_char=="\\"){
								_char_proc+=1;
								_char=string_char_at(text,_char_proc);
							}
							event_user(0);
							if(!(_choice_dir==3&&_choice_skip_render)){
								_char_frame_remain=_speed;
							}
							_char_proc+=1;
						}
					}
				}until(_char_proc>string_length(text)||_paused||(!_skipping&&!_instant&&!(_choice_dir==3&&_choice_skip_render)));
			}
		}
	}
}

if(_voice_mode==1&&_voice>=0){
	var typing=_char_proc<=string_length(text)&&!_paused&&_sleep==0&&!_skipping&&!_instant;
	if(typing){
		_voice_mode_timer-=1;
		if(_voice_mode_timer<=0){
			_voice_mode_timer=_voice_mode_interval;
			_voice_loop_snd=Typer_VoicePlay();
		}
	}else{
		Typer_VoiceStop();
	}
}

if(_char_proc>string_length(text)&&!_callback_end_done){
	_callback_end_done=true;
	Typer_Callback(1);
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
	if(ds_exists(_list_inst,ds_type_list)){
		var proc_f=0;
		repeat(ds_list_size(_list_inst)){
			var INST_F=ds_list_find_value(_list_inst,proc_f);
			if(instance_exists(INST_F)){
				var rot_f=RotateXY(x+INST_F._deltaX,y+INST_F._deltaY,x,y,_angle);
				INST_F.x=rot_f[0];
				INST_F.y=rot_f[1];
				if(_angle_follow){
					INST_F.angle=_angle;
				}
			}
			proc_f+=1;
		}
	}
}

_time+=1;
var ti=0;
repeat(10){
	torder[ti]=_time*9+ti*36;
	ti+=1;
}
