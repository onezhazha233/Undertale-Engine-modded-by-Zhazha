Battle_SetTurnTime(-1)
start = 1

instance_create_depth(0,0,0,battle_bullet_test)
if!(instance_exists(battle_bg))instance_create_depth(0,500,0,battle_bg)

/*star = Battle_CreateBoardExtra(320,320);
Battle_AddBoardExtraVertex(star,lengthdir_x(77,90),lengthdir_y(77,90));
Battle_AddBoardExtraVertex(star,lengthdir_x(35,90-36),lengthdir_y(35,90-36));
Battle_AddBoardExtraVertex(star,lengthdir_x(77,90-72),lengthdir_y(77,90-72));
Battle_AddBoardExtraVertex(star,lengthdir_x(35,90-36-72),lengthdir_y(35,90-36-72));
Battle_AddBoardExtraVertex(star,lengthdir_x(77,90-72*2),lengthdir_y(77,90-72*2));
Battle_AddBoardExtraVertex(star,lengthdir_x(35,90-36-72*2),lengthdir_y(35,90-36-72*2));
Battle_AddBoardExtraVertex(star,lengthdir_x(77,90-72*3),lengthdir_y(77,90-72*3));
Battle_AddBoardExtraVertex(star,lengthdir_x(35,90-36-72*3),lengthdir_y(35,90-36-72*3));
Battle_AddBoardExtraVertex(star,lengthdir_x(77,90-72*4),lengthdir_y(77,90-72*4));
Battle_AddBoardExtraVertex(star,lengthdir_x(35,90-36-72*4),lengthdir_y(35,90-36-72*4));
star.rotSpeed = 0.5*/