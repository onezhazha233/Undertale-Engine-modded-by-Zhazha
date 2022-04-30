if(instance_exists(hrect)){
	hrect.angle = angle;
	ds_list_clear(hrect.listVertex);
	ds_list_add(
	hrect.listVertex,
	[-size/2,-(size-precision*2)/2],[size/2,-(size-precision*2)/2],[size/2,(size-precision*2)/2],[-size/2,(size-precision*2)/2]
	);
	hrect.x = x;
	hrect.y = y;
	hrect.rot = angle;
}
if(instance_exists(vrect)){
	vrect.angle = angle;
	ds_list_clear(vrect.listVertex);
	ds_list_add(
	vrect.listVertex,
	[-(size-precision*2)/2,-size/2],[(size-precision*2)/2,-size/2],[(size-precision*2)/2,size/2],[-(size-precision*2)/2,size/2]
	);
	vrect.x = x;
	vrect.y = y;
	vrect.rot = angle;
}
if(instance_exists(circle_0)){
	circle_0.radius = precision;
	circle_0.x = x + lengthdir_x(((size-precision*2)/2)*1.414,angle+45) - 1;
	circle_0.y = y + lengthdir_y(((size-precision*2)/2)*1.414,angle+45) - 1;
}
if(instance_exists(circle_1)){
	circle_1.radius = precision;
	circle_1.x = x + lengthdir_x(((size-precision*2)/2)*1.414,angle+45+90*1) - 1;
	circle_1.y = y + lengthdir_y(((size-precision*2)/2)*1.414,angle+45+90*1) - 1;
}
if(instance_exists(circle_2)){
	circle_2.radius = precision;
	circle_2.x = x + lengthdir_x(((size-precision*2)/2)*1.414,angle+45+90*2) - 1;
	circle_2.y = y + lengthdir_y(((size-precision*2)/2)*1.414,angle+45+90*2) - 1;
}
if(instance_exists(circle_3)){
	circle_3.radius = precision;
	circle_3.x = x + lengthdir_x(((size-precision*2)/2)*1.414,angle+45+90*3) - 1;
	circle_3.y = y + lengthdir_y(((size-precision*2)/2)*1.414,angle+45+90*3) - 1;
}