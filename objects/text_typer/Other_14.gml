///@desc Update Position
if x != xprevious || y != yprevious || _angle_previous != _angle
{
	var INST;
	var X_UNIT = [lengthdir_x(1, _angle*(_type_dir=0 ? 1 : -1)), lengthdir_y(1, _angle*(_type_dir=0 ? 1 : -1))];
	var Y_UNIT = [lengthdir_x(1, (_angle - 90)*(_type_dir=0 ? 1 : -1)), lengthdir_y(1, (_angle - 90)*(_type_dir=0 ? 1 : -1))];
	
	for (var PROC = 0; PROC < ds_list_size(_list_inst); PROC ++){
		INST = _list_inst[| PROC];
		if instance_exists(INST)
		{
			with INST
			{
				if(other._angle_follow)angle = other._angle;
				if(other._position_follow)other.CharUpdate(id);
				_xUnit = X_UNIT;
				_yUnit = Y_UNIT;
				
			}
		}
	}
	
	if instance_exists(_face) && !_face_linked
	{
		_face.x += x - xprevious;
		_face.y += y - yprevious;
		_face.image_angle = _angle;
	}
	
	/* Don't be silly
	xprevious = x;
	yprevious = y;
	*/
	_angle_previous = _angle;
}
/*live;
///@desc Update Position
if(x!=xprevious||y!=yprevious||_angle_previous!=_angle){
	var CHANGE_X=x-xprevious;
	var CHANGE_Y=y-yprevious;
	var CHANGE_ANGLE=_angle-_angle_previous;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		if(instance_exists(INST)){
			with(INST){
				x+=CHANGE_X;
				y+=CHANGE_Y;
				if(other._angle_follow=1)angle+=CHANGE_ANGLE;
				x=RotateXY(x,y,other.x,other.y,CHANGE_ANGLE)[0];
				y=RotateXY(x,y,other.x,other.y,CHANGE_ANGLE)[1];
			}
		}
		proc+=1;
	}
	if(instance_exists(_face)&&!_face_linked){
		_face.x+=CHANGE_X;
		_face.y+=CHANGE_Y;
	}
	xprevious=x;
	yprevious=y;
	_angle_previous=_angle;
}