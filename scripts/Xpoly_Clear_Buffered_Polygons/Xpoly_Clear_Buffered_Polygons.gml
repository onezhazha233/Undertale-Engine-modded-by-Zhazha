

function Xpoly_Clear_Buffered_Polygons(){
	
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_out,buffer_seek_start,0)
	buffer_write(global.buf_out,buffer_u32,global.buf_cap)
	buffer_write(global.buf_out,buffer_u32,0)
}