function Event_Create(PERSISTENT=false){
	return {
	    functions: [],
	    delays: [],
	    currentIndex: 0,
	    timer: 0,
	    active: false,
	    paused: false,
	    lastCustomIndex: -1,
		persistent_room : PERSISTENT,
	    _room: room,
	};
}