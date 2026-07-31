function Macro_Shop() {
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

	/// Main-menu slot actions. TAKE = BUY + free; STEAL/READ = DIALOG (effects via typer cmds).
	enum SHOP_MAIN_ACTION{
		BUY,
		SELL,
		TALK,
		EXIT,
		DIALOG
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
		UNABLE,
		SOLD_OUT
	};

	enum SHOP_BUYABLE{
		BUYABLE=0,   // can buy / take (free)
		UNBUYABLE=1, // locked or display; host may later SetBuyBuyable → BUYABLE
		SELLOUT=2    // stock empty; still listed
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
