shop_state = Shop_GetState()
shop_menu = Shop_GetMenu()
shop_menu_buy = Shop_GetMenuBuy()
shop_menu_sell = Shop_GetMenuSell()
if(shop_state = SHOP_STATE.MENU){
	if(shop_menu = SHOP_MENU.MENU){
		if(Input_IsPressed(INPUT.DOWN)){
			_menu_choice = (_menu_choice > 2 ? 0 : _menu_choice + 1);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
		}
		if(Input_IsPressed(INPUT.UP)){
			_menu_choice = (_menu_choice < 1 ? 3 : _menu_choice - 1);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
		}
		if(Input_IsPressed(INPUT.CONFIRM)){
			switch(_menu_choice){
				case 0:
					Shop_SetNextMenu(SHOP_MENU.BUY);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					
					//Shop_SetMenu(SHOP_MENU.BUY);
					
					Shop_SetState(SHOP_STATE.DIALOG);
					
					if(instance_exists(_inst_dialog[0])){
						instance_destroy(_inst_dialog[0]);
					}
					if(instance_exists(shop._inst_menu_choice)){
						instance_destroy(shop._inst_menu_choice);
					}
					_buy_choice = 0;
					break;
					
				case 1:
					//if(shop_host._sellable = 1){
						Shop_SetNextMenu(SHOP_MENU.SELL);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					//}
					//else{
					//	Shop_SetNextMenu(SHOP_MENU.MENU);
					//	Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
					//}
					
					//Shop_SetMenu(SHOP_MENU.BUY);
					
					Shop_SetState(SHOP_STATE.DIALOG);
					
					if(instance_exists(_inst_dialog[0])){
						instance_destroy(_inst_dialog[0]);
					}
					if(instance_exists(shop._inst_menu_choice)){
						instance_destroy(shop._inst_menu_choice);
					}
					_sell_choice = 0;
					break;
					
				case 2:
					Shop_SetNextMenu(SHOP_MENU.TALK);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					
					//Shop_SetMenu(SHOP_MENU.BUY);
					
					Shop_SetState(SHOP_STATE.DIALOG);
					
					if(instance_exists(_inst_dialog[0])){
						instance_destroy(_inst_dialog[0]);
					}
					if(instance_exists(shop._inst_menu_choice)){
						instance_destroy(shop._inst_menu_choice);
					}
					_talk_choice = 0;
					break;
					
				case 3:
					Shop_SetNextMenu(SHOP_MENU.EXIT);
					
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					Shop_SetState(SHOP_STATE.DIALOG);
					
					
					if(instance_exists(shop._inst_dialog[0])){
						instance_destroy(shop._inst_dialog[0]);
					}
					if(instance_exists(shop._inst_menu_choice)){
						instance_destroy(shop._inst_menu_choice);
					}
					break;
			}
		}
	}
	if(shop_menu = SHOP_MENU.BUY){
		if(shop_menu_buy = SHOP_BUY.MENU){
			if(Input_IsPressed(INPUT.CANCEL)||(Input_IsPressed(INPUT.CONFIRM)&&_buy_choice = 4)){
				Shop_SetNextMenu(SHOP_MENU.MENU);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				Shop_SetState(SHOP_STATE.DIALOG);
				if(instance_exists(_inst_dialog[0])){
					instance_destroy(_inst_dialog[0]);
				}
				if(instance_exists(shop._inst_right_dialog)){
					instance_destroy(shop._inst_right_dialog);
				}
				_menu_buy = -1;
				//Shop_SetMenu(SHOP_MENU.MENU);
				//Shop_CallHostEvent(SHOP_HOST_EVENT.MAIN_MENU_START);
			}
			if(Input_IsPressed(INPUT.DOWN)){
				_buy_choice = (_buy_choice > 3 ? 0 : _buy_choice + 1);
				if(_page_buy > Shop_GetBuyNumber() div 4 - 1&&Shop_GetBuyNumber() mod 4 = _buy_choice){
					for(i=0;i<4-(Shop_GetBuyNumber() mod 4);i+=1){
						_buy_choice += 1;
					}
				}
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
			}
			if(Input_IsPressed(INPUT.UP)){
				_buy_choice = (_buy_choice < 1 ? 4 : _buy_choice - 1);
				if(_page_buy > Shop_GetBuyNumber() div 4 - 1&&_buy_choice = 3){
					for(i=0;i<4-(Shop_GetBuyNumber() mod 4);i+=1){
						_buy_choice -= 1;
					}
				}
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CHOICE_SWITCH);
			}
			if(_buy_choice < 4){
				if(Shop_GetBuyPageMax() > 1){
					if(Input_IsPressed(INPUT.RIGHT)){
						_page_buy = (_page_buy > Shop_GetBuyNumber() div 4 - 1 ? 0 : _page_buy + 1);
						if(_page_buy > Shop_GetBuyNumber() div 4 - 1&&Shop_GetBuyNumber() mod 4 <= _buy_choice){
							_buy_choice = Shop_GetBuyNumber() mod 4 - 1;
						}
						Shop_SetMenuBuy(0,_page_buy);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					}
					if(Input_IsPressed(INPUT.LEFT)){
						_page_buy = (_page_buy < 1 ? Shop_GetBuyNumber() div 4 : _page_buy - 1);
						if(_page_buy > Shop_GetBuyNumber() div 4 - 1&&Shop_GetBuyNumber() mod 4 <= _buy_choice){
							_buy_choice = Shop_GetBuyNumber() mod 4 - 1;
						}
						Shop_SetMenuBuy(0,_page_buy);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					}
				}
				if(Input_IsPressed(INPUT.CONFIRM)){
					if(Shop_GetBuyBuyable(Shop_GetBuyChoice()) = SHOP_BUYABLE.BUYABLE){
						Shop_SetMenuBuy(1);
					}
					else{
						Shop_SetBuyResult(SHOP_BUY_RESULT.UNABLE);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
					}
				}
			}
		}
		else if(shop_menu_buy = SHOP_BUY.CONFIRM){
			/*if(Player_GetTextTyperChoice() = 0){
				if(Player_GetGold() >= Item_GetPriceBuy(shop._host_item[|shop._page_buy*4+_buy_choice])&&Item_GetNumber() < 8){
					audio_play_sound(snd_shop_item,0,0);
					Item_Add(shop._host_item[|shop._page_buy*4+_buy_choice]);
					Player_SetGold(Player_GetGold()-Item_GetPriceBuy(shop._host_item[|shop._page_buy*4+shop._buy_choice]));
					Shop_SetBuyResult(0);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					Shop_SetMenu(SHOP_MENU.BUY);
					Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
				}
				else{
					if!(Item_GetNumber() < 8){
						Shop_SetBuyResult(2);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					}
					if!(Player_GetGold() >= Item_GetPriceBuy(shop._host_item[|shop._page_buy*4+shop._buy_choice])){
						Shop_SetBuyResult(3);
						Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					}
					Shop_SetMenu(SHOP_MENU.BUY);
					Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
				}
			}
			else if(Player_GetTextTyperChoice() = 1){
				Shop_SetBuyResult(1);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.BUY);
				Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
				
			}*/
			//if(Input_IsPressed(INPUT.CONFIRM)){
				//if(Player_GetGold() >= Shop_GetBuyPrice(shop._page_buy*4+_buy_choice)){
				//	Shop_SetBuyResult(SHOP_BUY_RESULT.NO_MONEY);
				//}
				//show_message(Player_GetTextTyperChoice())
				if(Player_GetTextTyperChoice() = 0){
					Shop_SetBuyResult(SHOP_BUY_RESULT.YES);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					Shop_SetMenu(SHOP_MENU.BUY);
					Shop_SetMenuBuy(0,_page_buy);
					Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
				}
				if(Player_GetTextTyperChoice() = 1){
					Shop_SetBuyResult(SHOP_BUY_RESULT.NO);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					Shop_SetMenu(SHOP_MENU.BUY);
					Shop_SetMenuBuy(0,_page_buy);
					Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
				}
			//}
			if(Input_IsPressed(INPUT.CANCEL)){
				Shop_SetBuyResult(SHOP_BUY_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.BUY);
				Shop_SetMenuBuy(0,_page_buy);
				//Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
			}
		}
	}
	if(shop_menu = SHOP_MENU.SELL){
		if(shop_menu_sell = SHOP_SELL.MENU){
			if(Input_IsPressed(INPUT.DOWN)){
				_sell_choice = (_sell_choice > 7 ? shop._sell_choice mod 2 : _sell_choice + 2);
				if(_sell_choice mod 2 = 0){
					if(_sell_choice = (Item_GetNumber()+1) div 2 * 2){
						_sell_choice = 8;
					}
				}
				else{
					if(_sell_choice = (Item_GetNumber()) div 2 * 2 + 1){
						_sell_choice = 1;
					}
				}
			}
			if(Input_IsPressed(INPUT.UP)){
				if(_sell_choice = 8){
					_sell_choice = (((Item_GetNumber()+1) div 2)-1)*2;
				}
				else{
					_sell_choice -= 2;
					if(_sell_choice = -2){
						_sell_choice = 8;
					}
					else if(_sell_choice = -1){
						_sell_choice = Item_GetNumber() div 2 * 2-1;
					}
				}
			}
			if(Input_IsPressed(INPUT.RIGHT)){
				if!(_sell_choice = 8){
					if(Item_GetNumber() mod 2 = 0||!(Item_GetNumber() mod 2 = 1&&_sell_choice = Item_GetNumber()-1))_sell_choice = (_sell_choice mod 2 ? _sell_choice - 1 : _sell_choice + 1);
				}
			}
			if(Input_IsPressed(INPUT.LEFT)){
				if!(_sell_choice = 8){
					if(Item_GetNumber() mod 2 = 0||!(Item_GetNumber() mod 2 = 1&&_sell_choice = Item_GetNumber()-1))_sell_choice = (_sell_choice mod 2 ? _sell_choice - 1 : _sell_choice + 1);
				}
			}
		
			if(Input_IsPressed(INPUT.CONFIRM)&&_sell_choice < 8){
				if(Item_GetSellable(Item_Get(_sell_choice))){
					Shop_SetMenuSell(1);
				}
				else{
					Shop_SetSellResult(SHOP_SELL_RESULT.UNABLE);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
					Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
				}
			}
			if(Input_IsPressed(INPUT.CANCEL)||(Input_IsPressed(INPUT.CONFIRM)&&_sell_choice = 8)){
				Shop_SetNextMenu(SHOP_MENU.MENU);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
				Shop_SetState(SHOP_STATE.DIALOG);
				if(instance_exists(_inst_dialog[0])){
					instance_destroy(_inst_dialog[0]);
				}
				if(instance_exists(_inst_dialog[1])){
					instance_destroy(_inst_dialog[1]);
				}
				_menu_sell = -1;
			}
		}
		if(shop_menu_sell = SHOP_SELL.CONFIRM){
			if(Player_GetTextTyperChoice() = 0){
				Shop_SetSellResult(SHOP_SELL_RESULT.YES);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				//Shop_SetMenu(SHOP_MENU.SELL);
				//Shop_SetMenuSell(0);
				Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
				
				Shop_SetNextMenu(SHOP_MENU.SELL);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
					
				//Shop_SetMenu(SHOP_MENU.BUY);
					
				Shop_SetState(SHOP_STATE.DIALOG);
					
				if(instance_exists(_inst_dialog[0])){
					instance_destroy(_inst_dialog[0]);
				}
				if(instance_exists(shop._inst_menu_choice)){
					instance_destroy(shop._inst_menu_choice);
				}
				_sell_choice = 0;
			}
			if(Player_GetTextTyperChoice() = 1){
				Shop_SetSellResult(SHOP_SELL_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.SELL);
				Shop_SetMenuSell(0);
				Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.TEXT_TYPER_CHOICE,-1);
			}
			if(Input_IsPressed(INPUT.CANCEL)){
				Shop_SetSellResult(SHOP_SELL_RESULT.NO);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_CONFIRM);
				Shop_SetMenu(SHOP_MENU.SELL);
				Shop_SetMenuSell(0);
			}
		}
	}
	if(shop_menu = SHOP_MENU.TALK){
		if(Input_IsPressed(INPUT.CANCEL)||(Input_IsPressed(INPUT.CONFIRM)&&_talk_choice = 4)){
			Shop_SetNextMenu(SHOP_MENU.MENU);
			Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
			Shop_SetState(SHOP_STATE.DIALOG);
			if(instance_exists(_inst_dialog[0])){
				instance_destroy(_inst_dialog[0]);
			}
			if(instance_exists(shop._inst_right_dialog)){
				instance_destroy(shop._inst_right_dialog);
			}
			//Shop_SetMenu(SHOP_MENU.MENU);
			//Shop_CallHostEvent(SHOP_HOST_EVENT.MAIN_MENU_START);
		}
		if(Input_IsPressed(INPUT.DOWN)){
			_talk_choice = (_talk_choice > 3 ? 0 : _talk_choice + 1);
			if(_page_talk > Shop_GetTalkNumber() div 4 - 1&&Shop_GetTalkNumber() mod 4 = _talk_choice){
				for(i=0;i<4-(Shop_GetTalkNumber() mod 4);i+=1){
					_talk_choice += 1;
				}
			}
		}
		if(Input_IsPressed(INPUT.UP)){
			_talk_choice = (_talk_choice < 1 ? 4 : _talk_choice - 1);
			if(_page_talk > Shop_GetTalkNumber() div 4 - 1&&_talk_choice = 3){
				for(i=0;i<4-(Shop_GetTalkNumber() mod 4);i+=1){
					_talk_choice -= 1;
				}
			}
		}
		if(_talk_choice < 4){
			if(Shop_GetTalkPageMax() > 1){
				if(Input_IsPressed(INPUT.RIGHT)){
					_page_talk = (_page_talk > Shop_GetTalkNumber() div 4 - 1 ? 0 : _page_talk + 1);
					if(_page_talk > Shop_GetTalkNumber() div 4 - 1&&Shop_GetTalkNumber() mod 4 <= _talk_choice){
						_talk_choice = Shop_GetTalkNumber() mod 4 - 1;
					}
					Shop_SetMenuTalk(_page_talk);
				}
				if(Input_IsPressed(INPUT.LEFT)){
					_page_talk = (_page_talk < 1 ? Shop_GetTalkNumber() div 4 : _page_talk - 1);
					if(_page_talk > Shop_GetTalkNumber() div 4 - 1&&Shop_GetTalkNumber() mod 4 <= _talk_choice){
						_talk_choice = Shop_GetTalkNumber() mod 4 - 1;
					}
					Shop_SetMenuTalk(_page_talk);
				}
			}
		}
		if(Input_IsPressed(INPUT.CONFIRM)){
			if(_talk_choice < 4){
				instance_destroy(_inst_dialog[0]);
				instance_destroy(_inst_right_dialog);
				Shop_SetNextMenu(SHOP_MENU.TALK);
				Shop_SetState(SHOP_STATE.DIALOG);
				Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_SWITCH);
			}
		}
	}
	if(shop_menu = SHOP_MENU.EXIT){
		if(fader.alpha = 1){
			Fader_Fade(1,0,20);
			BGM_Stop(4);
			room_goto(Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP_ROOM_RETURN));
		}
	}
}
else if(shop_state = SHOP_STATE.DIALOG){
	if(!instance_exists(_inst_dialog[0])){
		if(!Dialog_IsEmpty()){
			Shop_CallHostEvent(SHOP_HOST_EVENT.DIALOG_START);
			Shop_SetDialog(Dialog_Get()+"{pause}{end}");
		}
		else if(Shop_IsDialogAutoEnd()){
			Shop_EndDialog();
		}
	}
}