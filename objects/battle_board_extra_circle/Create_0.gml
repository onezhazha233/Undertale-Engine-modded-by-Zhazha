depth = DEPTH_BATTLE.BOARD;
radius = 60;	//圆的半径
board_number = global.borderCount

// 返回是否在圆内
function contains(_x, _y) {
	return sqr(_x - x) + sqr(_y - y) <= sqr(radius);
}

// 将点限制到圆内
// 返回限制结果
function limit(_x, _y) {
	_x -= x;
	_y -= y;
	var mul = radius / sqrt(sqr(_x) + sqr(_y));
	return [_x * mul + x, _y * mul + y];
}

// 对_surf进行遮罩
function replaceSurfaceAlpha(_surf, _xOffset = 0, _yOffset = 0, _fillAlpha = true) {
	//一些设定
	surface_set_target(_surf);
	gpu_set_colorwriteenable(false, false, false, true);
	gpu_set_blendenable(false);
	
	//填充透明
	if(_fillAlpha) {
		draw_set_alpha(0);
		draw_rectangle(0, 0, surface_get_width(_surf), surface_get_height(_surf), false);
	}
	
	//挖空
	draw_set_alpha(1);
	draw_circle(x, y, radius, false);

	//恢复默认
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();
}
function drawBorder(){
	draw_circle_color(x,y,radius+5,battle_board.color_frame,battle_board.color_frame,0);
	draw_circle_color(x,y,radius,battle_board.color_bg,battle_board.color_bg,0);
}