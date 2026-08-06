/// Menu Confirm — settlement already done in Shop_TryBuy/Sell
if(Shop_GetMenu()==SHOP_MENU.SELL){
	var sell_result=Shop_GetSellResult();
	switch(sell_result){
		case SHOP_SELL_RESULT.YES:
			li = Shop_GetLastSellItem();
			if(li = item_stick){
				Dialog_Add("* no");
				Item_Insert(0,li);
				Player_AddGold(-Item_GetPriceSell(li));
				shop._sell_thanks-=1;
				audio_stop_sound(snd_shop_item);
			}
			break;
	}
	Shop_SetSellResult(SHOP_SELL_RESULT.NULL);
}