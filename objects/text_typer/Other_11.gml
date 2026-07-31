///@desc New Line
if(_per_line_align&&_align_h==1){
	_char_x=0;
}else{
	_char_x=_align_offset_x;
}

draw_set_font(_group_font[_font,0]);
_char_y+=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;

if(height<_char_y){
	height=_char_y;
}

_line+=1;
_line_char_count=0;