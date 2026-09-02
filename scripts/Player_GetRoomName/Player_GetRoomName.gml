function Player_GetRoomName(ROOM){
	var name="";

	switch(ROOM){
		case -1:
			name="--";
			break;
			
		case room_test_main:
			name=Lang_GetString("room.test_main.name");
			break;
	}
	return name;
}
