function Player_GetRoomName(ROOM){
	var name="";

	switch(ROOM){
		case -1:
			name="--";
			break;
			
		case room_area_0:
			name="Area 0";
			break;
	}
	return name;
}
