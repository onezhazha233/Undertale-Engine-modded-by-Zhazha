///@arg inst
///@arg text
function Typer_SetText() {
	var INST=argument[0];
	var TEXT=argument[1];
	with(INST){
		_clearing=true;
		event_user(3);
		_clearing=false;
		event_user(6);
		_callback_start_pend=false;
		text=TEXT;
		Typer_VoiceApply();
		if(text!=""){
			var m=Typer_Measure(text);
			_measure_w=m[0];
			_measure_h=m[1];
			height=_measure_h;
			_measured=true;
			Typer_Align();
			if(_mini_auto_layout){
				_mini_positions=Typer_MiniScan(text);
				_mini_pos_index=0;
			}
		}
		_segment_index=0;
		_callback_end_done=false;
		Typer_Callback(0);
	}
}
