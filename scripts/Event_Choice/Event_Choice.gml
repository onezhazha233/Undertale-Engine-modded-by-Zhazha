function Event_Choice(EVENT,TEXT,RESULT){
	Event_AddFunction(EVENT,
	method(
	{
		TEXT: TEXT
	},
	function(){
		Dialog_Add(TEXT+"{choice_end}");
		Dialog_Start();
	}),
	method(
	{
		RESULT: RESULT,
		_resultCalled: false
	},
	function(){
		if(!Dialog_IsEmpty()||(instance_exists(ui_dialog)&&instance_exists(ui_dialog._inst))){
			return true;
		}
		else{
			if(!_resultCalled){
				RESULT(Player_GetTextTyperChoice());
				_resultCalled = true;
				return true;
			}
			return false;
		}
	}));
	
	return true;
}