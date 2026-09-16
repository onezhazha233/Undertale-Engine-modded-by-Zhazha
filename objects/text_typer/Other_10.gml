///@desc New Char
if(_choice_dir==3&&_choice_skip_render){
	if(_char=="\n"||_char=="\r"){
		_choice_collect_text+="&";
	}else{
		_choice_collect_text+=_char;
	}
	exit;
}

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
var spacing=Typer_CharSpacing(chars,_char,next_ch);
var off_before=spacing[0]*scale_x;
var off_after=spacing[1]*scale_x;
var next_face=(next_ch!=""&&ord(next_ch)<128)?0:1;
var space_face=Typer_FaceSpaceX(_group_font_space_x[_font,font],_group_font_space_x[_font,next_face],_char,next_ch);
var wid_cur=(wid_char+space_face+_space_x+spacing[2])*scale_x;
_char_x+=off_before;

if(_char!=" "&&_char!="　"){
	draw_set_font(_group_font[_font,0]);
	var H1=string_height(" ");
	draw_set_font(_group_font[_font,font]);
	var H2=string_height(" ");
	var off_y=Typer_CharOffsetY(chars,_char)*_group_font_scale_y[_font,font]*_scale_y;
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

	if(_per_line_align){
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
			var shift=0;
			switch(_halign){
				case 1:
					shift=-(min_x+max_x)/2;
					break;
				case 2:
					shift=-max_x;
					break;
				default:
					shift=0;
					break;
			}
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
			Typer_ChoiceShiftLine(_line,shift);
		}
	}
	
	if(!_voice_played&&!_skipping&&!_instant&&_voice>=0&&_voice_mode==0){
		if(Typer_VoicePlay()!=-1){
			_voice_played=true;
		}
	}
}

draw_set_font(_group_font[_font,font]);
_char_x+=wid_cur+off_after;

if(width<_char_x){
	width=_char_x;
}

draw_set_font(_group_font[_font,0]);
var line_h=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
if(sprite_exists(_char_sprite)){
	line_h=max(line_h,(sprite_get_height(_char_sprite)-sprite_get_yoffset(_char_sprite)+_char_sprite_offset_y)*_scale_y);
}
var h=_char_y-_align_offset_y+line_h;
if(height<h){
	height=h;
}
