depth=DEPTH_UI.PANEL;
if(instance_exists(char_player)){
	_top=(char_player.y-camera.y>130+char_player.sprite_height);
	char_player._moveable_dialog=false;
}else{
	_top=false;
}
_inst_gold=noone;
_inst_space=noone;
_prefix = "{scale 2}{font 1}{instant true}{gui true}{depth "+string(DEPTH_UI.TEXT)+"}"
_gold = -1
_item_number = -1