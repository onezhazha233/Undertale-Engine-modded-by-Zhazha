function StartDialog(TEXT){
	temp_event = Event_Create();
	Event_Dialog(temp_event,TEXT);
	Event_AddAutoDestroy(temp_event);
	Event_Push(temp_event);
	Event_Start(temp_event);
}