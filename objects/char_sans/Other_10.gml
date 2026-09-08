if(Player_GetPlot("sans") = 0){
	Dialog_Add(Lang_GetString("sans.0"));
	Dialog_Start();
	Player_SetPlot("sans",1);
}
else if(Player_GetPlot("sans") = 1){
	sans = Event_Create();
	Event_Choice(sans,Lang_GetString("sans.1"),function(result){
		if(result = 0){
			StartDialog(Lang_GetString("sans.2"));
			char_player.moveable = false;
		}
		else{
			Event_Stop(sans);
			Event_Delete(sans);
		}
	});
	Event_AddFunction(sans,function(){
		mask_index = -1;
		if(char_player.y < y + 9){
			char_player.move[DIR.UP] = 40;
			Anim_Create(char_player,"y",0,0,char_player.y,y+20-char_player.y,40);
		}
	},function(){
		return Anim_IsExists(char_player);
	});
	Event_CharMove(sans,char_sans,DIR.RIGHT,20);
	Event_CharMove(sans,char_sans,DIR.UP,70);
	Event_AddFunction(sans,function(){
		dir = DIR.DOWN;
		char_player.moveable = true;
		Player_SetPlot("sans",2);
		mask_index = spr_char_sans_down;
	})
	Event_Launch(sans);
}
else if(Player_GetPlot("sans") = 2){
	Dialog_Add(Lang_GetString("sans.3"));
	Dialog_Start();
}
else if(Player_GetPlot("sans") = 4){
	Dialog_Add(Lang_GetString("sans.4"));
	Dialog_Start();
	Player_SetPlot("sans",5);
}
else if(Player_GetPlot("sans") = 5){
	Dialog_Add(Lang_GetString("sans.5"));
	Dialog_Start();
}