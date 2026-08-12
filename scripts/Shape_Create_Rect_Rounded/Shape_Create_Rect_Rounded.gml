function Shape_Create_Rect_Rounded(w,h,r,resolution=16){
	var half_w = w/2.0;
	var half_h = h/2.0;

	// 1. 合法圆角半径限制（固定规则）
	var max_radius = min(w, h) * 0.5;
	r = clamp(r, 0, max_radius);

	// 2. 低参数降级为普通矩形
	if (r <= 0 || resolution <= 2) {
		return Shape_Create_Rect(w, h);
	}

	// 3. 用户标准正确圆心坐标
	var corner_tl_x = -half_w + r;  // 左上角圆角圆心x坐标
	var corner_tl_y = -half_h + r;  // 左上角圆角圆心y坐标
	var corner_tr_x = half_w - r;   // 右上角圆角圆心x坐标
	var corner_tr_y = -half_h + r;  // 右上角圆角圆心y坐标
	var corner_br_x = half_w - r;   // 右下角圆角圆心x坐标
	var corner_br_y = half_h - r;   // 右下角圆角圆心y坐标
	var corner_bl_x = -half_w + r;  // 左下角圆角圆心x坐标
	var corner_bl_y = half_h - r;   // 左下角圆角圆心y坐标

	var verts = [];
	var step = 90.0 / resolution;

	// ========== 核心修复：GM Y向下 标准顺时针圆角角度 ==========
	// 顺序：右上直边切点 → 右上圆角 → 右下圆角 → 左下圆角 → 左上圆角 → 闭环
	// 角度完全反向修正，杜绝飞镖自交

	// 1. 右上角圆角 (左上→右下 90°圆弧)
	// 起始：顶边平直端点 | 终止：右侧平直端点
	for(var i = 0; i <= resolution; i++){
		var ang = degtorad(-90 + step * i);
		var px = corner_tr_x + r * cos(ang);
		var py = corner_tr_y + r * sin(ang);
		verts[array_length(verts)] = [px,py];
	}

	// 2. 右下角圆角 (右上→左下 90°圆弧)
	for(var i = 0; i <= resolution; i++){
		var ang = degtorad(0 + step * i);
		var px = corner_br_x + r * cos(ang);
		var py = corner_br_y + r * sin(ang);
		verts[array_length(verts)] = [px,py];
	}

	// 3. 左下角圆角 (右下→左上 90°圆弧)
	for(var i = 0; i <= resolution; i++){
		var ang = degtorad(90 + step * i);
		var px = corner_bl_x + r * cos(ang);
		var py = corner_bl_y + r * sin(ang);
		verts[array_length(verts)] = [px,py];
	}

	// 4. 左上角圆角 (左下→右上 90°圆弧)
	for(var i = 0; i <= resolution; i++){
		var ang = degtorad(180 + step * i);
		var px = corner_tl_x + r * cos(ang);
		var py = corner_tl_y + r * sin(ang);
		verts[array_length(verts)] = [px,py];
	}

	return verts;
}