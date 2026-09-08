event_inherited();

go = Event_Create();
if(read = 0)Event_Dialog(go,Lang_GetString("trigger.samsara"));
Event_AddFunction(go,function(){
	read = 1;
	fader.color=0;
	Fader_Fade(-1,1,20);
	char_player._moveable_warp=false;
	DelayFunction(function(){
		Flag_Set(FLAG_TEMP,"trigger_warp_landmark",landmark);
		Flag_Set(FLAG_TEMP,"trigger_warp_dir",char_player.dir);
		room_restart();
		fader.color=0;
		Fader_Fade(-1,0,20);
		DelayFunction(function(){
			with(trigger_samsara)read = 1;
			if(landmark = 1&&room = room_test_waterfall){
				with(char_bridgeseed){
					x = 490 - number*20;
					y = 410;
					state = 6;
					image_index = 6;
					var _list = ds_list_create();
					var _num = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, block, false, true, _list, false);
					for (var i = 0; i < _num; i++) {
						var _inst = _list[| i];
						if (_inst.object_index == block) {
							_inst.block_enabled = false;
							_inst.open = 1;
						}
					}
					ds_list_destroy(_list);
				}
			}
		},1);
	},20);
});
Event_Launch(go);