///@desc Update Position
if(x!=xprevious||y!=yprevious){
	var CHANGE_X=x-xprevious;
	var CHANGE_Y=y-yprevious;
	// 脸始终按差值跟随（无论 follow 与否）
	if(instance_exists(_face)&&!_face_linked){
		_face.x+=CHANGE_X;
		_face.y+=CHANGE_Y;
	}
	// 未开启 follow 时，字符按差值平移
	if(!(_position_follow||_angle_follow)){
		var proc=0;
		repeat(ds_list_size(_list_inst)){
			var INST=ds_list_find_value(_list_inst,proc);
			if(instance_exists(INST)){
				with(INST){
					x+=CHANGE_X;
					y+=CHANGE_Y;
				}
				INST.depth=depth;
			}
			proc+=1;
		}
	}
	xprevious=x;
	yprevious=y;
}

// follow/angle 模式：每帧按相对偏移绝对重算（含旋转），即使打字机未移动也执行
if(_position_follow||_angle_follow){
	if(!ds_exists(_list_inst,ds_type_list)) exit;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			var rot=RotateXY(x+INST._deltaX, y+INST._deltaY, x, y, _angle);
			INST.x=rot[0];
			INST.y=rot[1];
			if(_angle_follow){
				INST.angle=_angle;
			}
			INST.depth=depth;
		}
		proc+=1;
	}
}