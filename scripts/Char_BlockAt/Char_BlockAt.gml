function Char_BlockAt(step_x,step_y){
	if(!collision){
		return false;
	}
	ds_list_clear(_collision_list);
	var _count=instance_place_list(x+step_x,y+step_y,block,_collision_list,false);
	var _i=0;
	repeat(_count){
		if(_collision_list[|_i].block_enabled){
			return true;
		}
		_i+=1;
	}
	return false;
}