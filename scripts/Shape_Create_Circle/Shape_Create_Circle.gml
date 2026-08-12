function Shape_Create_Circle(radius, resolution=16){
	var result = []
	for(var i=0;i<resolution;i++){
		//顶点，格式为[[x1,y1],[x2,y2],...]
		array_push(result,[cos(2*pi*i/resolution)*radius,sin(2*pi*i/resolution)*radius])
	}
	return result;
}