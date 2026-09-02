event_inherited();

char_player.moveable = false;
camera.target = noone;
cx = camera.x;
cy = camera.y;
Anim_Create(camera,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,cx,-cx,30);
Anim_Create(camera,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,cy,-cy,30);

Prompt_Add(Lang_GetString("ui.prompt.move"),PROMPT_POS.BOT_LEFT,20);
Prompt_Add(Lang_GetString("ui.prompt.confirm"),PROMPT_POS.MID_LEFT,20);

var _cancel=Prompt_Add(Lang_GetString("ui.prompt.cancel.hold"),PROMPT_POS.BOT_RIGHT,20);
_cancel.hold_enabled=true;
_cancel.hold_duration=50;

if(char_prompt_test_screen.surf_xscale = 0){
	char_prompt_test_screen.ScreenOn();
}

controlling = true
control_delay = 30

if(instance_exists(pause_typer)){
	instance_destroy(pause_typer)
	pause_typer = noone
}
paused = false
pause_blink_timer = 30
pause_blink_on = true

/*
Prompt_Add(Lang_GetString("ui.prompt.confirm"),PROMPT_POS.BOT_LEFT,20);
a = Prompt_Add(Lang_GetString("ui.prompt.confirm"),PROMPT_POS.MID_LEFT,20);
a.hold_enabled=true;
a.hold_duration=90;
a.hold_input=INPUT.DOWN

var _cancel=Prompt_Add(Lang_GetString("ui.prompt.cancel.hold"),PROMPT_POS.BOT_RIGHT,20);
_cancel.hold_enabled=true;
_cancel.hold_duration=50;