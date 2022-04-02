///@arg x
///@arg y
///@arg *rot
function Battle_CreateBoardExtra(){
	var X = argument[0];
	var Y = argument[1];
	var ROT = 0
	if(argument_count >= 3){
		ROT = argument[2];
	}
	
	extra = instance_create_depth(X,Y,0,battle_board_extra);
	extra.rotSpeed = ROT;
	array_insert(global.borders,array_length(global.borders),extra);
	
	return extra;
}

//直接创建一个加框，创建后需要手动添加顶点
//Create a Extra-Board directly,you need to add vertexes by yourself