///@arg x
///@arg y
///@arg width
///@arg height
///@arg angle
///@arg *rot
function Battle_CreateBoardExtraRect(){
	var X = argument[0];
	var Y = argument[1];
	var WIDTH = argument[2];
	var HEIGHT = argument[3];
	var ANGLE = argument[4];
	var ROT = 0;
	if(argument_count >= 6){
		ROT = argument[5];
	}
	
	rect = instance_create_depth(X,Y,0,battle_board_extra);
	ds_list_add(rect.listVertex,[-WIDTH/2,-HEIGHT/2],[WIDTH/2,-HEIGHT/2],[WIDTH/2,HEIGHT/2],[-WIDTH/2,HEIGHT/2]);
	rect.updateDivide();
	rect.rot = -ANGLE;
	rect.rotSpeed = -ROT;
	array_insert(global.borders,array_length(global.borders),rect);
	
	return rect;
}

//创建一个矩形的加框
//Create a Extra-Board that is rectangle