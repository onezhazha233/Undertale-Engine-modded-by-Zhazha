function Battle_CreateBoardExtraRoundrect(X, Y, SIZE, PRECISION){
	roundrect = instance_create_depth(X,Y,0,battle_board_extra_roundrect);
	roundrect.size = SIZE;
	roundrect.precision = PRECISION;
	return roundrect;
}

//创建一个圆角矩形的加框
//Create a Extra-Board that is roundrect