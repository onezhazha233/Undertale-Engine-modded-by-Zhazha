///@arg menu_0_for_menu_1_for_confirm
///@arg *page
function Shop_SetMenuBuy(){
	var MENU = argument[0];
	var PAGE = 0;
	if(argument_count >= 2){
		PAGE = argument[1];
	}
	
	shop._menu_buy = MENU;
	
	if(MENU = 0){
		//更新文字
		var text="";
		for(i=PAGE*4;i<PAGE*4+4;i+=1){
			if(i < ds_list_size(shop._host_buy)){
				if!(Shop_GetBuyBuyable(i) = SHOP_BUYABLE.SELLOUT){
					text += string(Shop_GetBuyPrice(i))+"G - "+string(Shop_GetBuyName(i))+"&";
				}
				else{
					text += string(Shop_GetBuyName(i))+"&";
				}
			}
			else{
				text += "&";
			}
		}
		text += Lang_GetString("shop.menu.exit");
		if(Shop_GetBuyPageMax() > 1)text += "                      "+"{define `PAGE` `"+string(PAGE)+"`}"+Lang_GetString("shop.menu.page");
		Shop_SetDialog(text,true);
	}
	else{
		_right_dialog = "{choice_switch_direction 1}{choice_switch_sound false}{instant true}{define `PRICE` `"+string(Shop_GetBuyPrice(shop._page_buy*4+shop._buy_choice))+"`}{font 1}{space_y 4}{scale 2}{speed 2}{shadow true}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}"+Lang_GetString("shop.menu.buy.confirm");
		Shop_SetRightDialog(_right_dialog);
	}
	return true;
}