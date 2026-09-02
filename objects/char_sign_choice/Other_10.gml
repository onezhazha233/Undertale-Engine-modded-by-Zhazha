sign_choice = Event_Create()
Event_AddFunction(sign_choice,function(){
	char_player.moveable = false;
})
Event_Choice(sign_choice,Lang_GetString("sign.choice.0"),function(result){
	StartDialog(Lang_GetString("sign.choice.1."+string(result)));
})
Event_Choice(sign_choice,Lang_GetString("sign.choice.2"),function(result){
	StartDialog(Lang_GetString("sign.choice.3."+string(result=0 ? 1 : 0)));
	choice = result;
})
Event_AddFunction(sign_choice,function(){
	Anim_Create(char_player,"dir",0,0,char_player.dir,0,0,120);
	char_player.dir = DIR.RIGHT;
	if(choice = 0){
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,char_box.y,30,20);
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.IN,char_box.y+30,-320,25,20);
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.y+camera.height/camera.scale_y+20,char_box.y-30-(camera.y+camera.height/camera.scale_y+20),25,45);
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.IN_OUT,char_box.y-30,30,20,70);
	}
	if(choice = 1){
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,char_box.x,30,20);
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.IN,char_box.x+30,-320,25,20);
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.x+camera.width/camera.scale_x+20,char_box.x-30-(camera.x+camera.width/camera.scale_x+20),25,45);
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.IN_OUT,char_box.x-30,30,20,70);
	}
	if(choice = 2){
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,char_box.x,-30,20);
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.IN,char_box.x-30,320,25,20);
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.x-20,char_box.x+30-(camera.x-20),25,45);
		Anim_Create(char_box,"x",ANIM_TWEEN.QUAD,ANIM_EASE.IN_OUT,char_box.x+30,-30,20,70);
	}
	if(choice = 3){
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,char_box.y,-30,20);
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.IN,char_box.y-30,320,25,20);
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.y-20,char_box.y+30-(camera.y-20),25,45);
		Anim_Create(char_box,"y",ANIM_TWEEN.QUAD,ANIM_EASE.IN_OUT,char_box.y+30,-30,20,70);
	}
})
Event_AddSleep(sign_choice,120)
Event_Choice(sign_choice,Lang_GetString("sign.choice.4"),function(result){
	StartDialog(Lang_GetString("sign.choice.5."+string(result)));
	char_player.moveable = true;
})
Event_Launch(sign_choice)