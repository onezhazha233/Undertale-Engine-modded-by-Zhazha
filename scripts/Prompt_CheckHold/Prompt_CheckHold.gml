function Prompt_CheckHold(_pos){
	var _id=Prompt_FindPos(_pos);
	if(!instance_exists(_id)){
		return false;
	}
	if(!_id.hold_enabled){
		return Input_IsPressed(_id.hold_input);
	}
	if(_id._hold_pending){
		_id._hold_pending=false;
		return true;
	}
	return false;
}
