alarm[0]=1;

var warp_landmark=Flag_Get(FLAG_TEMP,"trigger_warp_landmark",-1);
var warp_dir=Flag_Get(FLAG_TEMP,"trigger_warp_dir");

if(warp_landmark!=-1&&instance_exists(hint_landmark)){
	var lx=x;
	var ly=y;
	with(hint_landmark){
		if(landmark_id==warp_landmark){
			lx=x;
			ly=y;
		}
	}
	x=lx;
	y=ly;
}
if(warp_dir!=-1){
	dir=warp_dir;
}

Flag_Set(FLAG_TEMP,"trigger_warp_landmark",-1);
Flag_Set(FLAG_TEMP,"trigger_warp_dir",-1);