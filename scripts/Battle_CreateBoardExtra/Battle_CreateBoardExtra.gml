function Battle_CreateBoardExtra(X, Y, ROT=0){
	extra = instance_create_depth(X,Y,0,battle_board_extra);
	extra.rotSpeed = ROT;
	ds_list_add(global.borders_list,extra);
	return extra;
}

//直接创建一个加框，创建后需要手动添加顶点
//Create a Extra-Board directly,you need to add vertexes by yourself