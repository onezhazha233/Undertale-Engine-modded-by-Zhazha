function Prompt_GetPos(_pos){
	switch(_pos){
		case PROMPT_POS.BOT_LEFT:
			return [10, 445];
		case PROMPT_POS.MID_LEFT:
			return [10, 410];
		case PROMPT_POS.TOP_LEFT:
			return [10, 375];
		case PROMPT_POS.BOT_RIGHT:
			return [632, 445];
		case PROMPT_POS.MID_RIGHT:
			return [632, 410];
		case PROMPT_POS.TOP_RIGHT:
			return [632, 375];
		default:
			show_debug_message("unknown pos!");
			return [10, 410];
	}
}

function Prompt_IsRightPos(_pos){
	return (_pos==PROMPT_POS.BOT_RIGHT||_pos==PROMPT_POS.MID_RIGHT||_pos==PROMPT_POS.TOP_RIGHT);
}
