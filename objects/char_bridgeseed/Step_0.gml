event_inherited();

if(speed > 0){
	Check();
}

if(state = 5){
	var _list = ds_list_create();
	var _num = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, block, false, true, _list, false);
	for (var i = 0; i < _num; i++) {
		var _inst = _list[| i];
		if (_inst.object_index == block) {
			_inst.block_enabled = false;
			_inst.open = 1;
		}
	}
	ds_list_destroy(_list);
	
	state = 6;
}