///@desc Group & Macro
_macro[$ "true"]=true;
_macro[$ "false"]=false;

_macro[$ "DIR.UP"]=DIR.UP;
_macro[$ "DIR.DOWN"]=DIR.DOWN;
_macro[$ "DIR.LEFT"]=DIR.LEFT;
_macro[$ "DIR.RIGHT"]=DIR.RIGHT;

_macro[$ "FONT.DIALOG"]=0;
_macro[$ "FONT.MENU"]=1;
_macro[$ "FONT.BATTLE"]=2;

_macro[$ "VOICE.NULL"]=-1;
_macro[$ "VOICE.DEFAULT"]=0;
_macro[$ "VOICE.TYPER"]=1;

Typer_BindGroup(0,"dialog");
Typer_BindGroup(1,"menu");
Typer_BindGroup(2,"battle");
Typer_BindGroup(3,"sans");
Typer_BindGroup(4,"papyrus");
Typer_BindGroup(5,"sans_battle");
Typer_BindGroup(6,"papyrus_battle");

Typer_BindVoice(0,snd_text_voice_default);
Typer_BindVoice(1,snd_text_voice_typer);
Typer_BindVoice(2,snd_text_voice_toriel);
Typer_BindVoice(3,snd_text_voice_asgore);
Typer_BindVoice(4,{sounds:[snd_text_voice_sans],stop:false});
Typer_BindVoice(5,{sounds:[snd_text_voice_papyrus],stop:false});

_group_face[0]=face;
