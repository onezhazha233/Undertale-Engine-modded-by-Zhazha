///@arg x
///@arg y
///@arg size
///@arg precision
function Battle_CreateBoardExtraRoundrect(){
	var X = argument[0];
	var Y = argument[1];
	var SIZE = argument[2];
	var PRECISION = argument[3];
	
	roundrect = instance_create_depth(X,Y,0,battle_board_extra_roundrect);
	roundrect.size = SIZE;
	roundrect.precision = PRECISION;
	
	return roundrect;
}

//创建一个圆角矩形的加框
//Create a Extra-Board that is roundrect