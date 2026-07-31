/// Menu Confirm — settlement already done in Shop_TryBuy/Sell
if(Shop_GetMenu()==SHOP_MENU.SELL){
	var sell_result=Shop_GetSellResult();
	switch(sell_result){
		case SHOP_SELL_RESULT.YES:
			Dialog_Add("* I'll take good care of it.");
			break;
	}
	Shop_SetSellResult(SHOP_SELL_RESULT.NULL);
}