event_user(0);

_camera=camera_create_view(x,y,width/scale_x,height/scale_y,angle,target,-1,-1,width/scale_x/2,height/scale_y/2);

SetTarget = function(inst){
	if(instance_exists(inst)){
		target=inst.id;
	}
	else{
		target=noone;
	}
}