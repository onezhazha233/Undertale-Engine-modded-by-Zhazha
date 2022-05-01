///@arg x
///@arg y
///@arg up
///@arg down
///@arg left
///@arg right
///@arg angle
///@arg *rot
function Battle_CreateBoardExtraRect(){
	var X = argument[0];
	var Y = argument[1];
	var UP = argument[2];
	var DOWN = argument[3];
	var LEFT = argument[4];
	var RIGHT = argument[5];
	var ANGLE = argument[6];
	var ROT = 0;
	if(argument_count >= 8){
		ROT = argument[7];
	}
	
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