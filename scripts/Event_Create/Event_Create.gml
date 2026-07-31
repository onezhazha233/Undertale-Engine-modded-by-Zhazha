function Event_Create(){
	return {
	    functions: [],
	    delays: [],
	    currentIndex: 0,
	    timer: 0,
	    active: false,
	    paused: false,
	    lastCustomIndex: -1,
	    _room: room,
	};
}