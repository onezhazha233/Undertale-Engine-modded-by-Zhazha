///@arg menu
///@arg call_event*
function Shop_SetMenu(){
	var MENU=argument[0];
	var CALL=true;
	if(argument_count>=2){
		CALL=argument[1];
	}

	shop._menu=MENU;
	Shop_SetDialog("",false,false);
	Shop_SetDialog("",false,true);
	if(instance_exists(shop._inst_right_dialog)){
		instance_destroy(shop._inst_right_dialog);
	}
	if(instance_exists(shop._inst_menu_choice)){
		instance_destroy(shop._inst_menu_choice);
	}
	
	////////////////////////////////////////
	//主菜单
	if(MENU==SHOP_MENU.MENU){
		Shop_SetDialog(Shop_GetMenuDialog());
		shop._inst_menu_choice = instance_create_depth(480,260,0,text_typer);
		shop._inst_menu_choice.text = "{font 1}{space_y 4}{instant true}{scale 2}{shadow true}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}";
		for(i=0;i<4;i+=1){
			if(i = 1&&Item_GetNumber() = 0)shop._inst_menu_choice.text += "{color `gray`}";
			shop._inst_menu_choice.text += Lang_GetString("shop.menu.choice."+string(i))+"&";
			if(i = 1)shop._inst_menu_choice.text += "{color `white`}";
		}
		Shop_CallHostEvent(SHOP_HOST_EVENT.MAIN_MENU_START);
	}
	////////////////////////////////////////
	//购买
	if(MENU==SHOP_MENU.BUY){
		Shop_SetMenuBuy(0,shop._page_buy);
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
	}
	////////////////////////////////////////
	//出售
	if(MENU==SHOP_MENU.SELL){
		Shop_SetMenuSell(0);
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
	}
	////////////////////////////////////////
	//谈话
	if(MENU==SHOP_MENU.TALK){
		Shop_SetMenuTalk(shop._page_talk);
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
	}
	////////////////////////////////////////
	//离开
	if(MENU==SHOP_MENU.EXIT){
		Shop_End();
	}
}