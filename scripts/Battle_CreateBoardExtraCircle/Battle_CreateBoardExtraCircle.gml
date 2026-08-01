///@arg x
///@arg y
///@arg radius
function Battle_CreateBoardExtraCircle(){
	var X = argument[0];
	var Y = argument[1];
	var RADIUS = argument[2];
	
	circle = instance_create_depth(X,Y,0,battle_board_extra_circle);
	circle.radius = RADIUS;
	ds_list_add(global.borders_list,circle);
	
	return circle;
}

//创建一个圆形的加框
//Create a Extra-Board that is circle