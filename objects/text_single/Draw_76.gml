switch(effect){
	case -1:
		_offset_x=0;
		_offset_y=0;
		break;
		
	case 0:
		if(_effect_shook){
			_offset_x=floor(random_range(-1,1));
			_offset_y=floor(random_range(-1,1));
		}
		_effect_shook=!_effect_shook;
		break;
		
	case 1:
		_offset_x = floor(lengthdir_x(1.5,typer.torder[order mod 10]));
		_offset_y = floor(lengthdir_y(1.5,typer.torder[order mod 10]));
		break;
}