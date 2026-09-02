if(start = 1){
	time += 1;
	if(time = 1){
		bb = 0;
	}
	if(time mod 25 = -1){
		if(bb = 0){
			blt = instance_create_depth(150,random_range(320-55,320+55),0,battle_bullet_test);
			blt.hspeed = random_range(1.5,2.5);
			
		}
		else{
			blt = instance_create_depth(490,random_range(320-55,320+55),0,battle_bullet_test);
			blt.hspeed = -random_range(1.5,2.5);
		}
		blt.image_alpha = 0;
		Anim_Create(blt,"image_alpha",0,0,0,1,30);
		Anim_Create(blt,"image_alpha",0,0,1,-1,30,150);
		bb = !bb;
	}
}