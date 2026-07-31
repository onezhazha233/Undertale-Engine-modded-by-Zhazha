var shop_state=Shop_GetState();
var shop_menu=Shop_GetMenu();
var shop_menu_buy=Shop_GetMenuBuy();
var shop_menu_sell=Shop_GetMenuSell();

if(shop_state==SHOP_STATE.MENU){
	if(shop_menu==SHOP_MENU.MENU){
		if(Input_IsPressed(INPUT.DOWN)){
			_menu_choice=(_menu_choice>2 ? 0 : _menu_choice+1);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
		}
		if(Input_IsPressed(INPUT.UP)){
			_menu_choice=(_menu_choice<1 ? 3 : _menu_choice-1);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
		}
		if(Input_IsPressed(INPUT.CONFIRM)){
			var act=Shop_GetMainAction(_menu_choice);
			switch(act){
				case SHOP_MAIN_ACTION.BUY:
					Shop_SetBuyFree(Shop_GetMainFree(_menu_choice));
					Shop_SetNextMenu(SHOP_MENU.BUY);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					Shop_SetState(SHOP_STATE.DIALOG);
					_dialog_pending=true;
					_buy_choice=0;
					break;
				case SHOP_MAIN_ACTION.SELL:
					Shop_SetNextMenu(SHOP_MENU.SELL);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					Shop_SetState(SHOP_STATE.DIALOG);
					_dialog_pending=true;
					_sell_choice=0;
					_sell_thanks=0;
					break;
				case SHOP_MAIN_ACTION.TALK:
					Shop_SetNextMenu(SHOP_MENU.TALK);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					Shop_SetState(SHOP_STATE.DIALOG);
					_dialog_pending=true;
					_talk_choice=0;
					break;
				case SHOP_MAIN_ACTION.DIALOG:
					// Same pattern as sell-empty refuse: text then back to main
					var dd=Shop_GetMainDialog(_menu_choice);
					if(dd!="")Dialog_Add(dd);
					Shop_SetNextMenu(SHOP_MENU.MENU);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					Shop_SetState(SHOP_STATE.DIALOG);
					_dialog_pending=true;
					break;
				case SHOP_MAIN_ACTION.EXIT:
					Shop_SetNextMenu(SHOP_MENU.EXIT);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					Shop_SetState(SHOP_STATE.DIALOG);
					_dialog_pending=true;
					break;
			}
		}
	}

	if(shop_menu==SHOP_MENU.BUY){
		if(shop_menu_buy==SHOP_BUY.MENU){
			if(Input_IsPressed(INPUT.CANCEL)||(Input_IsPressed(INPUT.CONFIRM)&&_buy_choice==4)){
				Shop_SetNextMenu(SHOP_MENU.MENU);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				Shop_SetState(SHOP_STATE.DIALOG);
				_dialog_pending=true;
				_menu_buy=-1;
			}
			if(Input_IsPressed(INPUT.DOWN)){
				_buy_choice=(_buy_choice>3 ? 0 : _buy_choice+1);
				if(_page_buy>Shop_GetBuyNumber() div 4-1&&Shop_GetBuyNumber() mod 4==_buy_choice){
					for(var i=0;i<4-(Shop_GetBuyNumber() mod 4);i+=1)_buy_choice+=1;
				}
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
			}
			if(Input_IsPressed(INPUT.UP)){
				_buy_choice=(_buy_choice<1 ? 4 : _buy_choice-1);
				if(_page_buy>Shop_GetBuyNumber() div 4-1&&_buy_choice==3){
					for(var i=0;i<4-(Shop_GetBuyNumber() mod 4);i+=1)_buy_choice-=1;
				}
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
			}
			if(Shop_GetBuyPageMax()>1&&_buy_choice<4){
				if(Input_IsPressed(INPUT.RIGHT)){
					_page_buy=(_page_buy>Shop_GetBuyNumber() div 4-1 ? 0 : _page_buy+1);
					if(_page_buy>Shop_GetBuyNumber() div 4-1&&Shop_GetBuyNumber() mod 4<=_buy_choice){
						_buy_choice=Shop_GetBuyNumber() mod 4-1;
					}
					Shop_SetMenuBuy(SHOP_BUY.MENU,_page_buy);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				}
				if(Input_IsPressed(INPUT.LEFT)){
					_page_buy=(_page_buy<1 ? Shop_GetBuyNumber() div 4 : _page_buy-1);
					if(_page_buy>Shop_GetBuyNumber() div 4-1&&Shop_GetBuyNumber() mod 4<=_buy_choice){
						_buy_choice=Shop_GetBuyNumber() mod 4-1;
					}
					Shop_SetMenuBuy(SHOP_BUY.MENU,_page_buy);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				}
			}
			if(_buy_choice<4&&Input_IsPressed(INPUT.CONFIRM)){
				var bidx=Shop_GetBuyChoice();
				if(Shop_IsBuyChoiceAvailable(bidx)){
					Shop_SetMenuBuy(SHOP_BUY.CONFIRM);
				}else if(Shop_GetBuyBuyable(bidx)==SHOP_BUYABLE.UNBUYABLE){
					Shop_SetBuyResult(SHOP_BUY_RESULT.UNABLE);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
				}else if(Shop_GetBuyBuyable(bidx)==SHOP_BUYABLE.SELLOUT){
					Shop_SetBuyResult(SHOP_BUY_RESULT.SOLD_OUT);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
				}
				// empty: ignore confirm
			}
		}else if(shop_menu_buy==SHOP_BUY.CONFIRM){
			if(Player_GetTextTyperChoice()==0){
				var result=Shop_TryBuy(Shop_GetBuyChoice());
				Shop_SetBuyResult(result);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.BUY);
				Shop_SetMenuBuy(SHOP_BUY.MENU,_page_buy);
				Shop_ClearTextTyperChoice();
			}
			if(Player_GetTextTyperChoice()==1){
				Shop_SetBuyResult(SHOP_BUY_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.BUY);
				Shop_SetMenuBuy(SHOP_BUY.MENU,_page_buy);
				Shop_ClearTextTyperChoice();
			}
			if(Input_IsPressed(INPUT.CANCEL)){
				Shop_SetBuyResult(SHOP_BUY_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.BUY);
				Shop_SetMenuBuy(SHOP_BUY.MENU,_page_buy);
			}
		}
	}

	if(shop_menu==SHOP_MENU.SELL){
		if(shop_menu_sell==SHOP_SELL.MENU){
			var count=Item_GetNumber();
			if(Input_IsPressed(INPUT.DOWN)){
				_sell_choice=(_sell_choice>7 ? _sell_choice mod 2 : _sell_choice+2);
				if(_sell_choice mod 2==0){
					if(_sell_choice==(count+1) div 2*2)_sell_choice=8;
				}else{
					if(_sell_choice==count div 2*2+1)_sell_choice=1;
				}
			}
			if(Input_IsPressed(INPUT.UP)){
				if(_sell_choice==8){
					_sell_choice=(((count+1) div 2)-1)*2;
				}else{
					_sell_choice-=2;
					if(_sell_choice==-2)_sell_choice=8;
					else if(_sell_choice==-1)_sell_choice=count div 2*2-1;
				}
			}
			if(Input_IsPressed(INPUT.RIGHT)||Input_IsPressed(INPUT.LEFT)){
				if(_sell_choice!=8){
					if(count mod 2==0||!(count mod 2==1&&_sell_choice==count-1)){
						_sell_choice=(_sell_choice mod 2 ? _sell_choice-1 : _sell_choice+1);
					}
				}
			}
			if(Input_IsPressed(INPUT.CONFIRM)&&_sell_choice<8){
				if(_sell_choice<count&&Item_GetPriceSell(Item_Get(_sell_choice))>0){
					Shop_SetMenuSell(SHOP_SELL.CONFIRM);
				}
				// unsellable: no confirm / no tip — just ignore
			}
			if(Input_IsPressed(INPUT.CANCEL)||(Input_IsPressed(INPUT.CONFIRM)&&_sell_choice==8)){
				Shop_SetNextMenu(SHOP_MENU.MENU);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				Shop_SetState(SHOP_STATE.DIALOG);
				_dialog_pending=true;
				_menu_sell=-1;
			}
		}else if(shop_menu_sell==SHOP_SELL.CONFIRM){
			if(Player_GetTextTyperChoice()==0){
				var sres=Shop_TrySell(_sell_choice);
				Shop_SetSellResult(sres);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_ClearTextTyperChoice();
				Shop_SetNextMenu(SHOP_MENU.SELL);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				Shop_SetState(SHOP_STATE.DIALOG);
				_dialog_pending=true;
				_sell_choice=0;
			}
			if(Player_GetTextTyperChoice()==1){
				Shop_SetSellResult(SHOP_SELL_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.SELL);
				Shop_SetMenuSell(SHOP_SELL.MENU);
				Shop_ClearTextTyperChoice();
			}
			if(Input_IsPressed(INPUT.CANCEL)){
				Shop_SetSellResult(SHOP_SELL_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.SELL);
				Shop_SetMenuSell(SHOP_SELL.MENU);
			}
		}
	}

	if(shop_menu==SHOP_MENU.TALK){
		if(Input_IsPressed(INPUT.CANCEL)||(Input_IsPressed(INPUT.CONFIRM)&&_talk_choice==4)){
			Shop_SetNextMenu(SHOP_MENU.MENU);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
			Shop_SetState(SHOP_STATE.DIALOG);
			_dialog_pending=true;
		}
		if(Input_IsPressed(INPUT.DOWN)){
			_talk_choice=(_talk_choice>3 ? 0 : _talk_choice+1);
			if(_page_talk>Shop_GetTalkNumber() div 4-1&&Shop_GetTalkNumber() mod 4==_talk_choice){
				for(var i=0;i<4-(Shop_GetTalkNumber() mod 4);i+=1)_talk_choice+=1;
			}
		}
		if(Input_IsPressed(INPUT.UP)){
			_talk_choice=(_talk_choice<1 ? 4 : _talk_choice-1);
			if(_page_talk>Shop_GetTalkNumber() div 4-1&&_talk_choice==3){
				for(var i=0;i<4-(Shop_GetTalkNumber() mod 4);i+=1)_talk_choice-=1;
			}
		}
		if(Shop_GetTalkPageMax()>1&&_talk_choice<4){
			if(Input_IsPressed(INPUT.RIGHT)){
				_page_talk=(_page_talk>Shop_GetTalkNumber() div 4-1 ? 0 : _page_talk+1);
				if(_page_talk>Shop_GetTalkNumber() div 4-1&&Shop_GetTalkNumber() mod 4<=_talk_choice){
					_talk_choice=Shop_GetTalkNumber() mod 4-1;
				}
				Shop_SetMenuTalk(_page_talk);
			}
			if(Input_IsPressed(INPUT.LEFT)){
				_page_talk=(_page_talk<1 ? Shop_GetTalkNumber() div 4 : _page_talk-1);
				if(_page_talk>Shop_GetTalkNumber() div 4-1&&Shop_GetTalkNumber() mod 4<=_talk_choice){
					_talk_choice=Shop_GetTalkNumber() mod 4-1;
				}
				Shop_SetMenuTalk(_page_talk);
			}
		}
		if(_talk_choice<4&&Input_IsPressed(INPUT.CONFIRM)){
			var tidx=Shop_GetTalkChoice();
			var td=Shop_GetTalkDialog(tidx);
			if(td!="")Dialog_Add(td);
			Shop_AdvanceTalk(tidx);
			Shop_SetNextMenu(SHOP_MENU.TALK);
			Shop_SetState(SHOP_STATE.DIALOG);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
			_dialog_pending=true;
		}
	}

	if(shop_menu==SHOP_MENU.EXIT){
		if(fader.alpha>=1){
			Fader_Fade(1,0,20);
			BGM_Stop(4);
			var room_return=Flag_Get(FLAG_TEMP,"shop_room_return",-1);
			if(room_exists(room_return))room_goto(room_return);
		}
	}
}else if(shop_state==SHOP_STATE.DIALOG){
	if(_dialog_pending){
		_dialog_pending=false;
		Shop_ClearUITypers();
		if(!Dialog_IsEmpty()){
			Shop_CallHostEvent(SHOP_HOST_EVENT.DIALOG_START);
			Shop_SetDialog(Dialog_Get()+"{pause}{end}");
		}else if(Shop_IsDialogAutoEnd()){
			Shop_EndDialog();
		}
	}else if(!instance_exists(_inst_dialog[0])){
		if(!Dialog_IsEmpty()){
			Shop_CallHostEvent(SHOP_HOST_EVENT.DIALOG_START);
			Shop_SetDialog(Dialog_Get()+"{pause}{end}");
		}else if(Shop_IsDialogAutoEnd()){
			Shop_EndDialog();
		}
	}
}