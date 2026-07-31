function Battle_CreateBoardExtraRect(X, Y, UP, DOWN, LEFT, RIGHT, ANGLE, ROT=0){
	rect = instance_create_depth(X,Y,0,battle_board_extra_rect);
	rect.up = UP;
	rect.down = DOWN;
	rect.left = LEFT;
	rect.right = RIGHT;
	rect.angle = ANGLE;
	rect.rot = ROT;
	return rect;
}

//创建一个矩形的加框
//Create a Extra-Board that is rectangle