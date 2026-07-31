/// MENU_START — right-side tips / buy-sell-take feedback
var shop_menu=Shop_GetMenu();

if(shop_menu==SHOP_MENU.BUY&&Shop_GetMenuBuy()==SHOP_BUY.MENU){
	var result=Shop_GetBuyResult();
	var take=Shop_IsBuyFree();
	var tip="";
	if(!take){
		tip=Lang_GetString("shop.demo.menu.buy","* Pick something you like.");
		switch(result){
			case SHOP_BUY_RESULT.YES:
				tip=Lang_GetString("shop.demo.menu.buy.yes","* Pleasure doing business!");
				break;
			case SHOP_BUY_RESULT.NO:
				tip=Lang_GetString("shop.demo.menu.buy.no","* Changed your mind? No problem.");
				break;
			case SHOP_BUY_RESULT.NO_MONEY:
				tip=Lang_GetString("shop.demo.menu.buy.nomoney","* You don't have enough G...");
				break;
			case SHOP_BUY_RESULT.NO_ROOM:
				tip=Lang_GetString("shop.demo.menu.buy.noroom","* Your inventory is full!");
				break;
			case SHOP_BUY_RESULT.UNABLE:
				tip=Lang_GetString("shop.demo.menu.buy.unable","* This item is locked for now.");
				break;
			case SHOP_BUY_RESULT.SOLD_OUT:
				tip=Lang_GetString("shop.demo.menu.buy.sellout","* That item's sold out.");
				break;
		}
	}else{
		tip=Lang_GetString("shop.demo.menu.take","* Go ahead, take it.");
		switch(result){
			case SHOP_BUY_RESULT.YES:
				tip=Lang_GetString("shop.demo.menu.take.yes","* You took it.");
				break;
			case SHOP_BUY_RESULT.NO:
				tip=Lang_GetString("shop.demo.menu.take.no","* You left it behind.");
				break;
			case SHOP_BUY_RESULT.NO_ROOM:
				tip=Lang_GetString("shop.demo.menu.take.noroom","* You can't carry any more.");
				break;
			case SHOP_BUY_RESULT.UNABLE:
				tip=Lang_GetString("shop.demo.menu.take.unable","* You can't take this.");
				break;
			case SHOP_BUY_RESULT.SOLD_OUT:
				tip=Lang_GetString("shop.demo.menu.take.sellout","* It's all gone.");
				break;
		}
	}
	if(tip!="")Shop_SetRightDialog(tip);
	Shop_SetBuyResult(SHOP_BUY_RESULT.NULL);
}

if(shop_menu==SHOP_MENU.TALK){
	Shop_SetRightDialog(Lang_GetString("shop.demo.menu.talk","* Got something to say?"));
}