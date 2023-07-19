function Battle_GetBoardCenter(){
	x1 = battle_board.x - battle_board.left;
	y1 = battle_board.y - battle_board.up;
	x2 = battle_board.x + battle_board.right;
	y2 = battle_board.y + battle_board.down;
	rotatedPoint1 = RotateXY(battle_board.x1,battle_board.y1,battle_board.x,battle_board.y,battle_board.angle);
	rotatedPoint2 = RotateXY(battle_board.x2,battle_board.y2,battle_board.x,battle_board.y,battle_board.angle);
	centerX = (rotatedPoint1[0] + rotatedPoint2[0])/2;
	centerY = (rotatedPoint1[1] + rotatedPoint2[1])/2;
	
	return [centerX,centerY];
}