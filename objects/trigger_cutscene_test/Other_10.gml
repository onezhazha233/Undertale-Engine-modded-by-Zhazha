event_inherited();

cutscene_test = Event_Create()
Event_AddFunction(cutscene_test,function(){
	char_player.moveable = false;
})
Event_AddSleep(cutscene_test,30)
Event_AddFunction(cutscene_test,function(){
	camera.SetTarget(noone);
	cy = camera.y;
	Anim_Create(camera,"y",0,0,camera.y,-camera.y+60,90);
})
Event_AddSleep(cutscene_test,90)
Event_AddFunction(cutscene_test,function(){
	pap = instance_create_depth(-20,150,0,char_papyrus);
	Flag_Set(FLAG_TEMP,"ui_dialog_top_override",0);
})
Event_CharMove(cutscene_test,char_papyrus,DIR.RIGHT,180);
Event_Dialog(cutscene_test,Lang_GetString("cutscene.0"))
Event_AddFunction(cutscene_test,function(){
	Anim_Create(camera,"y",0,0,camera.y,cy-camera.y,60);
})
Event_AddSleep(cutscene_test,60)
Event_AddFunction(cutscene_test,function(){
	x = 250;
	image_xscale = 2;
	char_player.moveable = true;
	camera.SetTarget(char_player);
})
Event_Launch(cutscene_test)