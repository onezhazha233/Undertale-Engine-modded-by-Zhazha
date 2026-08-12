//这个函数绘制输入的多边形
function Xpoly_Draw(points,pos_x,pos_y,rot_deg,scl_x,scl_y,org_x,org_y,is_debug=false,col_fill=c_white,col_debug=c_red){
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_in,buffer_seek_start,0)
	buffer_write(global.buf_in,buffer_u32,global.buf_cap)
	buffer_write(global.buf_in,buffer_f32,pos_x)
	buffer_write(global.buf_in,buffer_f32,pos_y)
	buffer_write(global.buf_in,buffer_f32,rot_deg)
	buffer_write(global.buf_in,buffer_f32,scl_x)
	buffer_write(global.buf_in,buffer_f32,scl_y)
	buffer_write(global.buf_in,buffer_f32,org_x)
	buffer_write(global.buf_in,buffer_f32,org_y)
	buffer_write(global.buf_in,buffer_u32,array_length(points));
	for(var i=0;i<array_length(points);i++){
		buffer_write(global.buf_in,buffer_f32,points[i][0]);
		buffer_write(global.buf_in,buffer_f32,points[i][1]);
	}

	Xpoly_Clear_Buffered_Polygons()

	triangulation(
		buffer_get_address(global.buf_in),
		buffer_get_address(global.buf_out)
	)

	Xpoly_Draw_Buffered_Polygons(is_debug,col_fill,col_debug)
}
