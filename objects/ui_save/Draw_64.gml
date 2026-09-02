if(_state==0||_state==1){
	draw_sprite_ext(spr_pixel,0,108,118,424,174,0,c_white,1);
	draw_sprite_ext(spr_pixel,0,108+6,118+6,424-6*2,174-6*2,0,c_black,1);
}

if(_state==0){
	var soul_x=108+6+37;
	switch(_choice){
		case 0:
			soul_x=108+6+37;
			break;
		case 1:
			soul_x=108+6+217;
			if(menu_enabled)soul_x-=60;
			break;
		case 2:
			soul_x=108+6+287;
			break;
	}
	draw_sprite(spr_battle_soul_red,0,soul_x,118+6+131);
}