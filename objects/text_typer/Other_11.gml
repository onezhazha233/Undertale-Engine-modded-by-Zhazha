///@desc New Line
_char_x=0;

draw_set_font(_group_font[_font, 0]);

var hei_char = string_height(" ");
var hei_space = _group_font_space_y[_font] + _space_y;
var scale_y = _group_font_scale_y[_font,0] * _scale_y;
var hei_cur = (hei_char + hei_space) * scale_y;
var former_chr_offset_dict_y = [0,hei_cur / 2,hei_cur];

switch _valign
{
	case 0:
	_char_y += hei_cur//*(_type_dir=0 ? 1 : -1);
	break;
	case 1:
	_char_y += hei_cur / 2//*(_type_dir=0 ? 1 : -1);
	break;
	case 2:
	_char_y = 0;
	break;
}

_order = 0

var former_chr_offset_y = former_chr_offset_dict_y[_valign];
if(_valign != 0){
	for (proc = 0; proc < ds_list_size(_list_inst);proc ++){
		var INST = _list_inst[|proc];
		if instance_exists(INST){
			with(INST){
				_deltaY -= former_chr_offset_y;
				other.CharUpdate(id);
			}
		}
	}
}

if(height<_char_y){
	height=_char_y;
}

_line+=1;
/*live;
///@desc New Line
_char_x=0;

draw_set_font(_group_font[_font,0]);
_char_y+=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;

if(height<_char_y){
	height=_char_y;
}

_line+=1;