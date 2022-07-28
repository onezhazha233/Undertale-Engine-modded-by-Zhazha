if(start = 1){
	time += 1;
	if(time > 1){
		aa.rot += 1;
	}
	if(time = 30){
		Battle_CreateBoardCover(320,320,30,30,20,20,0);
		Battle_CreateBoardCover(320,320,20,20,30,30,0);
	}
}