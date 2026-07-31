///@desc Settings
_inst_title=instance_create_depth(160,10,0,text_typer);
_inst_title.text=_prefix+Lang_GetString("settings.title");
_inst_exit=instance_create_depth(40+Lang_GetLayout("settings.title_x"),80,0,text_typer);
_inst_exit.text=_prefix+Lang_GetString("settings.exit");
_inst_language_title=instance_create_depth(40+Lang_GetLayout("settings.title_x"),140,0,text_typer);
_inst_language_title.text=_prefix+Lang_GetString("settings.language");
_inst_language=instance_create_depth(184+Lang_GetLayout("settings.value_x"),140,0,text_typer);
_inst_language.text=_prefix+Lang_GetInfo(Language(),"name");
_inst_border_title=instance_create_depth(40+Lang_GetLayout("settings.title_x"),200,0,text_typer);
_inst_border_title.text=_prefix+Lang_GetString("settings.border");
_inst_border=instance_create_depth(184+Lang_GetLayout("settings.value_x"),200,0,text_typer);
_inst_border.text=_prefix+Border_GetName(Flag_Get(FLAG_SETTINGS,"border"));
_inst_window_scale_title=instance_create_depth(40+Lang_GetLayout("settings.title_x"),260,0,text_typer);
_inst_window_scale_title.text=_prefix+Lang_GetString("settings.window_scale");
_inst_window_scale=instance_create_depth(184+Lang_GetLayout("settings.value_x"),260,0,text_typer);
var _ws_val=Flag_Get(FLAG_SETTINGS,"window_scale",1);
var _ws_str=string(_ws_val);
var _ws_dot=string_pos(".",_ws_str);
if(_ws_dot>0){
	while(string_char_at(_ws_str,string_length(_ws_str))=="0"){
		_ws_str=string_copy(_ws_str,1,string_length(_ws_str)-1);
	}
	if(string_char_at(_ws_str,string_length(_ws_str))=="."){
		_ws_str=string_copy(_ws_str,1,string_length(_ws_str)-1);
	}
}
_inst_window_scale.text=_prefix+_ws_str+"x";
with(text_typer){
	event_user(15);
}
event_user(2);