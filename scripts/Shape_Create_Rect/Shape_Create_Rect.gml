function Shape_Create_Rect(w,h){
	var half_w = w/2.0;
	var half_h = h/2.0;
	
	//顶点，格式为[[x1,y1],[x2,y2],...]（局部坐标，中心在原点，顺时针）
	return [[half_w,half_h],[half_w,-half_h],[-half_w,-half_h],[-half_w,half_h]]
}

function Shape_Create_Rect_Ext(left,right,top,bottom){
	//顶点，格式为[[x1,y1],[x2,y2],...]（局部坐标，左上→右上→右下→左下）
	return [[left,top],[right,top],[right,bottom],[left,bottom]]
}