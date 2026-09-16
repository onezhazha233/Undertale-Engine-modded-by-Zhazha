///@desc Command
var cmd=_list_cmd;

switch(cmd[|0]){
	case "speed":
		if(is_real(cmd[|1])){
			if(cmd[|1]>=0){
				_speed=cmd[|1];
			}
		}
		break;
		
	case "color": // {color `name`} preset white/yellow/red/black...
		if(is_string(cmd[|1])){
			var color=GetColorFromString(cmd[|1]);
			switch(color){
				case c_white:
					_color_text[0]=c_white;
					_color_text[1]=c_white;
					_color_text[2]=c_white;
					_color_text[3]=c_white;
					_color_shadow[0]=make_color_rgb(49,49,79);
					_color_shadow[1]=make_color_rgb(49,49,79);
					_color_shadow[2]=make_color_rgb(15,15,115);
					_color_shadow[3]=make_color_rgb(15,15,115);
					break;
					
				case c_yellow:
					_color_text[0]=make_color_rgb(255,255,195);
					_color_text[1]=make_color_rgb(255,255,195);
					_color_text[2]=make_color_rgb(255,255,60);
					_color_text[3]=make_color_rgb(255,255,60);
					_color_shadow[0]=make_color_rgb(76,76,0);
					_color_shadow[1]=make_color_rgb(76,76,0);
					_color_shadow[2]=make_color_rgb(76,76,0);
					_color_shadow[3]=make_color_rgb(76,76,0);
					break;
					
				case c_red:
					_color_text[0]=make_color_rgb(255,195,195);
					_color_text[1]=make_color_rgb(255,195,195);
					_color_text[2]=make_color_rgb(255,60,60);
					_color_text[3]=make_color_rgb(255,60,60);
					_color_shadow[0]=make_color_rgb(76,0,0);
					_color_shadow[1]=make_color_rgb(76,0,0);
					_color_shadow[2]=make_color_rgb(76,0,0);
					_color_shadow[3]=make_color_rgb(76,0,0);
					break;
					
				case c_black:
					_color_text[0]=make_color_rgb(0,0,0);
					_color_text[1]=make_color_rgb(0,0,0);
					_color_text[2]=make_color_rgb(0,0,0);
					_color_text[3]=make_color_rgb(0,0,0);
					_color_shadow[0]=make_color_rgb(0,0,0);
					_color_shadow[1]=make_color_rgb(0,0,0);
					_color_shadow[2]=make_color_rgb(0,0,0);
					_color_shadow[3]=make_color_rgb(0,0,0);
					break;
			}
		}
		break;
		
	case "color_text": // {color_text `name`} solid fill  {color_text a b c d} vertical blend, top to bottom
		var ARGC=ds_list_size(cmd)-1;
		if(ARGC==1||ARGC==4){
			var proc=0;
			repeat(ARGC){
				var color=c_white;
				if(is_string(cmd[|proc+1])){
					color=GetColorFromString(cmd[|proc+1]);
				}else if(is_real(cmd[|proc+1])){
					color=cmd[|proc+1];
				}
				if(ARGC==1){
					_color_text[0]=color;
					_color_text[1]=color;
					_color_text[2]=color;
					_color_text[3]=color;
				}else{
					_color_text[proc]=color;
					proc+=1;
				}
			}
		}
		break;
		
	case "color_shadow":
		var ARGC=ds_list_size(cmd)-1;
		if(ARGC==1||ARGC==4){
			var proc=0;
			repeat(ARGC){
				var color=c_white;
				if(is_string(cmd[|proc+1])){
					color=GetColorFromString(cmd[|proc+1]);
				}else if(is_real(cmd[|proc+1])){
					color=cmd[|proc+1];
				}
				if(ARGC==1){
					_color_shadow[0]=color;
					_color_shadow[1]=color;
					_color_shadow[2]=color;
					_color_shadow[3]=color;
				}else{
					_color_shadow[proc]=color;
					proc+=1;
				}
			}
		}
		break;
		
	case "color_outline":
		var ARGC=ds_list_size(cmd)-1;
		if(ARGC==1||ARGC==4){
			var proc=0;
			repeat(ARGC){
				var color=c_white;
				if(is_string(cmd[|proc+1])){
					color=GetColorFromString(cmd[|proc+1]);
				}else if(is_real(cmd[|proc+1])){
					color=cmd[|proc+1];
				}
				if(ARGC==1){
					_color_outline[0]=color;
					_color_outline[1]=color;
					_color_outline[2]=color;
					_color_outline[3]=color;
				}else{
					_color_outline[proc]=color;
					proc+=1;
				}
			}
		}
		break;
		
	case "shadow":
		if(is_bool(cmd[|1])){
			_shadow=cmd[|1];
		}
		break;
		
	case "outline":
		if(is_bool(cmd[|1])){
			_outline=cmd[|1];
		}
		break;
		
	case "shadow_pos":
		if(is_real(cmd[|1])){
			_shadow_x=cmd[|1];
			_shadow_y=cmd[|1];
		}
		break;
		
	case "shadow_x":
		if(is_real(cmd[|1])){
			_shadow_x=cmd[|1];
		}
		break;
		
	case "shadow_y":
		if(is_real(cmd[|1])){
			_shadow_y=cmd[|1];
		}
		break;
		
	case "alpha":
		if(is_real(cmd[|1])){
			_alpha=cmd[|1];
		}
		break;
		
	case "alpha_text":
		if(is_real(cmd[|1])){
			_alpha_text=cmd[|1];
		}
		break;
		
	case "alpha_shadow":
		if(is_real(cmd[|1])){
			_alpha_shadow=cmd[|1];
		}
		break;
		
	case "alpha_outline":
		if(is_real(cmd[|1])){
			_alpha_outline=cmd[|1];
		}
		break;
		
	case "sleep": // {sleep n} wait n frames (~n/30 s at 30fps)
		if(is_real(cmd[|1])&&!_skipping&&!_instant){
			if(cmd[|1]>=0){
				_sleep=cmd[|1];
			}
		}
		break;
	
	case "pause":
		_paused=true;
		_skipping=false;
		_sleep=0;
		_char_frame_remain=0;
		break;
		
	case "instant":
		if(is_bool(cmd[|1])){
			_instant=bool(cmd[|1]);
		}
		break;
		
	case "skippable":
		if(is_bool(cmd[|1])){
			_skippable=bool(cmd[|1]);
		}
		break;
		
	case "voice": // {voice n} voice group  {voice -1} mute
		if(is_real(cmd[|1])){
			if(cmd[|1]==-1 || (cmd[|1]>=0 && cmd[|1]<array_height_2d(_group_voice))){
				_voice=cmd[|1];
				Typer_VoiceApply();
			}
		}
		break;
		
	case "voice_single": // {voice_single n} slot in current group  {voice_single -1} random
		if(is_real(cmd[|1])){
			if(cmd[|1]==-1 || cmd[|1]>=0 && cmd[|1]<array_length_2d(_group_voice,_voice)){
				_voice_single=cmd[|1];
			}
		}
		break;

	case "voice_mode_interval":
		if(is_real(cmd[|1])&&cmd[|1]>0){
			_voice_mode=1;
			_voice_mode_interval=cmd[|1];
		}
		break;

	case "pitch":
		if(is_real(cmd[|1])){
			_audio_pitch=cmd[|1];
			_audio_pitch_random=0;
		}
		break;
		
	case "font": // {font n} font group
		if(is_real(cmd[|1])){
			if(cmd[|1]>=0&&cmd[|1]<array_height_2d(_group_font)){
				_font=cmd[|1];
			}
		}
		break;
		
	case "clear":
		event_user(3);
		var remaining=string_copy(text,_char_proc,string_length(text)-_char_proc+1);
		var m_clear=Typer_Measure(remaining,_font,_scale_x,_scale_y,_space_x,_space_y);
		_measure_w=m_clear[0];
		_measure_h=m_clear[1];
		height=_measure_h;
		_measured=true;
		Typer_Align();
		if(_mini_auto_layout){
			_mini_positions=Typer_MiniScan(remaining);
			_mini_pos_index=0;
		}
		break;
		
	case "end":
		instance_destroy();
		break;
	
	case "scale":
		if(is_real(cmd[|1])){
			_scale_x=cmd[|1];
			_scale_y=cmd[|1];
		}
		break;
	
	case "scale_x":
		if(is_real(cmd[|1])){
			_scale_x=cmd[|1];
		}
		break;
		
	case "scale_y":
		if(is_real(cmd[|1])){
			_scale_y=cmd[|1];
		}
		break;
		
	case "space_x":
		if(is_real(cmd[|1])){
			_space_x=cmd[|1];
		}
		break;
		
	case "space_y":
		if(is_real(cmd[|1])){
			_space_y=cmd[|1];
		}
		break;
	
	case "define": // {define `NAME` value} then {insert NAME}
		if(is_string(cmd[|1])&&(is_real(cmd[|2])||is_string(cmd[|2]))){
			variable_struct_remove(_macro,cmd[|1]);
			_macro[$ cmd[|1]]=cmd[|2];
		}
		break;
		
	case "undefine":
		if(is_string(cmd[|1])){
			variable_struct_remove(_macro,cmd[|1]);
		}
		break;

	case "gold":
		if(is_real(cmd[|1])){
			Player_SetGold(Player_GetGold()+cmd[|1]);
			variable_struct_remove(_macro,"GOLD");
			_macro[$ "GOLD"]=cmd[|1];
		}
		break;
		
	case "insert": // {insert NAME} expand macro, or insert literal
		if(is_real(cmd[|1])||is_string(cmd[|1])){
			text=string_insert(string(cmd[|1]),text,_char_proc+1);
		}
		break;
		
	case "choice": // {choice n} register slot  {choice `NAME`} / {choice} activate; dir 3 absorbs following text as option
		if(is_real(cmd[|1])){
			if(cmd[|1]>=0){
				Typer_ChoiceRegister(cmd[|1]);
			}
		}else if(is_string(cmd[|1])||is_undefined(cmd[|1])){
			_choice_macro=cmd[|1];
			Typer_ChoiceActivate();
		}
		break;

	case "choice_end":
		Typer_ChoiceActivate();
		break;

	case "choice_default": // {choice_default n} start on slot n  {choice_default -1} center, unselected
		if(is_real(cmd[|1])){
			_choice_default=cmd[|1];
		}
		break;

	case "choice_anim":
		if(is_bool(cmd[|1])){
			_choice_anim=bool(cmd[|1]);
		}
		break;

	case "choice_center": // {choice_center} dialog center  {choice_center x y} manual offset
		if(is_real(cmd[|1])&&is_real(cmd[|2])){
			_choice_cx=cmd[|1];
			_choice_cy=cmd[|2];
			_choice_center_manual=true;
		}else{
			Typer_ChoiceSetCenterDefault();
		}
		break;

	case "choice_dir": // {choice_dir n} 0 left-right, 1 up-down, 2 grid, 3 compass (slots 0 up, 1 left, 2 right, 3 down)
		if(is_real(cmd[|1])){
			_choice_dir=cmd[|1];
		}
		break;

	case "choice_switch_snd":
		if(is_bool(cmd[|1])){
			_choice_switch_snd=bool(cmd[|1]);
		}
		break;

	case "choice_confirm_snd":
		if(is_bool(cmd[|1])){
			_choice_confirm_snd=bool(cmd[|1]);
		}
		break;

	case "position_follow":
		if(is_bool(cmd[|1])){
			_position_follow=bool(cmd[|1]);
		}
		break;

	case "angle_follow":
		if(is_bool(cmd[|1])){
			_angle_follow=bool(cmd[|1]);
		}
		break;

	case "hold_skip": // {hold_skip false} disable hold-MENU fast-forward
		if(is_bool(cmd[|1])){
			_hold_skip=bool(cmd[|1]);
		}
		break;

	case "halign": // {halign n} 0 left, 1 center, 2 right
		if(is_real(cmd[|1])){
			if(cmd[|1]>=0&&cmd[|1]<=2){
				_halign=cmd[|1];
				Typer_Align();
			}
		}
		break;

	case "valign": // {valign n} 0 top, 1 middle, 2 bottom
		if(is_real(cmd[|1])){
			if(cmd[|1]>=0&&cmd[|1]<=2){
				_valign=cmd[|1];
				Typer_Align();
			}
		}
		break;

	case "per_line_align": // {per_line_align false} align as block; true aligns each line
		if(is_bool(cmd[|1])){
			_per_line_align=bool(cmd[|1]);
			Typer_Align();
		}
		break;

	case "char_per_frame":
		if(is_real(cmd[|1])){
			if(cmd[|1]>=0){
				_char_per_frame=cmd[|1];
			}
		}
		break;

	case "auto_destroy":
		if(is_real(cmd[|1])){
			alarm[0]=cmd[|1];
		}
		break;

	case "angle":
		if(is_real(cmd[|1])){
			_angle=cmd[|1];
		}
		break;
	
	case "if": // {if a op b `yes` else `no`} insert first branch when true
		var target_0=cmd[|1];
		var operator=cmd[|2];
		var target_1=cmd[|3];
		var insert_0=cmd[|4];
		var else_indicator=cmd[|5];
		var insert_1=cmd[|6];
		var result=true;
		
		target_0=(is_bool(target_0) ? real(target_0) : target_0);
		target_1=(is_bool(target_1) ? real(target_1) : target_1);
		
		if(((is_string(target_0)&&is_string(target_1))||(is_real(target_0)&&is_real(target_1)))&&(is_string(insert_0)||is_real(insert_0))&&((is_string(else_indicator)&&(is_string(insert_1)||is_real(insert_1)))||is_undefined(else_indicator))){
			if(operator=="=="){
				result=(target_0==target_1);
			}else if(operator=="!="){
				result=(target_0!=target_1);
			}else if(operator==">"){
				result=(target_0>target_1);
			}else if(operator==">="){
				result=(target_0>=target_1);
			}else if(operator=="<"){
				result=(target_0<target_1);
			}else if(operator=="<="){
				result=(target_0<=target_1);
			}else{
				break;
			}
			
			if(result){
				text=string_insert(string(insert_0),text,_char_proc+1);
			}else if(is_string(else_indicator)){
				if(else_indicator=="else"){
					text=string_insert(string(insert_1),text,_char_proc+1);
				}
			}
		}
		break;
		
	case "face": // {face n} attach face group  {face -1} remove
		if(is_real(cmd[|1])){
			var fface=cmd[|1];
			if(fface==-1){
				if(instance_exists(_face)){
					instance_destroy(_face);
					_face=noone;
					x-=58*_scale_x;
					event_user(4);
				}
			}else if(fface>=0 && fface<array_length_1d(_group_face)){
				if(instance_exists(_face)){
					instance_destroy(_face);
				}else{
					x+=58*_scale_x;
					event_user(4);
				}
				_face=instance_create_depth(x-35*_scale_x,y+25*_scale_y,depth,_group_face[fface]);
				_face.gui=_gui;
				_face.image_xscale=_scale_x;
				_face.image_yscale=_scale_y;
			}
		}
		break;
		
	case "face_emotion": // {face_emotion n} set emotion on attached / linked face
		if(is_real(cmd[|1])){
			var femotion=cmd[|1];
			
			if(instance_exists(_face)){
				_face.emotion=femotion;
			}
			
			if(_face_linked!=-1){
				if(instance_exists(face)){
					var fid=_face_linked;
					with(face){
						if(face_id==fid){
							emotion=femotion;
						}
					}
				}
			}
		}
		break;
		
	case "face_link": // {face_link id} bind overworld face by face_id
		if(is_real(cmd[|1])){
			_face_linked=cmd[|1];
		}
		break;
		
	case "face_unlink":
		_face_linked=-1;
		break;
		
	case "effect": // {effect n} enable effect  {effect -1} off
		if(is_real(cmd[|1])){
			if(cmd[|1]>=-1){
				_effect=cmd[|1];
			}
		}
		break;
		
	case "depth":
		if(is_real(cmd[|1])){
			depth=cmd[|1];
		}
		break;
		
	case "gui":
		if(is_bool(cmd[|1])){
			_gui=cmd[|1];
		}
		break;
		
	case "sound": // {sound `asset`} play SFX once
		var target=-1;
		if(is_real(cmd[|1])){
			target=cmd[|1];
		}else{
			target=asset_get_index(cmd[|1]);
		}
		if(audio_exists(target)){
			audio_play_sound(target,0,false);
		}
		break;
		
	case "script": // {script `name` …} call script with optional args
		var target=-1;
		if(is_real(cmd[|1])){
			target=cmd[|1];
		}else{
			target=asset_get_index(cmd[|1]);
		}
		if(script_exists(target)){
			switch(ds_list_size(cmd)-2){
				case 0:
					script_execute(target);
					break;
				case 1:
					script_execute(target,cmd[|2]);
					break;
				case 2:
					script_execute(target,cmd[|2],cmd[|3]);
					break;
				case 3:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4]);
					break;
				case 4:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5]);
					break;
				case 5:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6]);
					break;
				case 6:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7]);
					break;
				case 7:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8]);
					break;
				case 8:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9]);
					break;
				case 9:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10]);
					break;
				case 10:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10],cmd[|11]);
					break;
				case 11:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10],cmd[|11],cmd[|12]);
					break;
				case 12:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10],cmd[|11],cmd[|12],cmd[|13]);
					break;
				case 13:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10],cmd[|11],cmd[|12],cmd[|13],cmd[|14]);
					break;
				case 14:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10],cmd[|11],cmd[|12],cmd[|13],cmd[|14],cmd[|15]);
					break;
				case 15:
					script_execute(target,cmd[|2],cmd[|3],cmd[|4],cmd[|5],cmd[|6],cmd[|7],cmd[|8],cmd[|9],cmd[|10],cmd[|11],cmd[|12],cmd[|13],cmd[|14],cmd[|15],cmd[|16]);
					break;
			}
		}
		break;
		
	case "char_link": // {char_link id} bind char_id; talks while typing
		if(is_real(cmd[|1])){
			_char_linked=cmd[|1];
		}
		break;
	
	case "char_unlink":
		_char_linked=-1;
		break;
		
	case "char_dir": // {char_dir id DIR.*} set facing
		if(is_real(cmd[|1])&&is_real(cmd[|2])){
			if(instance_exists(char)){
				var cid=cmd[|1];
				var cdir=cmd[|2];
				with(char){
					if(char_id==cid){
						dir=cdir;
					}
				}
			}
		}
		break;
		
	case "char_move": // {char_move id DIR.* n} set walk on axis
		if(is_real(cmd[|1])&&is_real(cmd[|2])&&is_real(cmd[|3])){
			if(instance_exists(char)){
				var cid=cmd[|1];
				var cdir=cmd[|2];
				var cmove=cmd[|3];
				with(char){
					if(char_id==cid){
						move[cdir]=cmove;
					}
				}
			}
		}
		break;
		
	case "char_player_moveable":
		if(is_real(cmd[|1])){
			if(instance_exists(char_player)){
				char_player.moveable=cmd[|1];
			}
		}
		break;
		
	case "sprite": // {sprite `name` spd img xoff yoff}
		var spr=cmd[|1];
		if(is_string(spr)){
			spr=asset_get_index(spr);
		}
		if(is_real(spr)){
			if(sprite_exists(spr)){
				var spd=1;
				if(is_real(cmd[|2])){
					spd=cmd[|2];
				}
				var img=0;
				if(is_real(cmd[|3])){
					img=cmd[|3];
				}
				var offx=0;
				if(is_real(cmd[|4])){
					offx=cmd[|4];
				}
				var offy=0;
				if(is_real(cmd[|5])){
					offy=cmd[|5];
				}
				_char_sprite=spr;
				_char_sprite_image=img;
				_char_sprite_speed=spd;
				_char_sprite_offset_x=offx;
				_char_sprite_offset_y=offy;
				_char="";
				event_user(0);
				_char_sprite=-1;
				_char_sprite_image=0;
				_char_sprite_speed=1;
				_char_sprite_offset_x=0;
				_char_sprite_offset_y=0;
			}
		}
		break;
		
	case "skip_space":
		if(is_bool(cmd[|1])){
			_skip_space=cmd[|1];
		}
		break;

	case "mini_auto_layout":
		if(is_bool(cmd[|1])){
			_mini_auto_layout=cmd[|1];
			if(!_mini_auto_layout){
				_mini_positions=[];
				_mini_pos_index=0;
			}
		}
		break;

	case "mini_align":
		if(is_real(cmd[|1])){
			_mini_align=cmd[|1];
		}
		break;

	case "mini_left":
		if(is_real(cmd[|1])){
			_mini_left=cmd[|1];
		}
		break;

	case "mini_right":
		if(is_real(cmd[|1])){
			_mini_right=cmd[|1];
		}
		break;

	case "mini": // {mini `text`}  {mini `text` face emotion} optional face group + emotion
		if(variable_instance_exists(id,"_is_mini")&&_is_mini)break;
		if(ds_list_size(cmd)<2)break;
		var mtxt=cmd[|1];
		if(!is_string(mtxt))mtxt=string(mtxt);
		var mface=-1;
		var memo=0;
		var mfont=_font;
		var mox=0;
		var moy=0;
		if(ds_list_size(cmd)>2&&is_real(cmd[|2]))mface=cmd[|2];
		if(ds_list_size(cmd)>3&&is_real(cmd[|3]))memo=cmd[|3];
		if(ds_list_size(cmd)>4&&is_real(cmd[|4]))mfont=cmd[|4];
		if(ds_list_size(cmd)>5&&is_real(cmd[|5]))mox=cmd[|5];
		if(ds_list_size(cmd)>6&&is_real(cmd[|6]))moy=cmd[|6];
		if(mfont<0||mfont>=array_height_2d(_group_font))mfont=_font;

		var mw=0;
		var mscale=_scale_x*0.5;
		if(mtxt!=""){
			var mm=Typer_Measure(mtxt,mfont,mscale,mscale,0,0);
			mw=mm[0];
		}
		var left_edge=x+_mini_left+mox;
		var right_edge=x+_mini_right+mox;
		var my=y+28*_scale_y+moy;
		var slide=24;

		var use_prescan=_mini_auto_layout&&_mini_pos_index<array_length(_mini_positions);
		var mx;
		if(use_prescan){
			mx=_mini_positions[_mini_pos_index];
			_mini_pos_index+=1;
		}else if(_mini_align==0){
			mx=left_edge;
		}else{
			mx=right_edge-mw;
		}

		if(!variable_instance_exists(id,"_list_mini"))_list_mini=ds_list_create();
		var gui_str=_gui ? "true" : "false";
		var prefix="{instant true}{skippable false}{voice -1}{shadow false}";
		prefix+="{gui "+gui_str+"}";
		prefix+="{depth "+string(depth-1)+"}";
		prefix+="{font "+string(mfont)+"}";
		prefix+="{scale "+string(mscale)+"}";

		var mini=instance_create_depth(mx+slide,my,depth-1,text_typer);
		mini._is_mini=true;
		mini.override_alpha_enabled=true;
		mini.override_alpha=0;
		mini.text=prefix+mtxt;

		// Attach face manually — do not use {face} (it shifts x and fights the slide anim).
		if(mface>=0&&mface<array_length_1d(_group_face)){
			var fx=(mx+slide)-35*mscale;
			var fy=my+8*mscale;
			mini._face=instance_create_depth(fx,fy,depth-1,_group_face[mface]);
			mini._face.gui=_gui;
			mini._face.image_xscale=mscale;
			mini._face.image_yscale=mscale;
			mini._face.image_alpha=0;
			mini._face.emotion=memo;
			mini._face.talking=false;
			with(mini._face){
				if(emotion>=0&&emotion<array_length_1d(idle_sprite)&&sprite_exists(idle_sprite[emotion])){
					sprite_index=idle_sprite[emotion];
					image_index=(emotion<array_length_1d(idle_image)) ? idle_image[emotion] : 0;
					image_speed=(emotion<array_length_1d(idle_speed)) ? idle_speed[emotion] : 0;
				}
				_emotion_previous=emotion;
				_talking_previous=talking;
			}
		}

		Anim_Destroy(mini,"x");
		Anim_Destroy(mini,"override_alpha");
		Anim_Create(mini,"x",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,mx+slide,-slide,12);
		Anim_Create(mini,"override_alpha",0,0,0,1,12);
		ds_list_add(_list_mini,mini);
		break;

	case "ui_buy":
		instance_create_depth(0,0,0,ui_buy);
		break;

	case "ui_buy_destroy":
		instance_destroy(ui_buy);
		break;
}