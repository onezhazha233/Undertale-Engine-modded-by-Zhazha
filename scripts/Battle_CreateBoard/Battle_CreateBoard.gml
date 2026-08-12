function Battle_CreateBoard(board_x,board_y,board_type=BATTLE_BOARD_TYPE.ADD,vertices=[],board_priority=-1){
	var poly = instance_create_depth(board_x,board_y,0,battle_board_polygon);
	poly.type = board_type;
	poly.vertices = vertices;
	poly.prio = board_priority;
	
	return poly;
}