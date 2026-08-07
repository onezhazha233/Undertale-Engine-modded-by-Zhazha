//BGM_Stop(0)
fader.color=c_black;
Fader_Fade(1,0,30);
Flag_Custom();
Flag_Load(FLAG_SETTINGS)
Player_Load(0);
var target=Flag_Get(FLAG_STATIC,"room",room_area_0);
room_goto(target);