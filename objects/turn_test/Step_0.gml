if(start = 1){
	time += 1;
	if(time = 1){
		rr = Battle_CreateBoard(battle_board.x,battle_board.y,BATTLE_BOARD_TYPE.ADD,Shape_Create_Rect_Rounded(130,130,0),0);
		rr.size = 130;
		rr.precision = 0;
		with(rr){
			on_step = function(){
				vertices = Shape_Create_Rect_Rounded(size,size,precision);
			}
		}
		battle_board.x = -1000;
		Anim_Create(rr,"precision",ANIM_TWEEN.SINE,ANIM_EASE.OUT,0,65,40);
		Anim_Create(rr,"image_angle",ANIM_TWEEN.SINE,ANIM_EASE.OUT,0,90,40);
	}
	if(time = 60){
		Anim_Create(rr,"y",ANIM_TWEEN.SINE,ANIM_EASE.IN,rr.y,650-rr.y,30);
		star = Battle_CreateBoard(320,650,BATTLE_BOARD_TYPE.ADD,Shape_Create_Star(77,35,5),0);
		star.rotSpeed = 0;
		with(star){
			on_step = function(){
				image_angle += rotSpeed;
			}
		}
	}
	if(time = 100){
		Anim_Create(star,"y",ANIM_TWEEN.SINE,ANIM_EASE.OUT,star.y,320-star.y,30);
		rr.size = 10;
		rr.precision = 5;
	}
	if(time = 150){
		Anim_Create(star,"rotSpeed",0,0,0,-3.5,20);
	}
	if(time = 200){
		Anim_Create(star,"y",ANIM_TWEEN.QUAD,ANIM_EASE.IN,320,-420,60);
		rr.y = -100;
		rr.precision = 65;
		rr.size = 130;
	}
	if(time = 300){
		instance_destroy(star);
	}
	if(time = 320){
		Anim_Create(rr,"y",ANIM_TWEEN.SINE,ANIM_EASE.OUT,650,320-650,60);
	}
	if(time = 380){
		Anim_Create(rr,"image_angle",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,0,-90,30);
		Anim_Create(rr,"precision",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,65,-65,30);
	}
	if(time = 430){
		instance_destroy(rr);
		battle_board.left = 65;
		battle_board.right = 65;
		battle_board.x = 320;
		battle_board.y = 320;
		Battle_EndTurn();
	}
}