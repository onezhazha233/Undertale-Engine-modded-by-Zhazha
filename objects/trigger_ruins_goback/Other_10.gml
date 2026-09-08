event_inherited();

goback = Event_Create()
Event_AddFunction(goback,function(){
	char_player.moveable = false;
	char_player.visible = false;
	char_player.dir = DIR.DOWN;
})
Event_AddSleep(goback,20)
Event_AddFunction(goback,function(){
	Anim_Create(char_player,"y",0,0,char_player.y,110-char_player.y,82);
})
Event_AddSleep(goback,82)
Event_AddFunction(goback,function(){
	char_player.moveable = true;
	char_player.visible = true;
	_triggered = false;
})
Event_Launch(goback)