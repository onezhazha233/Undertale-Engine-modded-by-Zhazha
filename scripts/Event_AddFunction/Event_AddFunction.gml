///@arg event
///@arg init
///@arg update* (continue when returns false)
///@arg delay* (after execution)
function Event_AddFunction(EVENT,INIT,UPDATE=function(){return false;},PAUSE=0){
	array_push(EVENT.functions,{init: INIT,update: UPDATE});
	array_push(EVENT.delays,PAUSE);
	
	return true;
}