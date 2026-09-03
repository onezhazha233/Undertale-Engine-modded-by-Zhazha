event_inherited();

goshopping = Event_Create(true)
Event_AddFunction(goshopping,function(){
	fader.color=0;
	Fader_Fade(0,1,20);
	char_player._moveable_warp=false;
	BGM_SetVolume(0,0,20);
})
Event_AddSleep(goshopping,20)
Event_AddFunction(goshopping,function(){
	BGM_Pause(0);
	Fader_Fade(1,0,30);
	char_player.x = 245;
	char_player.y = 40;
	Shop_Start(0);
})
Event_AddFunction(goshopping,function(){},function(){
	return room==room_shop;
})
Event_AddFunction(goshopping,function(){
	BGM_Resume(0);
	BGM_SetVolume(0,1,20);
	char_player.dir = DIR.DOWN;
})
Event_AddSleep(goshopping,20)
Event_AddFunction(goshopping,function(){
	char_player._moveable_warp=true;
	_triggered=false;
})
Event_Launch(goshopping)


alarm[0]=20+1;