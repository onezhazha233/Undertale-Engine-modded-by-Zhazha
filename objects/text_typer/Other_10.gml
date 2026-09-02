///@desc New Char
var font=0;

if(ord(_char)<128){
	font=0;
}else{
	font=1;
}

draw_set_font(_group_font[_font,font]);
var wid_char=sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char);
var scale_x=_group_font_scale_x[_font,font]*_scale_x;
var next_ch=(_char_proc+1<=string_length(text)) ? string_char_at(text,_char_proc+1) : "";
var chars=(variable_instance_exists(id,"_group_font_chars") ? _group_font_chars[_font,font] : undefined);
var spacing=CharSpacing(chars,_char,next_ch);
var off_before=spacing[0]*scale_x;
var off_after=spacing[1]*scale_x;
var wid_cur=(wid_char+_group_font_space_x[_font,font]+_space_x+spacing[2])*scale_x;
var off_y=CharOffsetY(chars,_char)*_group_font_scale_y[_font,font]*_scale_y;
_char_x+=off_before;

if(_char!=" "&&_char!="　"){
	draw_set_font(_group_font[_font,0]);
	var H1=string_height(" ");
	draw_set_font(_group_font[_font,font]);
	var H2=string_height(" ");
	var OFFSET=(H1-H2)/2*_scale_y+off_y;
	
	var rot=RotateXY(x+_char_x,y+_char_y+OFFSET,x,y,_angle);
	var INST=instance_create_depth(rot[0],rot[1],depth,text_single);
	INST.text=_char;
	INST.font=_group_font[_font,font];
	INST.scale_x=_scale_x*_group_font_scale_x[_font,font];
	INST.scale_y=_scale_y*_group_font_scale_y[_font,font];
	INST.angle=_angle;
	INST.shadow=_shadow;
	INST.outline=_outline;
	INST.color_text[0]=_color_text[0];
	INST.color_text[1]=_color_text[1];
	INST.color_text[2]=_color_text[2];
	INST.color_text[3]=_color_text[3];
	INST.color_shadow[0]=_color_shadow[0];
	INST.color_shadow[1]=_color_shadow[1];
	INST.color_shadow[2]=_color_shadow[2];
	INST.color_shadow[3]=_color_shadow[3];
	INST.color_outline[0]=_color_outline[0];
	INST.color_outline[1]=_color_outline[1];
	INST.color_outline[2]=_color_outline[2];
	INST.color_outline[3]=_color_outline[3];
	INST.shadow_x=_shadow_x;
	INST.shadow_y=_shadow_y;
	INST.alpha=_alpha;
	INST.alpha_text=_alpha_text;
	INST.alpha_shadow=_alpha_shadow;
	INST.alpha_outline=_alpha_outline;
	INST.effect=_effect;
	INST.gui=_gui;
	INST._line=_line;
	INST._deltaX=_char_x;
	INST._deltaY=_char_y+OFFSET;
	INST._parent=id;
	INST._line_order=_line_char_count;
	_line_char_count+=1;
	if(sprite_exists(_char_sprite)){
		INST.sprite=_char_sprite;
		INST.image_speed=_char_sprite_speed;
		INST.image_index=_char_sprite_image;
		INST.x+=(_char_sprite_offset_x)*_scale_x;
		INST.y+=(_char_sprite_offset_y)*_scale_y;
		INST._deltaX+=(_char_sprite_offset_x)*_scale_x;
		INST._deltaY+=(_char_sprite_offset_y)*_scale_y;
	}
	ds_list_add(_list_inst,INST);

	if(_per_line_align&&_align_h==1){
		var min_x=999999;
		var max_x=-999999;
		var proc=0;
		repeat(ds_list_size(_list_inst)){
			var INST2=ds_list_find_value(_list_inst,proc);
			if(instance_exists(INST2)&&INST2._line==_line){
				draw_set_font(INST2.font);
				var cw=string_width(INST2.text)*INST2.scale_x;
				var left=INST2._deltaX;
				var right=INST2._deltaX+cw;
				if(left<min_x)min_x=left;
				if(right>max_x)max_x=right;
			}
			proc+=1;
		}
		if(min_x<999999){
			var shift=-(min_x+max_x)/2;
			var proc2=0;
			repeat(ds_list_size(_list_inst)){
				var INST2=ds_list_find_value(_list_inst,proc2);
				if(instance_exists(INST2)&&INST2._line==_line){
					INST2._deltaX+=shift;
					var rot2=RotateXY(x+INST2._deltaX,y+INST2._deltaY,x,y,_angle);
					INST2.x=rot2[0];
					INST2.y=rot2[1];
				}
				proc2+=1;
			}
			_char_x+=shift;
		}
	}
	
	if(!_voice_played&&!_skipping&&!_instant&&_voice>=0&&_voice_mode==0){
		var sound=-1;
		var sound_index=-1;
		if(_voice_single>=0&&_voice_single<array_length(_group_voice[_voice])){
			sound_index=_voice_single;
			sound=_group_voice[_voice,sound_index];
		}else{
			sound_index=irandom(array_length(_group_voice[_voice])-1);
			sound=_group_voice[_voice,sound_index];
		}
		if(audio_exists(sound)){
			if(_group_voice_stop[_voice,sound_index]){
				audio_stop_sound(sound);
			}
			var _snd=audio_play_sound(sound,0,false);
			var _pitch=_audio_pitch;
			if(is_method(_pitch)){
				_pitch=_pitch();
			}
			if(_super_skip&&_super_skip_mode==1&&Input_IsHeld(INPUT.MENU)){
				_pitch+=0.3;
			}
			if(_pitch!=1){
				audio_sound_pitch(_snd,_pitch);
			}
			_voice_played=true;
		}
	}
}

draw_set_font(_group_font[_font,font]);
_char_x+=wid_cur+off_after;

if(width<_char_x){
	width=_char_x;
}