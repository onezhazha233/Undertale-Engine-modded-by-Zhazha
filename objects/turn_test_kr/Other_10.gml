Battle_SetBoardSize(65,65,100,100)

star = Battle_CreateBoard(100,320,0,Shape_Create_Star(65,30,5))
rr = Battle_CreateBoard(540,320,0,Shape_Create_Rect_Rounded(100,60,20))
rr.image_angle = 30