///@arg board
///@arg vertex_x
///@arg vertex_y
function Battle_AddBoardExtraVertex(){
	var BOARD = argument[0];
	var X = argument[1];
	var Y = argument[2];
	var VERTEXLIST = BOARD.listVertex;
	
	ds_list_add(VERTEXLIST,[X,Y])
	BOARD.updateDivide();
}

//给指定加框添加顶点，最少要三个顶点才能正常运行
//注意：顶点坐标顺序一定要按顺时针排列否则会出显示问题
//Add vertex to the Extra-Board,you need to add at least 3 vertexes to make it work properly
//WARNING:The arrangement of vertexes' positions must be clockwise or visual problem happens