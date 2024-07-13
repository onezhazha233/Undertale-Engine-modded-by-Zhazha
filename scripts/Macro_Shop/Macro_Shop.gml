function Macro_Shop(){
	enum SHOP_STATE{
		MENU,
		DIALOG
	};
	
	enum SHOP_MENU{
		MENU,
		BUY,
		SELL,
		TALK,
		EXIT
	};
	
	enum SHOP_BUY{
		MENU,
		CONFIRM
	};
	
	enum SHOP_BUY_RESULT{
		NULL,
		YES,
		NO,
		NO_MONEY,
		NO_ROOM,
		UNABLE
	};
	
	enum SHOP_BUYABLE{
		BUYABLE=0,
		UNBUYABLE=1,
		SELLOUT=2
	};
	
	enum SHOP_SELL{
		MENU,
		CONFIRM
	};
	
	enum SHOP_SELL_RESULT{
		NULL,
		YES,
		NO,
		UNABLE
	};
	
	enum SHOP_SELLABLE{
		SELLABLE=0,
		UNSELLABLE=1
	};
	
	enum SHOP_HOST_EVENT{
		SHOP_INIT,
		MAIN_MENU_START,
		MENU_START,
		MENU_SWITCH,
		MENU_CHOICE_SWITCH,
		MENU_CONFIRM,
		DIALOG_START,
		DIALOG_END
	};
}