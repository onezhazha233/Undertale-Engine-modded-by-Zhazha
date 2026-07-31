/// Shop menus: main templates + buy/sell/talk UI builders

function Shop_DefineBuiltinMainTemplates(){
	Shop_DefineMainTemplate("default",[
		{action: SHOP_MAIN_ACTION.BUY,label_key:"shop.menu.choice.0"},
		{action: SHOP_MAIN_ACTION.SELL,label_key:"shop.menu.choice.1"},
		{action: SHOP_MAIN_ACTION.TALK,label_key:"shop.menu.choice.2"},
		{action: SHOP_MAIN_ACTION.EXIT,label_key:"shop.menu.choice.3"}
	]);
	Shop_DefineMainTemplate("geno",[
		{action: SHOP_MAIN_ACTION.BUY,label_key:"shop.menu.choice.take",free:true},
		{action: SHOP_MAIN_ACTION.DIALOG,label_key:"shop.menu.choice.steal"},
		{action: SHOP_MAIN_ACTION.DIALOG,label_key:"shop.menu.choice.read",dialog_key:"shop.demo.read"},
		{action: SHOP_MAIN_ACTION.EXIT,label_key:"shop.menu.choice.3"}
	]);
}

///@arg name
///@arg slots  array of 4 structs: action, label_key|label, free*, dialog_key|dialog*
function Shop_DefineMainTemplate(name,slots){
	if(!is_array(slots)||array_length(slots)!=4){
		show_debug_message("Shop_DefineMainTemplate: need 4 slots ("+string(name)+")");
		return false;
	}
	global._shop_main_templates[$ string(name)]=slots;
	return true;
}

function Shop_ApplyMainTemplate(name){
	if(!instance_exists(shop))return false;
	if(!variable_struct_exists(global._shop_main_templates,string(name))){
		show_debug_message("Shop main template missing: "+string(name));
		return false;
	}
	var slots=global._shop_main_templates[$ string(name)];
	for(var i=0;i<4;i+=1){
		var s=slots[i];
		var action=s.action;
		var label="";
		if(variable_struct_exists(s,"label"))label=s.label;
		else if(variable_struct_exists(s,"label_key"))label=Lang_GetString(s.label_key);
		var free=variable_struct_exists(s,"free") ? s.free : false;
		var dialog="";
		if(variable_struct_exists(s,"dialog"))dialog=s.dialog;
		else if(variable_struct_exists(s,"dialog_key"))dialog=Lang_GetString(s.dialog_key);
		if(action==SHOP_MAIN_ACTION.BUY){
			Shop_SetMainChoice(i,action,label,free);
		}else if(action==SHOP_MAIN_ACTION.DIALOG){
			Shop_SetMainChoice(i,action,label,dialog);
		}else{
			Shop_SetMainChoice(i,action,label);
		}
	}
	shop._buy_free=false;
	return true;
}

function Shop_ResetMainChoices(){
	return Shop_ApplyMainTemplate("default");
}

///@arg slot  0..3
///@arg action  SHOP_MAIN_ACTION.*
///@arg label
///@arg opt*  BUY: free bool | DIALOG: dialog string
function Shop_SetMainChoice(){
	var slot=argument[0];
	var action=argument[1];
	var label=argument[2];
	var free=false;
	var dialog="";
	if(action==SHOP_MAIN_ACTION.BUY){
		if(argument_count>=4)free=argument[3];
	}else if(action==SHOP_MAIN_ACTION.DIALOG){
		if(argument_count>=4)dialog=argument[3];
	}
	if(!instance_exists(shop))return false;
	if(slot<0||slot>3)return false;
	shop._main_action[slot]=action;
	shop._main_label[slot]=label;
	shop._main_free[slot]=free;
	shop._main_dialog[slot]=dialog;
	return true;
}

function Shop_GetMainAction(slot){
	if(!instance_exists(shop))return -1;
	if(slot<0||slot>3)return -1;
	return shop._main_action[slot];
}

function Shop_GetMainLabel(slot){
	if(!instance_exists(shop))return "";
	if(slot<0||slot>3)return "";
	return shop._main_label[slot];
}

function Shop_GetMainFree(slot){
	if(!instance_exists(shop))return false;
	if(slot<0||slot>3)return false;
	return shop._main_free[slot];
}

function Shop_GetMainDialog(slot){
	if(!instance_exists(shop))return "";
	if(slot<0||slot>3)return "";
	return shop._main_dialog[slot];
}

function Shop_SetMenu(MENU){
	if(!instance_exists(shop))return false;
	shop._menu=MENU;
	Shop_SetDialog("",false,false);
	Shop_SetDialog("",false,true);
	if(instance_exists(shop._inst_right_dialog))instance_destroy(shop._inst_right_dialog);
	if(instance_exists(shop._inst_menu_choice))instance_destroy(shop._inst_menu_choice);
	if(instance_exists(shop._inst_page))instance_destroy(shop._inst_page);

	if(MENU==SHOP_MENU.MENU){
		Shop_SetBuyFree(false);
		shop._page_buy=0;
		shop._page_talk=0;
		shop._menu_sell=-1;
		shop._menu_buy=-1;
		Shop_SetDialog(Shop_GetMenuDialog());
		var mcx=480+Lang_GetLayout("shop.menu_choice.x",0);
		var mcy=260+Lang_GetLayout("shop.menu_choice.y",0);
		shop._inst_menu_choice=instance_create_depth(mcx,mcy,DEPTH_SHOP.DIALOG,text_typer);
		var t="{font 1}{instant true}"+Shop_TyperPrefix();
		for(var i=0;i<4;i+=1){
			if(Shop_GetMainAction(i)==SHOP_MAIN_ACTION.SELL&&Item_GetNumber())t+="{color `gray`}";
			t+=Shop_GetMainLabel(i)+"&";
			if(Shop_GetMainAction(i)==SHOP_MAIN_ACTION.SELL)t+="{color `white`}";
		}
		shop._inst_menu_choice.text=t;
		Shop_CallHostEvent(SHOP_HOST_EVENT.MAIN_MENU_START);
	}else if(MENU==SHOP_MENU.BUY){
		Shop_SetMenuBuy(SHOP_BUY.MENU,shop._page_buy);
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
	}else if(MENU==SHOP_MENU.SELL){
		Shop_SetMenuSell(SHOP_SELL.MENU);
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
	}else if(MENU==SHOP_MENU.TALK){
		Shop_SetMenuTalk(shop._page_talk);
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
	}else if(MENU==SHOP_MENU.EXIT){
		Shop_End();
	}
	return true;
}

function Shop_SetMenuBuy(MENU,PAGE=0){
	if(!instance_exists(shop))return false;
	shop._menu_buy=MENU;
	if(MENU==SHOP_BUY.MENU){
		shop._page_buy=PAGE;
		var text="";
		for(var i=PAGE*4;i<PAGE*4+4;i+=1){
			if(i<Shop_GetBuyNumber()){
				if(Shop_GetBuyBuyable(i)!=SHOP_BUYABLE.SELLOUT){
					var price_show=Shop_IsBuyFree() ? 0 : Shop_GetBuyPrice(i);
					text+=string(price_show)+"G - "+Shop_GetBuyName(i)+"&";
				}else{
					text+="{color_text `gray`}"+Lang_GetString("shop.menu.sellout")+"{color_text `white`}&";
				}
			}else{
				text+="&";
			}
		}
		text+=Lang_GetString("shop.menu.exit");
		Shop_SetDialog(text,true);
		if(Shop_GetBuyPageMax()>1){
			if(instance_exists(shop._inst_page))instance_destroy(shop._inst_page);
			var px=240+Lang_GetLayout("shop.dialog.base_x",0);
			var py=420+Lang_GetLayout("shop.dialog.base_y",0);
			shop._inst_page=instance_create_depth(px,py,DEPTH_SHOP.DIALOG,text_typer);
			shop._inst_page.text="{font 1}{instant true}{scale 2}{shadow false}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}{define `PAGE` `"+string(PAGE+1)+"`}"+Lang_GetString("shop.menu.page");
		}
	}else{
		var confirm="{instant true}{choice_dir 1}{choice_confirm_snd false}";
		if(Shop_IsBuyFree()){
			confirm+=Lang_GetString("shop.menu.take.confirm");
		}else{
			var price=Shop_GetBuyPrice(Shop_GetBuyChoice());
			confirm+="{define `PRICE` `"+string(price)+"`}"+Lang_GetString("shop.menu.buy.confirm");
		}
		Shop_SetRightDialog(confirm);
	}
	return true;
}

function Shop_SetMenuSell(MENU){
	if(!instance_exists(shop))return false;
	shop._menu_sell=MENU;
	if(MENU==SHOP_SELL.MENU){
		var text="";
		var text2="";
		var count=Item_GetNumber()
		var cap=8;
		var thanks=clamp(shop._sell_thanks,0,max(0,cap-count));
		var thanks_start=cap-thanks;
		var thanks_label="{color_text `gray`}"+Lang_GetString("shop.menu.sell.thanks")+"{color_text `white`}";
		for(var i=0;i<8;i+=2){
			if(i<count){
				var item_l=Item_Get(i);
				text+=Shop_GetSellPriceLabel(item_l)+" - "+Item_GetName(item_l)+"&";
			}else if(thanks>0&&i>=thanks_start&&i<cap){
				text+=thanks_label+"&";
			}else if(thanks>0&&i<cap){
				text+="&";
			}
			if(i+1<count){
				var item_r=Item_Get(i+1);
				text2+=Shop_GetSellPriceLabel(item_r)+" - "+Item_GetName(item_r)+"&";
			}else if(thanks>0&&i+1>=thanks_start&&i+1<cap){
				text2+=thanks_label+"&";
			}else if(thanks>0&&i+1<cap){
				text2+="&";
			}
		}
		var rows_used=thanks>0 ? ((cap+1) div 2) : ((count+1) div 2);
		for(var pad=0;pad<4-rows_used;pad+=1){
			text+="&";
		}
		text+=Lang_GetString("shop.menu.exit");
		Shop_SetDialog(text,true,false);
		Shop_SetDialog(text2,true,true);
		Dialog_Clear();
	}else{
		var slot=shop._sell_choice;
		var item_id=Item_Get(slot);
		var p=Item_GetPriceSell(item_id);
		var confirm="{define `PRICE` `"+string(p)+"`}{font 1}{instant true}{choice_dir 0}{choice_confirm_snd false}"+Lang_GetString("shop.menu.sell.confirm");
		Shop_SetDialog(confirm);
		if(instance_exists(shop._inst_dialog[0])){
			shop._inst_dialog[0].x+=100+Lang_GetLayout("shop.sell.confirm.x",0);
			shop._inst_dialog[0].y+=40+Lang_GetLayout("shop.sell.confirm.y",0);
		}
		if(instance_exists(shop._inst_dialog[1])){
			instance_destroy(shop._inst_dialog[1]);
			shop._inst_dialog[1]=noone;
		}
		if(instance_exists(shop._inst_right_dialog)){
			instance_destroy(shop._inst_right_dialog);
			shop._inst_right_dialog=noone;
		}
	}
	return true;
}

function Shop_SetMenuTalk(PAGE){
	if(!instance_exists(shop))return false;
	shop._page_talk=PAGE;
	var text="";
	var new_suffix=Lang_GetString("shop.menu.talk.new");
	for(var i=PAGE*4;i<PAGE*4+4;i+=1){
		if(i<Shop_GetTalkNumber()){
			if(Shop_IsTalkNew(i)){
				text+="{color `yellow`}"+Shop_GetTalkName(i)+new_suffix+"{color `white`}&";
			}else{
				text+=Shop_GetTalkName(i)+"&";
			}
		}else{
			text+="&";
		}
	}
	text+=Lang_GetString("shop.menu.exit");
	Shop_SetDialog(text,true);
	if(Shop_GetTalkPageMax()>1){
		if(instance_exists(shop._inst_page))instance_destroy(shop._inst_page);
		var px=240+Lang_GetLayout("shop.dialog.base_x",0);
		var py=420+Lang_GetLayout("shop.dialog.base_y",0);
		shop._inst_page=instance_create_depth(px,py,DEPTH_SHOP.DIALOG,text_typer);
		shop._inst_page.text="{font 1}{instant true}{scale 2}{shadow false}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}{define `PAGE` `"+string(PAGE+1)+"`}"+Lang_GetString("shop.menu.page");
	}
	return true;
}