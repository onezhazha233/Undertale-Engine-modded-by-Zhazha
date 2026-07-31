///@arg amount
function Game_SetFrameSkip(AMOUNT){

	if(AMOUNT>=0){
		Flag_Set(FLAG_TEMP,"frame_skip", AMOUNT);
		return true;
	}else{
		return false;
	}
}
