function Event_Start(EVENT){
	with(EVENT){
		currentIndex = 0;
		timer = 0;
		active = true;
		paused = false;
		lastCustomIndex = -1;
		//Re-bind the event to the room it is started in, so a restarted or reused event
		//is not deactivated by the room check on its first step.
		_room = room;
	}

	return true;
}
