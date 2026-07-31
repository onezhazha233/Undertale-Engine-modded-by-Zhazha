function Battle_CreateBoardCover(X, Y, LEFT, RIGHT, UP, DOWN, ANGLE, ROT=0){
	cover = instance_create_depth(X,Y,0,battle_board_cover);
	cover.left = LEFT;
	cover.right = RIGHT;
	cover.up = UP;
	cover.down = DOWN;
	cover.angle = ANGLE;
	cover.rotate = ROT;
	return cover;
}

//创建一个矩形的减框，多边形减框暂无
//Create a Cover-Board,but there is no polygon Cover-Board