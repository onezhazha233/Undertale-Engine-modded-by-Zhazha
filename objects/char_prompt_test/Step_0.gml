event_inherited();

if(Prompt_CheckHold(PROMPT_POS.BOT_RIGHT)){
	Prompt_ClearAll(false,20);
	DelayFunction(function(){
		char_player.moveable = true;
	},20);
}