function Event_CharMove(EVENT,CHAR,DIRECTION,DURATION){
	Event_AddFunction(EVENT,
	method(
	{
		CHAR: CHAR,
		DIRECTION: DIRECTION,
		DURATION: DURATION
	},
	function(){
		CHAR.move[DIRECTION] = DURATION;
	}),
	method(
	{
		CHAR: CHAR,
		DIRECTION: DIRECTION
	},
	function(){
		return !(CHAR.move[DIRECTION]=0);
	}));
	
	return true;
}