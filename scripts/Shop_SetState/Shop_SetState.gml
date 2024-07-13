///@arg state
///@arg main_menu
function Shop_SetState(){
	var STATE=argument[0];
	var MAIN=false;
	if(argument_count >= 2){
		MAIN = argument[1];
	}

	shop._state=STATE;

	//主菜单
	if(STATE==SHOP_STATE.MENU){
		if(MAIN = 1){
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
			Shop_SetMenu(SHOP_MENU.MENU,false);
		}
	}
	if(STATE==SHOP_STATE.DIALOG){
		//show_message("dialog:"+Dialog_Get())
		//Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
	}
}