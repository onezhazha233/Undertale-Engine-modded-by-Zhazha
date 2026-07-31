_shop_id=Flag_Get(FLAG_TEMP,"shop")
_host_object=Shop_GetHost(_shop_id);
_host_inst=noone;

_menu_dialog=Shop_GetMenuDialogFromShopCustom(_shop_id);
_right_dialog="";
_itemdesc_dialog="";

_buy_list=[];
_talk_list=[];

_state=-1;
_menu=-1;
_menu_buy=-1;
_menu_sell=-1;
_menu_next=-1;

_buy_result=SHOP_BUY_RESULT.NULL;
_sell_result=SHOP_SELL_RESULT.NULL;

_menu_choice=0;
_buy_choice=0;
_sell_choice=0;
_sell_thanks=0;
_talk_choice=0;
_page_buy=0;
_page_talk=0;

_dialog_auto_end=true;
_dialog_pending=false;

_buy_free=false;
_main_action=[SHOP_MAIN_ACTION.BUY,SHOP_MAIN_ACTION.SELL,SHOP_MAIN_ACTION.TALK,SHOP_MAIN_ACTION.EXIT];
_main_label=["","","",""];
_main_free=[false,false,false,false];
_main_dialog=["","","",""];

_inst_dialog[0]=noone;
_inst_dialog[1]=noone;
_inst_menu_choice=noone;
_inst_right_dialog=noone;
_inst_itemdesc=noone;
_inst_page=noone;