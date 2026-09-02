surf_xscale = 0
surf_yscale = 0

ScreenOn = function(){
	Anim_Create(id,"surf_xscale",0,0,0,1,10);
	Anim_Create(id,"surf_yscale",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,0,0.01,10);
	Anim_Create(id,"surf_yscale",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,0.01,0.99,10,10);
}

ScreenOff = function(){
	Anim_Create(id,"surf_yscale",ANIM_TWEEN.QUAD,ANIM_EASE.IN,1,-0.99,10);
	Anim_Create(id,"surf_yscale",ANIM_TWEEN.QUAD,ANIM_EASE.IN,0.01,-0.01,10,10);
	Anim_Create(id,"surf_xscale",0,0,1,-1,10,10);
	DelayFunction(function(){
		with(char_prompt_test){
			Prompt_ClearAll(false, 20);
			Anim_Create(camera,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.x,cx-camera.x,20);
			Anim_Create(camera,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.y,cy-camera.y,20);
			DelayFunction(function(){
				char_player.moveable = true;
				char_player.dir = DIR.DOWN;
				camera.target = char_player;
			},20);
		}
	},20);
}