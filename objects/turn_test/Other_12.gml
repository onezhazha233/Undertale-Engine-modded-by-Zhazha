Battle_SetTurnTime(-1)
start = 1

/*aa = Battle_CreateBoardExtra(320,320)
Battle_AddBoardExtraVertex(aa,lengthdir_x(100,90),lengthdir_y(100,90))
Battle_AddBoardExtraVertex(aa,lengthdir_x(50,90-36),lengthdir_y(50,90-36))
Battle_AddBoardExtraVertex(aa,lengthdir_x(100,90-72),lengthdir_y(100,90-72))
Battle_AddBoardExtraVertex(aa,lengthdir_x(50,90-36-72),lengthdir_y(50,90-36-72))
Battle_AddBoardExtraVertex(aa,lengthdir_x(100,90-72*2),lengthdir_y(100,90-72*2))
Battle_AddBoardExtraVertex(aa,lengthdir_x(50,90-36-72*2),lengthdir_y(50,90-36-72*2))
Battle_AddBoardExtraVertex(aa,lengthdir_x(100,90-72*3),lengthdir_y(100,90-72*3))
Battle_AddBoardExtraVertex(aa,lengthdir_x(50,90-36-72*3),lengthdir_y(50,90-36-72*3))
Battle_AddBoardExtraVertex(aa,lengthdir_x(100,90-72*4),lengthdir_y(100,90-72*4))
Battle_AddBoardExtraVertex(aa,lengthdir_x(50,90-36-72*4),lengthdir_y(50,90-36-72*4))*/

//Battle_CreateBoardExtraRect(320,320,40,40,30,0)

instance_create_depth(0,500,0,battle_bg)

Battle_SetSoul(battle_soul_blue)
//battle_soul.dir = 180

instance_create_depth(0,0,0,battle_bullet_test)

Battle_SetBoardSize(65,0,65,65)