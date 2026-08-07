///@desc Group & Macro
_map_macro[$ "true"]=true;
_map_macro[$ "false"]=false;

_map_macro[$ "DIR.UP"]=DIR.UP;
_map_macro[$ "DIR.DOWN"]=DIR.DOWN;
_map_macro[$ "DIR.LEFT"]=DIR.LEFT;
_map_macro[$ "DIR.RIGHT"]=DIR.RIGHT;

_map_macro[$ "FONT.DIALOG"]=0;
_map_macro[$ "FONT.MENU"]=1;
_map_macro[$ "FONT.BATTLE"]=2;

_map_macro[$ "VOICE.NULL"]=-1;
_map_macro[$ "VOICE.DEFAULT"]=0;
_map_macro[$ "VOICE.TYPER"]=1;

Lang_BindTyperGroup(0,"dialog");
Lang_BindTyperGroup(1,"menu");
Lang_BindTyperGroup(2,"battle");

VoicePack(0,{sounds: [snd_text_voice_default]});
VoicePack(1,{sounds: [snd_text_voice_typer]});
VoicePack(2,{sounds: [snd_text_voice_toriel]});
VoicePack(3,{sounds: [snd_text_voice_asgore]});

/*var arr=[];
for(i=0;i<9;i+=1){
	arr[i]=asset_get_index("snd_text_voice_tenna_"+string(i));
}
VoicePack(3,{sounds: arr, pitch: function(){ return 0.86 + random(0.35); }});

arr=[];
for(i=0;i<3;i+=1){
	arr[i]=asset_get_index("snd_text_voice_flowery_"+string(i));
}
VoicePack(4,{sounds: arr, pitch: function(){ return 0.9 + random(0.15); }});*/

_group_face[0]=face;
/*_group_face[1]=face_virel;
_group_face[2]=face_flowey;
_group_face[3]=face_pharaoh;*/