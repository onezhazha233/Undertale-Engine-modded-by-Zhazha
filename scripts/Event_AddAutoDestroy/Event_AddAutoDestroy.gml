function Event_AddAutoDestroy(EVENT){
	Event_AddFunction(EVENT,method({ee: EVENT},function(){
		Event_Delete(ee);
	}));
}