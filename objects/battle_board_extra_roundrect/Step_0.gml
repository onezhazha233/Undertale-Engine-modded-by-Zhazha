if(instance_exists(hrect)){
	hrect.angle = angle;
	hrect.up = size/2;
	hrect.down = size/2;
	hrect.left = (size-precision*2)/2;
	hrect.right = (size-precision*2)/2;
	hrect.x = x;
	hrect.y = y;
	hrect.angle = angle;
}
if(instance_exists(vrect)){
	vrect.angle = angle;
	vrect.up = (size-precision*2)/2;
	vrect.down = (size-precision*2)/2;
	vrect.left = size/2;
	vrect.right = size/2;
	vrect.x = x;
	vrect.y = y;
	vrect.angle = angle;
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