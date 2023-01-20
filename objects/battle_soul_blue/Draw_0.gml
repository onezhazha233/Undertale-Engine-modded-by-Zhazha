draw_self()

var isInside1 = false;
var isInside2 = false;
var isInside3 = false;
var isInside4 = false;
for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
	bb = ds_list_find_value(global.borders_list,i);
	if(bb.contains(battle_soul.x - sprite_width/2-1, battle_soul.y)) {
		isInside1 = true;
		break;
	}
}
for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
	bb = ds_list_find_value(global.borders_list,i);
	if(bb.contains(battle_soul.x + sprite_width/2, battle_soul.y)) {
		isInside2 = true;
		break;
	}
}
for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
	bb = ds_list_find_value(global.borders_list,i);
	if(bb.contains(battle_soul.x, battle_soul.y - sprite_height/2-1)) {
		isInside3 = true;
		break;
	}
}
for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
	bb = ds_list_find_value(global.borders_list,i);
	if(bb.contains(battle_soul.x, battle_soul.y + sprite_height/2+1)) {
		isInside4 = true;
		break;
	}
}