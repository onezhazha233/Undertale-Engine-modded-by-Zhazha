draw_sprite_ext(spr_pixel,0,0,240,640,240,0,-1,1)

draw_sprite_ext(spr_pixel,0,0,240,640,240,0,-1,1)
draw_sprite_ext(spr_pixel,0,8,240+8,640-16,240-16,0,0,1)

//大框
if!(Shop_GetState() = SHOP_STATE.DIALOG||Shop_GetMenu() = SHOP_MENU.SELL||Shop_GetMenuSell() = SHOP_SELL.CONFIRM||Shop_GetMenu() = SHOP_MENU.EXIT){
	draw_sprite_ext(spr_pixel,0,420,248,8,240-16,0,-1,1);
}

//余额显示
if!(Shop_GetState() = SHOP_STATE.DIALOG||Shop_GetMenu() = SHOP_MENU.EXIT){
	if(Shop_GetMenu() = SHOP_MENU.SELL||Shop_GetMenuSell() = SHOP_SELL.CONFIRM){
		gc = c_yellow;
	}
	else{
		gc = c_white;
	}
	draw_set_font(Lang_GetFont(Lang_GetString("font.menu.0")));
	if(gc = c_white){
		draw_text_transformed_color(460,416,string(Player_GetGold())+"G",2,2,0,gc,gc,gc,gc,1);
	}
	else{
		draw_text_transformed_color(397,416,"("+string(Player_GetGold())+"G)",2,2,0,gc,gc,gc,gc,1);
	}
}

//背包空间显示
if!(Shop_GetState() = SHOP_STATE.DIALOG||Shop_GetMenu() = SHOP_MENU.SELL||Shop_GetMenuSell() = SHOP_SELL.CONFIRM||Shop_GetMenu() = SHOP_MENU.EXIT){
	draw_set_font(Lang_GetFont(Lang_GetString("font.menu.0")));
	draw_text_transformed_color(560,416,string(Item_GetNumber())+"/8",2,2,0,-1,-1,-1,-1,1);
}

//主菜单选择
if(Shop_GetState() = SHOP_STATE.MENU){
	if(Shop_GetMenu() = SHOP_MENU.MENU){
		switch(shop._menu_choice){
			case 0:
				Y = 276+shop._menu_choice;
				break;
			case 1:
				Y = 276+shop._menu_choice*41;
				break;
			case 2:
				Y = 276+shop._menu_choice*41;
				break;
			case 3:
				Y = 276+shop._menu_choice*40;
				break;
		}
		draw_sprite(spr_battle_soul_red,0,459,Y);
	}
	
	//购买界面选择
	if(Shop_GetMenu() = SHOP_MENU.BUY){
		if(Shop_GetMenuBuy() = SHOP_BUY.MENU){
			switch(shop._buy_choice){
				case 0:
					Y = 276+shop._buy_choice;
					break;
				case 1:
					Y = 276+shop._buy_choice*39;
					break;
				case 2:
					Y = 276+shop._buy_choice*40;
					break;
				case 3:
					Y = 276+shop._buy_choice*40;
					break;
				case 4:
					Y = 276+shop._buy_choice*40;
					break;
			}
			draw_sprite(spr_battle_soul_red,0,38,Y);
		}
		
		if(Shop_GetBuyPageMax() > 1){
			draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow,0,25-_arrow,335,1,1,90,-1,1);
			draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow,0,403+_arrow,335,1,1,-90,-1,1);
		}
	}
	
	//出售界面选择
	if(Shop_GetMenu() = SHOP_MENU.SELL){
		if(Shop_GetMenuSell() = SHOP_SELL.MENU){
			X = 38 + (shop._sell_choice mod 2)*281;
			switch(shop._sell_choice div 2){
				case 0:
					Y = 276+(shop._sell_choice div 2);
					break;
				case 1:
					Y = 276+(shop._sell_choice div 2)*39;
					break;
				case 2:
					Y = 276+(shop._sell_choice div 2)*40;
					break;
				case 3:
					Y = 276+(shop._sell_choice div 2)*40;
					break;
				case 4:
					Y = 276+(shop._sell_choice div 2)*40;
					break;
			}
			draw_sprite(spr_battle_soul_red,0,X,Y);
		}
	}
	
	//谈话界面选择
	if(Shop_GetMenu() = SHOP_MENU.TALK){
		switch(shop._talk_choice){
			case 0:
				Y = 276+shop._talk_choice;
				break;
			case 1:
				Y = 276+shop._talk_choice*39;
				break;
			case 2:
				Y = 276+shop._talk_choice*40;
				break;
			case 3:
				Y = 276+shop._talk_choice*40;
				break;
			case 4:
				Y = 276+shop._talk_choice*40;
				break;
		}
		draw_sprite(spr_battle_soul_red,0,38,Y);
		
		if(Shop_GetTalkPageMax() > 1){
			draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow,0,25-_arrow,335,1,1,90,-1,1);
			draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow,0,403+_arrow,335,1,1,-90,-1,1);
		}
	}
}