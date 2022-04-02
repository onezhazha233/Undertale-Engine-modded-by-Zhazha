///@arg x
///@arg y
///@arg width
///@arg height
///@arg angle
///@arg *rotate
function Battle_CreateBoardCover(){
	var X = argument[0];
	var Y = argument[1];
	var WIDTH = argument[2];
	var HEIGHT = argument[3];
	var ANGLE = argument[4];
	var ROT = 0;
	if(argument_count >= 6){
		ROT = argument[5];
	}
	
	cover = instance_create_depth(X,Y,0,battle_board_cover);
	cover.width = WIDTH;
	cover.height = HEIGHT;
	cover.angle = ANGLE;
	cover.rotate = ROT;
	
	return cover;
}

//创建一个矩形的减框，多边形减框暂无
//Create a Cover-Board,but there is no polygon Cover-Board