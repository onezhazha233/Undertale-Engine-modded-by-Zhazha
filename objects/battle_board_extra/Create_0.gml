depth = DEPTH_BATTLE.BOARD;
listVertex = ds_list_create();	//多边形的顶点，请使用ds_list_add、ds_list_delete等进行操作
listDivideIndex = ds_list_create();	//多边形的三角剖分
rot = 0;	//旋转角度（逆时针）
rotSpeed = 0;	//旋转速度
board_number = global.borderCount

// [返回点是否在多边形内]
// 传入参数:
//     _x: 点的横坐标
//     _y: 点的纵坐标
//     _listVertex: 别管这个
function contains(_x, _y, _listVertex = listVertex) { return relativeContains(_x - x, _y - y, _listVertex); }

// [返回点是否在多边形内]
// 传入参数:
//     _x: 相对于该多边形x的横坐标
//     _y: 相对于该多边形y的纵坐标
//     _listVertex: 别管这个
function relativeContains(_x, _y, _listVertex = listVertex) {
	var size = ds_list_size(_listVertex);
	if(size < 2)	//若顶点数量不足则返回false
		return false;
		
	var vsin = dsin(rot), vcos = dcos(rot);
	var xx = _x * vcos - _y * vsin, yy = _x * vsin + _y * vcos;
	
	//从末尾开始遍历得到第一个不为水平的线的 走向 和 交点情况
	var isAllHor = true, prevTrend = false, prevHasIntersection = false;
	var prev = _listVertex[| size - 1], cur;
	for(var i = size - 2; i >= 0; i--) {
		cur = _listVertex[| i];
		if(prev[1] != cur[1]) {
			isAllHor = false;
			prevTrend = cur[1] < prev[1];	//因为是反向遍历，所以是小于（和后面的大于相反）
			prevHasIntersection = (yy >= min(prev[1], cur[1]) && yy <= max(prev[1], cur[1]));
			break;
		}
		prev = cur;
	}
	if(isAllHor)	//如果全部都为水平线，则返回false
		return false;
	
	//计算交点横坐标
	var intersections, count = 0;
	prev = _listVertex[| size - 1];
	for(var i = 0; i < size; i++) {
		cur = _listVertex[| i];
		if(prev[1] != cur[1]) {
			var hasIntersection = false;
			var trend = cur[1] > prev[1];
			if(trend != prevTrend || !prevHasIntersection) {
				if(yy >= min(prev[1], cur[1]) && yy <= max(prev[1], cur[1])) {
					hasIntersection = true;
					intersections[count] = prev[0] + (cur[0] - prev[0]) 
						* (yy - prev[1]) / (cur[1] - prev[1]);
					count++;
				}
			}
			if(trend != prevTrend)
				prevTrend = trend;
			prevHasIntersection = hasIntersection;
		}
		prev = cur;
	}
	if(count == 0)	//如果没有交点，则返回false
		return false;

	array_sort(intersections, true);	//从小到大对交点横坐标进行排序
	
	
	//根据交点对是否在内部进行判断
	var isInside = false;
	for(var i = 0; i < count; i++) {
		if(intersections[i] > xx)
			return isInside;
		isInside = !isInside;
	}
    return false;
}

// [返回离边框最近处的位置，长度为2的数组（下标0是x，下标1是y）]
function limit(_x, _y) {
	var size = ds_list_size(listVertex);
	if(size == 0)
		return [_x, _y];
	if(size == 1) {
		var vertex = listVertex[| 0];
		return [vertex[0] + x, vertex[1] + y];
	}
	
	_x -= x;
	_y -= y;
	var vsin = dsin(-rot), vcos = dcos(-rot);
	var xx = _x * vcos + _y * vsin, yy = -_x * vsin + _y * vcos;
	
	var nearestPos, nearestDis = -1;
	var prev = listVertex[| size - 1], cur;
	for(var i = 0; i < size; i++) {
		cur = listVertex[| i];
		if((prev[0] - xx) * (prev[0] - cur[0]) + (prev[1] - yy) * (prev[1] - cur[1]) < 0) {
			var dis = point_distance(xx, yy, prev[0], prev[1]);
			if(dis < nearestDis || nearestDis == -1) {
				nearestDis = dis;
				nearestPos = prev;
			}
		} else if((cur[0] - xx) * (cur[0] - prev[0]) + (cur[1] - yy) * (cur[1] - prev[1]) < 0) {
			var dis = point_distance(xx, yy, cur[0], cur[1]);
			if(dis < nearestDis || nearestDis == -1) {
				nearestDis = dis;
				nearestPos = cur;
			}
		} else {
			var k = ((yy - prev[1]) * (cur[0] - prev[0]) - (xx - prev[0]) * (cur[1] - prev[1]))
				/ (sqr(cur[1] - prev[1]) + sqr(cur[0] - prev[0]));
			var dis = abs(k) * point_distance(prev[0], prev[1], cur[0], cur[1]);
			if(dis < nearestDis || nearestDis == -1) {
				nearestDis = dis;
				nearestPos = [xx + k * (cur[1] - prev[1]), yy + k * (prev[0] - cur[0])];
			}
		}
		prev = cur;
	}
	var resultx = nearestPos[0] * vcos - nearestPos[1] * vsin;
	var resulty = nearestPos[0] * vsin + nearestPos[1] * vcos;
	return [resultx + x, resulty + y];
}

// 用于更新多边形的三角剖分
// 如果你要实现框内遮罩的效果，请在添加或删除多边形的顶点后调用此函数
function updateDivide() {
	ds_list_clear(listDivideIndex);	//清除原剖分结果
	var size = ds_list_size(listVertex);
	if(size < 3)
		return;
	
	listVertexTmp = ds_list_create();	//创建临时顶点列表
	ds_list_copy(listVertexTmp, listVertex);
	
	var marker = ds_list_create();	//创建tmp与原列表对应关系
	for(var i = 0; i < size; i++)
		ds_list_add(marker, i);
	
	// 辅助函数，用于_index处的顶点是否可以剖分
	function canDivide(_index) {		
		//判断是否为凸顶点，如果不是，则return false
		//实际上这里也有部分为凹顶点的情况无法被排除，但是后续的代码会同时排除掉这些
		var p1 = listVertexTmp[| iloop(_index - 1, listVertexTmp)], p2 = listVertexTmp[| iloop(_index + 1, listVertexTmp)];
		if(!relativeContains((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, listVertexTmp))
			return false;
		
		//判断移除顶点后是否出现边相交
		var istart = _index + 2 - ds_list_size(listVertexTmp), iend = _index - 2;
		var a1 = listVertexTmp[| iloop(_index - 1, listVertexTmp)];
		var a2 = listVertexTmp[| iloop(_index + 1, listVertexTmp)];
		var b1, b2;
		function cp(_a1, _a2, _b1, _b2) { return (_a2[0] - _a1[0]) * (_b2[1] - _b1[1]) - (_a2[1] - _a1[1]) * (_b2[0] - _b1[0]); }
		for(var i = istart; i < iend; i++) {
			b1 = listVertexTmp[| iloop(i, listVertexTmp)];
			b2 = listVertexTmp[| iloop(i + 1, listVertexTmp)];
			if(sign(cp(a1, a2, a1, b1)) != sign(cp(a1, a2, a1, b2)) && sign(cp(b1, b2, b1, a1)) != sign(cp(b1, b2, b1, a2)))
				return false;
		}
		return true;
	}
	// 辅助函数，用于检查是否为凸多边形
	function isConvex() {
		var bool1 = false, bool2 = false;	//分别记录边的两种走向是否存在
		for(var i = 0; i < ds_list_size(listVertexTmp); i++) {
			var p1 = listVertexTmp[| i];
			var p2 = listVertexTmp[| iloop(i + 1, listVertexTmp)];
			var p3 = listVertexTmp[| iloop(i + 2, listVertexTmp)];
			var x1 = p2[0] - p1[0], y1 = p2[1] - p1[1], x2 = p3[0] - p2[0], y2 = p3[1] - p2[1];
			var cp = x1 * y2 - x2 * y1;
			
			if(cp > 0) {	//一种走向
				bool1 = true;
			} else if(cp < 0) {	//另一种走向
				bool2 = true;
			}
			
			if(bool1 && bool2)	//如果两种走向都存在，则不是凸多边形
				return false;
		}
		return true;	//是凸多边形
	}
	
	//进行剖分
	while(!isConvex()) {	//循环直到listVertexTmp变为凸多边形
		var divided = false;
		for(var i = 0; i < ds_list_size(listVertexTmp); i++) {	//遍历所有顶点
			if(canDivide(i)) {	//如果该顶点可以剖分
				divided = true;
				var a = marker[| iloop(i - 1, marker)];
				var b = marker[| iloop(i + 1, marker)];
				ds_list_add(listDivideIndex, [marker[| i], a, b]);
				ds_list_delete(listVertexTmp, i);
				ds_list_delete(marker, i);
				break;
			}
		}
		if(!divided) {	//当出现死循环时（大多是因为多边形的边出现相交）直接结束
			ds_list_clear(listDivideIndex);
			ds_list_destroy(listVertexTmp);	//销毁临时顶点列表
			ds_list_destroy(marker);	//销毁
			return;
		}
	}
	var tmpLast = ds_list_size(listVertexTmp) - 1;
	var last = marker[| tmpLast];
	for(var i = 0; i < tmpLast - 1; i++) {	//对剩下的凸多边形部分进行剖分
		ds_list_add(listDivideIndex, [marker[| i], marker[| iloop(i + 1, marker)], last]);
	}
	
	ds_list_destroy(listVertexTmp);	//销毁临时顶点列表
	ds_list_destroy(marker);	//销毁
}

// 用于更改surface的alpha以达到限制显示范围的目的（遮罩）
// 传入参数:
//     _surf: 传入的surface，将会对其进行修改
//     _xOffset: 限制区域的横向偏移量，一般为0即可
//     _yOffset: 限制区域的纵向偏移量，一般为0即可
//     _fillAlpha: 是否将alpha全设为0，用于多个多边形叠加时，第一个传入true，其余传入false以叠加遮罩
function replaceSurfaceAlpha(_surf, _xOffset = 0, _yOffset = 0, _fillAlpha = true) {
	//一些设定
	surface_set_target(_surf);
	gpu_set_colorwriteenable(false, false, false, true);
	gpu_set_blendenable(false);
	
	//填充透明
	if(_fillAlpha) {
		draw_set_alpha(0);
		draw_rectangle(0, 0, surface_get_width(_surf), surface_get_height(_surf),false);
	}
	
	//挖空
	draw_set_alpha(1);
	var vsin = dsin(-rot), vcos = dcos(-rot);
	var size = ds_list_size(listDivideIndex);
	for(var i = 0; i < size; i++) {	//遍历所有的三角
		var di = listDivideIndex[| i];
		draw_primitive_begin(pr_trianglelist);
		for(var j = 0; j < 3; j++) {
			var pos = listVertex[| di[j]];
			var resultx = pos[0] * vcos - pos[1] * vsin;
			var resulty = pos[0] * vsin + pos[1] * vcos;
			draw_vertex(x + _xOffset + resultx, y + _yOffset + resulty);
		}
		draw_primitive_end();
	}

	//恢复默认
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();
}

// 用于绘制边框，如果isAutoDrawBorder为true，则会自动调用
function drawBorder() {
	var vsin = dsin(-rot), vcos = dcos(-rot);
	for(var i = 0; i < ds_list_size(listVertex); i++) {
		var a = listVertex[| i], b = listVertex[| iloop(i + 1)];
		var ax = a[0] * vcos - a[1] * vsin;
		var ay = a[0] * vsin + a[1] * vcos;
		var bx = b[0] * vcos - b[1] * vsin;
		var by = b[0] * vsin + b[1] * vcos;
		
		draw_sprite_ext(spr_pixel,0,x + ax - 5*cos(degtorad(floor(point_direction(ax,ay,bx,by)))),y + ay + 5*sin(degtorad(floor(point_direction(ax,ay,bx,by)))),5,point_distance(ax,ay,bx,by)+5+5*cos(degtorad((point_direction(ax,ay,bx,by)%45))),point_direction(ax,ay,bx,by)+90,battle_board.color_frame,battle_board.alpha_frame);
	}
}
// 辅助函数，用于当_index超出边界时循环
// 因为都是稍微超出，所以只考虑了稍微超出时的情况
function iloop(_index, _list = listVertex) {
	if(_index >= ds_list_size(_list))
		return _index - ds_list_size(_list);
	if(_index < 0)
		return _index + ds_list_size(_list);
	return _index;
}