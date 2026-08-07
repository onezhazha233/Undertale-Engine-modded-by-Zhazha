function StartDialog(TEXT){
	var temp_event = Event_Create();
	Event_Dialog(temp_event,TEXT);
	Event_Launch(temp_event);
}