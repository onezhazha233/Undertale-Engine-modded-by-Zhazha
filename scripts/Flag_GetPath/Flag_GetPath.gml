function Flag_GetPath(TYPE){
	var result="./"+GAME_SAVE_NAME+"./flag/";
	switch(TYPE){
		case FLAG_STATIC:
		case FLAG_DYNAMIC:
		case FLAG_INFO:
		case FLAG_PLOT:
			result+=string(Flag_GetSlot())+"/"+TYPE;
			break;
		case FLAG_SETTINGS:
			result+="settings";
			break;
		case FLAG_DEMO:
			result+="demo/"+string(Flag_GetSlot());
			break;
		
		default:
			result="";
			break;
	}

	return result;
}
