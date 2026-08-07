event_inherited();

char_player.moveable = false;

Prompt_Add(Lang_GetString("ui.prompt.confirm"),PROMPT_POS.BOT_LEFT,20);
a = Prompt_Add(Lang_GetString("ui.prompt.confirm"),PROMPT_POS.MID_LEFT,20);
a.hold_enabled=true;
a.hold_duration=90;
a.hold_input=INPUT.DOWN

var _cancel=Prompt_Add(Lang_GetString("ui.prompt.cancel.hold"),PROMPT_POS.BOT_RIGHT,20);
_cancel.hold_enabled=true;
_cancel.hold_duration=50;