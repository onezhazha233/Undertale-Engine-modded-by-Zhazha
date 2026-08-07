function Event_AddSleep(EVENT,DELAY){
	Event_AddFunction(EVENT,function(){},function(){return false;}, DELAY);
	
	return true;
}