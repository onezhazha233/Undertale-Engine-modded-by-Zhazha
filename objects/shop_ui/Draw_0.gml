draw_sprite_ext(spr_pixel,0,0,240,640,240,0,c_white,1);
draw_sprite_ext(spr_pixel,0,8,248,640-16,240-16,0,c_black,1);

var is_dialog=Shop_GetState()==SHOP_STATE.DIALOG&&!shop._dialog_pending;

if(!(is_dialog||Shop_GetMenu()==SHOP_MENU.SELL||Shop_GetMenuSell()==SHOP_SELL.CONFIRM||Shop_GetMenu()==SHOP_MENU.EXIT)){
	draw_sprite_ext(spr_pixel,0,420,248,8,240-16,0,c_white,1);
}

if(!(is_dialog||Shop_GetMenu()==SHOP_MENU.EXIT)){
	var gc=(Shop_GetMenu()==SHOP_MENU.SELL||Shop_GetMenuSell()==SHOP_SELL.CONFIRM) ? c_yellow : c_white;
	draw_set_font(Lang_GetFont("determination_sans",font_mars_needs_cunnilingus));
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if(gc==c_white){
		draw_text_transformed_color(460,420,string(Player_GetGold())+"G",2,2,0,gc,gc,gc,gc,1);
	}else{
		draw_text_transformed_color(397,420,"("+string(Player_GetGold())+"G)",2,2,0,gc,gc,gc,gc,1);
	}
}

if(!(is_dialog||Shop_GetMenu()==SHOP_MENU.SELL||Shop_GetMenuSell()==SHOP_SELL.CONFIRM||Shop_GetMenu()==SHOP_MENU.EXIT)){
	draw_set_font(Lang_GetFont("determination_sans",font_mars_needs_cunnilingus));
	draw_text_transformed_color(560,420,string(Item_GetNumber())+"/"+string(8),2,2,0,c_white,c_white,c_white,c_white,1);
}

if(Shop_GetState()==SHOP_STATE.MENU){
	if(Shop_GetMenu()==SHOP_MENU.MENU){
		var Y=276+shop._menu_choice*40;
		draw_sprite(spr_battle_soul_red,0,459,Y);
	}
	if(Shop_GetMenu()==SHOP_MENU.BUY&&Shop_GetMenuBuy()==SHOP_BUY.MENU){
		var Yb=276+shop._buy_choice*40;
		draw_sprite(spr_battle_soul_red,0,38,Yb);
	}
	if(Shop_GetMenu()==SHOP_MENU.SELL&&Shop_GetMenuSell()==SHOP_SELL.MENU){
		var Xs=38+(shop._sell_choice mod 2)*281;
		var Ys=276+(shop._sell_choice div 2)*40;
		if(shop._sell_choice==8){
			Xs=38;
			Ys=276+4*40;
		}
		draw_sprite(spr_battle_soul_red,0,Xs,Ys);
	}
	if(Shop_GetMenu()==SHOP_MENU.TALK){
		var Yt=276+shop._talk_choice*40;
		draw_sprite(spr_battle_soul_red,0,38,Yt);
	}
}
