if(start = 1){
	time += 1;
	if(time = 1){
		krs = [1,2,6,10];
		for(i=0;i<4;i+=1){
			a = instance_create_depth(320-50*1.5+i*50,290,0,battle_bullet_test_kr);
			a.kr = krs[i];
			a = instance_create_depth(320-50*1.5+i*50,300,0,battle_bullet_test_kr);
			a.kr = krs[i];
		}
	}
}