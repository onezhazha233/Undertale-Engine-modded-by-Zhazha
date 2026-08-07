var pos=Flag_Get(FLAG_TEMP,"gameover_soul_position");
x=pos[0];
y=pos[1];
audio_stop_all();
image_speed=0;

prefix="{define `NAME` `"+string(Player_GetName())+"`}{skippable false}{scale 2}{space_x "+string(Lang_GetLayout("battle.gameover.space_x"))+"}{gui true}{shadow false}{color_text `white`}{speed "+string(Lang_GetLayout("speed.gameover",0))+"}{voice 3}";
_inst=noone;
text=0;
bg_alpha=0;

alarm[0]=40;