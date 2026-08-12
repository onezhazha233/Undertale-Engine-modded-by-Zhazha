if!(instance_exists(mainboard))event_user(0);
mainboard.vertices = Shape_Create_Rect_Ext(-left,right,-up,down);
mainboard.x = x
mainboard.y = y

array_resize(objs,0)

with(battle_board_polygon){
	array_push(other.objs,self);
}
array_sort(objs,function(a,b){
	return a.prio - b.prio;
});