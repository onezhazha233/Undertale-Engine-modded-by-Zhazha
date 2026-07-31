function DelayFunction(FUNCTION,DELAY){
	e = Event_Create();
	Event_AddSleep(e,DELAY);
	Event_AddFunction(e,FUNCTION);
	Event_AddAutoDestroy(e);
	Event_Push(e);
	Event_Start(e);
	
	return e;
}