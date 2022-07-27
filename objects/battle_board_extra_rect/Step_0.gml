if(instance_exists(rect)){
	ds_list_clear(rect.listVertex);
	ds_list_add(
	rect.listVertex,
	[-left,-up],[right,-up],[right,down],[-left,down]
	);
	rect.rot = angle;
	rect.rotSpeed = rot;
	rect.x = x;
	rect.y = y;
}