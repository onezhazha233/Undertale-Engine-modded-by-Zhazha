function Event_Launch(EVENT){
	Event_AddAutoDestroy(EVENT);
	Event_Push(EVENT);
	Event_Start(EVENT);
}