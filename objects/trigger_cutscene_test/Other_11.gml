if(image_xscale = 2){
	cutscene_test = Event_Create();
	Event_AddFunction(cutscene_test,function(){
		char_player.moveable = false;
		instance_create_depth(pap.x,pap.y-pap.sprite_height-4,0,exclamation);
		audio_play_sound(snd_exclamation,0,0);
		pap.dir = DIR.DOWN;
		camera.target = noone;
		cy = camera.y;
		Anim_Create(camera,"y",0,0,camera.y,-camera.y+60,20);
	});
	Event_AddSleep(cutscene_test,60);
	Event_AddFunction(cutscene_test,function(){
		pap.move[DIR.DOWN] = 60;
		Anim_Create(pap,"y",0,0,pap.y,20,60);
		Flag_Set(FLAG_TEMP,"ui_dialog_top_override",0);
		char_player.dir = DIR.UP;
	});
	Event_AddSleep(cutscene_test,60);
	Event_Choice(cutscene_test,Lang_GetString("cutscene.1"),function(result){
		Flag_Set(FLAG_TEMP,"ui_dialog_top_override",0);
		StartDialog(Lang_GetString("cutscene.2."+string(result)));
	});
	Event_AddFunction(cutscene_test,function(){
		pap.dir = DIR.RIGHT;
	});
	Event_AddSleep(cutscene_test,30);
	Event_AddFunction(cutscene_test,function(){
		pap.move[DIR.RIGHT] = 300;
		Anim_Create(camera,"y",0,0,camera.y,cy-camera.y,60,30);
	});
	Event_AddSleep(cutscene_test,90)
	Event_AddFunction(cutscene_test,function(){
		instance_destroy();
		Player_SetPlot("cutscene_test",1);
		char_player.moveable = true;
		camera.target = char_player;
	})
	Event_Launch(cutscene_test);
}