//这个函数将对输入的多边形进行布尔序列运算，计算出完整的合法边界，并储存在buf_out里
//随后便可调用Xpoly_Collision_Check来对决心进行碰撞检测
function XPoly_Booleanation(objs){
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_in,buffer_seek_start,0);
	buffer_write(global.buf_in,buffer_u32, global.buf_cap)  //[buffer capacity]
	buffer_write(global.buf_in,buffer_u32, array_length(objs) ); //  [polygon count]
	
	for(var i=0;i<array_length(objs);i++){
		// [pos.x] [pos.y] [rot.deg] [scale.x] [scale.y] [org.x] [org.y] [PointCount] PointCount*[Points]
		var obj_current = objs[i];
		buffer_write(global.buf_in,buffer_u32, obj_current.type) //[type]
		buffer_write(global.buf_in,buffer_f32, obj_current.x) //[pos_x]
		buffer_write(global.buf_in,buffer_f32, obj_current.y) //[pos_y]
		buffer_write(global.buf_in,buffer_f32, obj_current.image_angle) //[rot_deg]
		buffer_write(global.buf_in,buffer_f32, obj_current.image_xscale) //[scale_x]
		buffer_write(global.buf_in,buffer_f32, obj_current.image_yscale) //[scale_y]
		buffer_write(global.buf_in,buffer_f32, obj_current.org_x) //[org_x]
		buffer_write(global.buf_in,buffer_f32, obj_current.org_y) //[org_y]
		//优先用 collision_vertices（碰撞专用顶点），否则退回 vertices
		var _verts = obj_current.vertices;
		if(variable_instance_exists(obj_current, "collision_vertices")){
			var _cv = obj_current.collision_vertices;
			if(is_array(_cv) && array_length(_cv)>=2) _verts = _cv;
		}
		buffer_write(global.buf_in,buffer_u32, array_length(_verts)) //[point_count]
		//points 格式为[[x1,y1],[x2,y2],...]
		for(var j=0;j<array_length(_verts);j++){
			buffer_write(global.buf_in,buffer_f32,_verts[j][0])
			buffer_write(global.buf_in,buffer_f32,_verts[j][1])
		}
	}

	booleanation(
		buffer_get_address(global.buf_in),
		buffer_get_address(global.buf_out)
	)
}