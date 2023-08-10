if(start = 1){
	time += 1;
	/*if(keyboard_check(ord("Q")))battle_board.alpha_frame += 0.01;
	if(keyboard_check(ord("W")))battle_board.alpha_frame -= 0.01;
	if(keyboard_check(ord("A")))battle_board.alpha_bg += 0.01;
	if(keyboard_check(ord("S")))battle_board.alpha_bg -= 0.01;*/
	
	//Controling alpha for test, just delete them
	if(time mod 20 = 0)Camera_Shake(4,4,2,2);
	battle_board.alpha_bg = 0.65;
	battle_board.alpha_frame = 0.5;
}