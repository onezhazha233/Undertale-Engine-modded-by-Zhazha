///@arg x
///@arg y
///@arg left
///@arg right
///@arg up
///@arg down
///@arg angle
///@arg *rotate
function Battle_CreateBoardCover(){
	var X = argument[0];
	var Y = argument[1];
	var LEFT = argument[2];
	var RIGHT = argument[3];
	var UP = argument[4];
	var DOWN = argument[5];
	var ANGLE = argument[6];
	var ROT = 0;
	if(argument_count >= 8){
		ROT = argument[7];
	}
	
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