//这个函数读取Booleanation产生的合法边界，输入灵魂的位置，碰撞半径（是的，灵魂是圆形的碰撞范围），重力角度
//返回  本帧(_x,_y)是否出框(is_inside)，
//	   本次出框是普通的撞墙(AKA is_slide=true)，还是强制被卡到了最近的合法位置(is_slide),
//     被挤回框的新位置，天花板地板检测...
function Xpoly_Collision_Check(_x,_y,_radius,gravity_angle){
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_in,buffer_seek_start,0)
	buffer_write(global.buf_in,buffer_u32, global.buf_cap)
	buffer_write(global.buf_in,buffer_f32,_x)
	buffer_write(global.buf_in,buffer_f32,_y)
	buffer_write(global.buf_in,buffer_f32,_radius)
	buffer_write(global.buf_in,buffer_f32,gravity_angle)
	
	buffer_seek(global.buf_out,buffer_seek_start,0)
	buffer_write(global.buf_out,buffer_u32,global.buf_cap);

	collisionCheck(
		buffer_get_address(global.buf_in),
		buffer_get_address(global.buf_out)
	);
	
	buffer_seek(global.buf_out,buffer_seek_start,4)
	
	var is_inside =buffer_read(global.buf_out,buffer_u32)
	var is_slide = buffer_read(global.buf_out,buffer_u32)
	var touching_ceiling =buffer_read(global.buf_out,buffer_u32)
	var touching_floor = buffer_read(global.buf_out,buffer_u32)
	var new_x =buffer_read(global.buf_out,buffer_f32)
	var new_y =buffer_read(global.buf_out,buffer_f32)
	var result = [is_inside, is_slide, touching_ceiling, touching_floor, new_x, new_y];
	//newX,newY是灵魂被钳制进框的位置
	
	return result;
}