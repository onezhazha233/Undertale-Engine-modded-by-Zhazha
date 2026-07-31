function Event_Start(EVENT){
	with(EVENT){
		currentIndex = 0;
	    timer = 0;
	    active = true;
	    paused = false;
	    lastCustomIndex = -1;
	}
	
	return true;
}