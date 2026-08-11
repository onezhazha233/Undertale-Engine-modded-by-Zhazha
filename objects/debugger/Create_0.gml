depth=DEPTH_UI.DEBUG;

global.debug_busy=false;
global.debug_show_blocks=false;
global.debug_show_char_pos=false;

armed=false;
charge=0;
cur_key="";
hold_default=0.8;

feedback="";
feedback_time=0;
feedback_duration=0.5;

commands={};

commands[$ "1"]={
	name:"Restart Room",
	hold:0.6,
	run:function(){
		room_restart();
	}
};

commands[$ "2"]={
	name:"Restart Game",
	hold:0.7,
	run:function(){
		game_restart();
	}
};

commands[$ "3"]={
	name:"Cycle Speed",
	hold:0.4,
	run:function(){
		var spd=game_get_speed(gamespeed_fps);
		if(spd==60){
			game_set_speed(10,gamespeed_fps);
		}else if(spd==10){
			game_set_speed(3,gamespeed_fps);
		}else{
			game_set_speed(60,gamespeed_fps);
		}
	},
	tip:function(){
		return "Speed: "+string(game_get_speed(gamespeed_fps))+"FPS";
	}
};

commands[$ "4"]={
	name:"Stop Music",
	hold:0.5,
	run:function(){
		BGM_StopAll();
	}
};

commands[$ "r"]={
	name:"Room List",
	hold:0.5,
	run:function(){
		Debugger_ListOpenRoom();
	}
};

commands[$ "e"]={
	name:"Encounter List",
	hold:0.5,
	run:function(){
		Debugger_ListOpenEncounter();
	}
};

commands[$ "v"]={
	name:"Show Collision",
	hold:0.4,
	run:function(){
		global.debug_show_blocks=!global.debug_show_blocks;
	},
	tip:function(){
		return global.debug_show_blocks?"Collision: ON":"Collision: OFF";
	}
};

// only these objects get x/y labels when Tab+P is on
char_pos_list=[
	char_player,
	char_sign,
	char_save,
	char_box
];

commands[$ "p"]={
	name:"Show Char Pos",
	hold:0.4,
	run:function(){
		global.debug_show_char_pos=!global.debug_show_char_pos;
	},
	tip:function(){
		return global.debug_show_char_pos?"Char Pos: ON":"Char Pos: OFF";
	}
};

commands[$ "h"]={
	name:"Help",
	hold:0.3,
	run:function(){
		var dbg=instance_find(debugger,0);
		if(dbg==noone){
			exit;
		}
		var line="=== Debugger Help (hold Tab+key) ===";
		show_debug_message(line);
		show_debug_message("Lists: Up/Down select, Left/Right jump category, Z/Enter confirm");
		show_debug_message("Search: Up on first item or type; Down/Enter exit search");
		var keys=variable_struct_get_names(dbg.commands);
		array_sort(keys,true);
		for(var i=0;i<array_length(keys);i++){
			var k=keys[i];
			var cmd=dbg.commands[$ k];
			var hold=dbg.hold_default;
			if(variable_struct_exists(cmd,"hold")){
				hold=cmd.hold;
			}
			line="TAB+"+string_upper(k)+"  "+cmd.name+"  ("+string(hold)+"s)";
			show_debug_message(line);
		}
	}
};
