///@desc New Char
var font = 0;
if(ord(_char)<128){
	font=0;
}else{
	font=1;
}

draw_set_font(_group_font[_font,font]);

var wid_char = sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char);
var wid_space = _group_font_space_x[_font, font] + _space_x;
var scale_x = _group_font_scale_x[_font, font] * _scale_x;
var scale_y = _group_font_scale_y[_font, font] * _scale_y;
var wid_cur = (wid_char + wid_space) * scale_x;
var former_chr_offset_dict_x = [0, wid_cur / 2, wid_cur];

if(_halign = 1){
	_char_x += wid_cur / 2;
}

if(_char != " " && _char != "　"){
	draw_set_font(_group_font[_font, 0]);
	var H1 = string_height(" ");
	draw_set_font(_group_font[_font, font]);
	var H2 = string_height(" ");
	var OFFSET_X= (_font=0&&font=0&&(_char="("||_char=")") ? -4 : 0);
	var OFFSET_Y= (H1-H2) / 2 * _scale_y+(_font=2&&font=1 ? 3.5 : 0);
	
	var INST = instance_create_depth(x,y,depth,text_single);
	INST.text = _char;
	INST.font = _group_font[_font,font];
	INST.scale_x = scale_x;
	INST.scale_y = scale_y;
	INST.angle = _angle;
	INST.shadow = _shadow;
	INST.outline = _outline;
	INST.color_text[0] = _color_text[0];
	INST.color_text[1] = _color_text[1];
	INST.color_text[2] = _color_text[2];
	INST.color_text[3] = _color_text[3];
	INST.color_shadow[0] = _color_shadow[0];
	INST.color_shadow[1] = _color_shadow[1];
	INST.color_shadow[2] = _color_shadow[2];
	INST.color_shadow[3] = _color_shadow[3];
	INST.color_outline[0] = _color_outline[0];
	INST.color_outline[1] = _color_outline[1];
	INST.color_outline[2] = _color_outline[2];
	INST.color_outline[3] = _color_outline[3];
	INST.shadow_x = _shadow_x;
	INST.shadow_y = _shadow_y;
	INST.alpha = _alpha;
	INST.alpha_text = _alpha_text;
	INST.alpha_shadow = _alpha_shadow;
	INST.alpha_outline = _alpha_outline;
	INST.effect = _effect;
	INST.gui = _gui;
	INST.halign = _halign;
	INST.valign = _valign;
	INST._line = _line;
	INST._deltaX = _char_x+OFFSET_X;
	INST._deltaY = _char_y+OFFSET_Y;
	INST._xUnit = [lengthdir_x(1,_angle*(_type_dir=0 ? 1 : -1)),lengthdir_y(1,_angle*(_type_dir=0 ? 1 : -1))];
	INST._yUnit = [lengthdir_x(1,(_angle-90)*(_type_dir=0 ? 1 : -1)),lengthdir_y(1,(_angle-90)*(_type_dir=0 ? 1 : -1))];
	INST.order = _order;
	INST.typer = id;
	_order += 1;
	
	CharUpdate(INST);
	
	if sprite_exists(_char_sprite){
		INST.sprite = _char_sprite;
		INST.sprite_image = _char_sprite_image;
		INST._deltaX += sprite_get_xoffset(_char_sprite) * _scale_x;
		INST._deltaY += sprite_get_yoffset(_char_sprite) * _scale_y;
	}
	ds_list_add(_list_inst,INST);
	
	if(!_voice_played && !_skipping && !_instant && _voice >= 0){
		var sound = -1;
		if(_voice_single >= 0 && _voice_single < array_length_2d(_group_voice, _voice)){
			sound = _group_voice[_voice, _voice_single];
		}
		else{
			sound = _group_voice[_voice, irandom(array_length_2d(_group_voice, _voice) - 1)];
		}
		if(audio_exists(sound)){
			if(_audio_clear=1)audio_stop_sound(sound);
			audio_play_sound(sound, 0, false);
			_voice_played = true;
		}
	}
}

if(_halign = 0){
	_char_x += wid_cur
}

if(_halign != 0){
	var range_fix = (_char != " " && _char != "　") ? -1 : 0;
	var former_chr_offset_dict_x = former_chr_offset_dict_x[_halign];
	for(proc = 0;proc < ds_list_size(_list_inst) + range_fix;proc++){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			with(INST){
				if(_line = other._line){
					_deltaX -= former_chr_offset_dict_x;
					other.CharUpdate(id);
				}
			}
		}
	}
}

if(width < _char_x){
	width = _char_x;
}
/*live;
///@desc New Char
var font=0;

if(ord(_char)<128){
	font=0;
}else{
	font=1;
}
if(_align=1){
	_char_x+=((sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char))+_group_font_space_x[_font,font]+_space_x)*_group_font_scale_x[_font,font]*_scale_x/2;
}
if(_align=2){
	var CHANGE_X=x-xprevious;
	var CHANGE_Y=y-yprevious;
	var CHANGE_ANGLE=_angle-_angle_previous;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			with(INST){
				if(_line=other._line){
					x-=((sprite_exists(other._char_sprite) ? sprite_get_width(other._char_sprite) : string_width(other._char))+other._group_font_space_x[other._font,font]+other._space_x)*other._group_font_scale_x[other._font,font]*other._scale_x;
					y+=CHANGE_Y;
					if(other._angle_follow=1)angle+=CHANGE_ANGLE;
					x=RotateXY(x,y,other.x,other.y,CHANGE_ANGLE)[0];
					y=RotateXY(x,y,other.x,other.y,CHANGE_ANGLE)[1];
				}
			}
		}
		proc+=1;
	}
	if(instance_exists(_face)&&!_face_linked){
		_face.x+=CHANGE_X;
		_face.y+=CHANGE_Y;
	}
	xprevious=x;
	yprevious=y;
	//_angle_previous=_angle;
	//_char_x-=((sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char))+_group_font_space_x[_font,font]+_space_x)*_group_font_scale_x[_font,font]*_scale_x;
}

if(_char!=" "&&_char!="　"){
	draw_set_font(_group_font[_font,0]);
	var H1=string_height(" ");
	draw_set_font(_group_font[_font,font]);
	var H2=string_height(" ");
	var OFFSET=(H1-H2)/2*_scale_y;
	
	var INST=instance_create_depth(RotateXY(x+_char_x,y+_char_y+OFFSET,x,y,_angle)[0],RotateXY(x+_char_x,y+_char_y+OFFSET,x,y,_angle)[1],depth,text_single);
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
	INST.align=_align;
	if(sprite_exists(_char_sprite)){
		INST.sprite=_char_sprite;
		INST.sprite_image=_char_sprite_image;
		INST.x+=RotateXY(sprite_get_xoffset(_char_sprite)*_scale_x,sprite_get_yoffset(_char_sprite)*_scale_y,INST.x,INST.y,_angle)[0];
		INST.y+=RotateXY(sprite_get_xoffset(_char_sprite)*_scale_x,sprite_get_yoffset(_char_sprite)*_scale_y,INST.x,INST.y,_angle)[0];
	}
	ds_list_add(_list_inst,INST);
	
	if(!_voice_played&&!_skipping&&!_instant&&_voice>=0){
		var sound=-1;
		if(_voice_single>=0&&_voice_single<array_length_2d(_group_voice,_voice)){
			sound=_group_voice[_voice,_voice_single];
		}else{
			sound=_group_voice[_voice,irandom(array_length_2d(_group_voice,_voice)-1)];
		}
		if(audio_exists(sound)){
			audio_stop_sound(sound);
			audio_play_sound(sound,0,false);
			_voice_played=true;
		}
	}
}

draw_set_font(_group_font[_font,font]);
if(_align=0){
	_char_x+=((sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char))+_group_font_space_x[_font,font]+_space_x)*_group_font_scale_x[_font,font]*_scale_x;
}
if(_align=1){
	var CHANGE_X=x-xprevious;
	var CHANGE_Y=y-yprevious;
	var CHANGE_ANGLE=_angle-_angle_previous;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			with(INST){
				if(_line=other._line){
					x-=((sprite_exists(other._char_sprite) ? sprite_get_width(other._char_sprite) : string_width(other._char))+other._group_font_space_x[other._font,font]+other._space_x)*other._group_font_scale_x[other._font,font]*other._scale_x/2;
					y+=CHANGE_Y;
					if(other._angle_follow=1)angle+=CHANGE_ANGLE;
					x=RotateXY(x,y,other.x,other.y,CHANGE_ANGLE)[0];
					y=RotateXY(x,y,other.x,other.y,CHANGE_ANGLE)[1];
				}
			}
		}
		proc+=1;
	}
	if(instance_exists(_face)&&!_face_linked){
		_face.x+=CHANGE_X;
		_face.y+=CHANGE_Y;
	}
	xprevious=x;
	yprevious=y;
	_angle_previous=_angle;
}
if(_align=2){
	event_user(4);
	//_char_x+=((sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char))+_group_font_space_x[_font,font]+_space_x)*_group_font_scale_x[_font,font]*_scale_x;
}

if(width<_char_x){
	width=_char_x;
}