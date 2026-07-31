Flag_Clear(FLAG_STATIC);
Flag_Clear(FLAG_DYNAMIC);
Flag_Custom();
Player_SetFun(irandom(100));
Player_SetName(_naming_name);
fader.color=c_black;
Fader_Fade(-1,0,20);
room_goto_next();