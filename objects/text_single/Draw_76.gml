switch(effect){
	case -1:
		_offset_x=0;
		_offset_y=0;
		break;
		
	case 0:
		if(_effect_shook){
			_offset_x=random_range(-1,1);
			_offset_y=random_range(-1,1);
		}
		_effect_shook=!_effect_shook;
		break;
	
	case 1:
		var xoff = lengthdir_x(1.5,_parent.torder[_line_order mod 10]);
		var yoff = lengthdir_y(1.5,_parent.torder[_line_order mod 10]);
		if(!gui){
			xoff = floor(xoff);
			yoff = floor(yoff);
		}
		_offset_x = xoff;
		_offset_y = yoff;
		break;
}