function DelayFunction(FUNCTION,DELAY){
	var e = Event_Create();
	Event_AddSleep(e,DELAY);
	Event_AddFunction(e,FUNCTION);
	Event_Launch(e);
	
	return e;
}