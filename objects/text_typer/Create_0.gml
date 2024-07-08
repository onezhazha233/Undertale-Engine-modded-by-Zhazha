//text_typer args
text="";
_speed=0;
_char_per_frame=1;
_voice=0;
_voice_single=-1;
_sleep=0;
_skippable=true;
_skip_enabled=false;
_skipping=false;
_paused=false;
_instant=false;
_space_x=0;
_space_y=0;
_char_frame_remain=0;
_char_x=0;
_char_y=0;
_char="";
_char_sprite=-1;
_char_sprite_image=0;
_char_proc=1;
_voice_played=false;
_list_inst=ds_list_create();
_list_cmd=ds_list_create();
_map_macro=ds_map_create();
_face=noone;
_face_linked=-1;
_char_linked=-1;
_skip_space=true;
_line=0;//目前所在行数
_type_dir=0;//打字方向 0为水平 1为垂直
_halign=0;
_valign=0;
_position_follow=true;
_audio_clear=true;

_choice=-1;
_choice_x[0]=0;
_choice_y[0]=0;
_choice_x[1]=0;
_choice_y[0]=0;
_choice_macro="";
_choice_switch_direction=0;//0为左右 1为上下
_choice_switch_key=[INPUT.LEFT,INPUT.RIGHT];

//text_single args
_font=0;
_scale_x=1;
_scale_y=1;
_angle=0;
_angle_previous=0;
_angle_follow=true;
_shadow=false;
_outline=false;
_color_text[0]=c_white;
_color_text[1]=c_white;
_color_text[2]=c_white;
_color_text[3]=c_white;
_color_shadow[0]=make_color_rgb(49,49,79);
_color_shadow[1]=make_color_rgb(49,49,79);
_color_shadow[2]=make_color_rgb(15,15,115);
_color_shadow[3]=make_color_rgb(15,15,115);
_color_outline[0]=make_color_rgb(110,110,110);
_color_outline[1]=make_color_rgb(110,110,110);
_color_outline[2]=make_color_rgb(110,110,110);
_color_outline[3]=make_color_rgb(110,110,110);
_alpha=1;
_alpha_text=1;
_alpha_shadow=1;
_alpha_outline=1;
_shadow_x=0.5;
_shadow_y=0.5;
_effect=-1;
_gui=false;

//group init
event_user(5);

width=0;
height=0;
override_alpha_enabled=false;
override_alpha=1;
override_color_text_enabled=false;
override_color_text[0]=c_white;
override_color_text[1]=c_white;
override_color_text[2]=c_white;
override_color_text[3]=c_white;

ttime=0;
torder=[];
_order=0;

auto_destroy=false;

alarm[1] = 1

function CharUpdate(character){
	with(character){
		if(other._position_follow = 1){
			if(other._type_dir = 0){
				x = other.x + _offset_x + _xUnit[0] * _deltaX + _yUnit[0] * _deltaY;
				y = other.y + _offset_y + _xUnit[1] * _deltaX + _yUnit[1] * _deltaY;
			}
			else{
				x = other.x + _offset_x + _xUnit[1] * _deltaX + _yUnit[1] * _deltaY;
				y = other.y + _offset_y + _xUnit[0] * _deltaX + _yUnit[0] * _deltaY;
			}
		}
	}
}

function ChangeText(){
	var TEXT = argument[0];
	
	event_user(3);
	//_paused = false;
	//_sleep = 0;
	text="";
	_speed=0;
	_char_per_frame=1;
	_voice=0;
	_voice_single=-1;
	_sleep=0;
	_skippable=true;
	_skip_enabled=false;
	_skipping=false;
	_paused=false;
	_instant=false;
	_space_x=0;
	_space_y=0;
	_char_frame_remain=0;
	_char_x=0;
	_char_y=0;
	_char="";
	_char_sprite=-1;
	_char_sprite_image=0;
	_char_proc=1;
	_voice_played=false;
	_list_inst=ds_list_create();
	_list_cmd=ds_list_create();
	_map_macro=ds_map_create();
	_face=noone;
	_face_linked=-1;
	_char_linked=-1;
	_skip_space=true;
	_line=0;//目前所在行数
	_type_dir=0;//打字方向 0为水平 1为垂直
	_halign=0;
	_valign=0;
	_position_follow=true;
	_audio_clear=true;

	_choice=-1;
	_choice_x[0]=0;
	_choice_y[0]=0;
	_choice_x[1]=0;
	_choice_y[0]=0;
	_choice_macro="";

	//text_single args
	_font=0;
	_scale_x=1;
	_scale_y=1;
	_angle=0;
	_angle_previous=0;
	_angle_follow=1;
	_shadow=false;
	_outline=false;
	_color_text[0]=c_white;
	_color_text[1]=c_white;
	_color_text[2]=c_white;
	_color_text[3]=c_white;
	_color_shadow[0]=make_color_rgb(49,49,79);
	_color_shadow[1]=make_color_rgb(49,49,79);
	_color_shadow[2]=make_color_rgb(15,15,115);
	_color_shadow[3]=make_color_rgb(15,15,115);
	_color_outline[0]=make_color_rgb(110,110,110);
	_color_outline[1]=make_color_rgb(110,110,110);
	_color_outline[2]=make_color_rgb(110,110,110);
	_color_outline[3]=make_color_rgb(110,110,110);
	_alpha=1;
	_alpha_text=1;
	_alpha_shadow=1;
	_alpha_outline=1;
	_shadow_x=0.5;
	_shadow_y=0.5;
	_effect=-1;
	_gui=false;

	//group init
	event_user(5);

	width=0;
	height=0;
	override_alpha_enabled=false;
	override_alpha=1;
	override_color_text_enabled=false;
	override_color_text[0]=c_white;
	override_color_text[1]=c_white;
	override_color_text[2]=c_white;
	override_color_text[3]=c_white;
	text=TEXT;
	
	_order=0;
	
	alarm[1] = 1;
}

function GetMainText(){
    var len = string_length(text);
    var result = "";
    var inside_braces = false;

    for (var i = 0; i <= len; i++) {
        var charr = string_char_at(text, i);

        if(charr = "{") {
            inside_braces = true;
        }
		else if(charr = "}") {
            inside_braces = false;
        }
		if!(inside_braces) {
            result += charr;
        }
    }

    return string_replace_all(result,"}","");
}//返回不带命令的文本，返回的结果中不会含有大括号，如果要使用该函数，请保证大括号成对出现