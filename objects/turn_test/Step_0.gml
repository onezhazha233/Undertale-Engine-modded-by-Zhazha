if(start = 1){
	time += 1;
	if(time > 1){
		aa.rot += 1;
	}
	if(time = 10){
		bb = Battle_CreateBoardExtraRect(200,200,40,40,30,1);
	}
	if(time = 60){
		instance_destroy(bb);
	}
}