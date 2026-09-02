/// Shop core: registry, lifecycle, state, dialog

function Shop_Init(){
	global._shop={};
	global._shop_main_templates={};
	Shop_DefineBuiltinMainTemplates();
	Shop_Custom();
	return true;
}

///@arg shop_id
function Shop_IsExists(shop_id){
	return variable_struct_exists(global._shop,string(shop_id));
}

function Shop_Set(sid,host,dialog,bgm=-1){
	global._shop[$ string(sid)]={
		host:host,
		menu_dialog:dialog,
		bgm:bgm
	};
	return true;
}

///@arg shop_id
function Shop_GetHost(shop_id){
	if(!Shop_IsExists(shop_id))return -1;
	return global._shop[$ string(shop_id)].host;
}

///@arg shop_id
function Shop_GetBGM(shop_id){
	if(!Shop_IsExists(shop_id))return -1;
	return global._shop[$ string(shop_id)].bgm;
}

///@arg shop_id
function Shop_GetMenuDialogFromShopCustom(shop_id){
	if(!Shop_IsExists(shop_id))return "";
	return global._shop[$ string(shop_id)].menu_dialog;
}

///@arg shop_id
function Shop_Start(shop_id){
	if(!Shop_IsExists(shop_id)){
		show_debug_message("Shop ID "+string(shop_id)+" doesn't exist!");
		return false;
	}
	Flag_Set(FLAG_TEMP,"shop",shop_id);
	Flag_Set(FLAG_TEMP,"shop_room_return",room);
	room_persistent=true;
	room_goto(room_shop);
	return true;
}

function Shop_End(){
	var room_return=Flag_Get(FLAG_TEMP,"shop_room_return",room_test_main);
	if(room_exists(room_return)){
		fader.color=c_black;
		Fader_Fade(0,1,20);
		BGM_SetVolume(4,0,20);
		BGM_Resume(0);
		BGM_SetVolume(0,1,20);
	}
}

///@arg event  SHOP_HOST_EVENT.*
function Shop_CallHostEvent(_event){
	if(!instance_exists(shop))return false;
	if(!instance_exists(shop._host_inst))return false;
	with(shop._host_inst){
		event_user(_event);
	}
	return true;
}

function Shop_GetState(){
	return instance_exists(shop) ? shop._state : -1;
}

///@arg state  SHOP_STATE.*
///@arg call_main_menu_start*
function Shop_SetState(STATE,CALL_MAIN_START=false){
	if(!instance_exists(shop))return false;
	shop._state=STATE;
	if(STATE==SHOP_STATE.MENU&&CALL_MAIN_START){
		Shop_CallHostEvent(SHOP_HOST_EVENT.MENU_START);
		Shop_SetMenu(SHOP_MENU.MENU,false);
	}
	return true;
}

function Shop_GetMenu(){
	return instance_exists(shop) ? shop._menu : -1;
}

function Shop_GetMenuBuy(){
	return instance_exists(shop) ? shop._menu_buy : -1;
}

function Shop_GetMenuSell(){
	return instance_exists(shop) ? shop._menu_sell : -1;
}

function Shop_GetNextMenu(){
	return instance_exists(shop) ? shop._menu_next : -1;
}

///@arg next  SHOP_MENU.*
function Shop_SetNextMenu(_next){
	if(!instance_exists(shop))return false;
	shop._menu_next=_next;
	return true;
}

function Shop_GotoNextMenu(){
	if(!instance_exists(shop))return false;
	if(shop._menu_next>-1){
		Shop_SetMenu(shop._menu_next);
		shop._menu_next=-1;
	}
	return true;
}

function Shop_GetMenuDialog(){
	return instance_exists(shop) ? shop._menu_dialog : "";
}

///@arg text
function Shop_SetMenuDialog(text){
	if(!instance_exists(shop))return false;
	shop._menu_dialog=text;
	return true;
}

function Shop_IsDialogAutoEnd(){
	return instance_exists(shop) ? shop._dialog_auto_end : true;
}

///@arg auto_end
function Shop_SetDialogAutoEnd(v){
	if(!instance_exists(shop))return false;
	shop._dialog_auto_end=v;
	return true;
}

function Shop_TyperPrefix(){
	return "{space_y 4}{scale 2}{speed "+string(Lang_GetLayout("speed.dialog_shop",0))+"}{shadow false}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}";
}

function Shop_SetDialog(TEXT="",CHOICE=false,LINE2=false){
	if(!instance_exists(shop))return noone;

	if(instance_exists(shop._inst_dialog[LINE2])){
		instance_destroy(shop._inst_dialog[LINE2]);
	}

	if(TEXT=="")return noone;

	var tx=40+Lang_GetLayout("shop.dialog.base_x",0);
	var ty=260+Lang_GetLayout("shop.dialog.base_y",0);
	if(CHOICE)tx+=21+Lang_GetLayout("shop.dialog.choice_x",0);
	if(LINE2)tx+=281+Lang_GetLayout("shop.dialog.line2_x",0);
	shop._inst_dialog[LINE2]=instance_create_depth(tx,ty,DEPTH_SHOP.DIALOG,text_typer);
	var prefix=(CHOICE ? "{font 1}" : "{font 0}")+Shop_TyperPrefix();
	if(CHOICE)prefix+="{instant true}{choice_dir 1}";
	shop._inst_dialog[LINE2].text=prefix+TEXT;
	return shop._inst_dialog[LINE2];
}

///@arg text
function Shop_SetRightDialog(TEXT){
	if(!instance_exists(shop))return false;
	if(instance_exists(shop._inst_right_dialog)){
		instance_destroy(shop._inst_right_dialog);
	}
	shop._right_dialog=TEXT;
	if(TEXT=="")return true;
	var rx=450+Lang_GetLayout("shop.right_dialog.x",0);
	var ry=260+Lang_GetLayout("shop.right_dialog.y",0);
	shop._inst_right_dialog=instance_create_depth(rx,ry,DEPTH_SHOP.DIALOG,text_typer);
	shop._inst_right_dialog.text="{font 0}"+Shop_TyperPrefix()+TEXT;
	return true;
}

function Shop_ClearUITypers(){
	if(!instance_exists(shop))return;
	if(instance_exists(shop._inst_dialog[0]))instance_destroy(shop._inst_dialog[0]);
	if(instance_exists(shop._inst_dialog[1]))instance_destroy(shop._inst_dialog[1]);
	if(instance_exists(shop._inst_menu_choice))instance_destroy(shop._inst_menu_choice);
	if(instance_exists(shop._inst_right_dialog))instance_destroy(shop._inst_right_dialog);
	if(instance_exists(shop._inst_itemdesc))instance_destroy(shop._inst_itemdesc);
	if(instance_exists(shop._inst_page))instance_destroy(shop._inst_page);
	shop._itemdesc_dialog="";
}

function Shop_EndDialog(){
	if(Shop_GetState()!=SHOP_STATE.DIALOG)return false;
	Shop_CallHostEvent(SHOP_HOST_EVENT.DIALOG_END);
	Shop_SetState(SHOP_STATE.MENU,false);
	Shop_GotoNextMenu();
	Dialog_Clear();
	return true;
}

function Shop_ClearTextTyperChoice(){
	Flag_Set(FLAG_TEMP,"text_typer_choice",-1);
}

function Shop_IsBuyFree(){
	return instance_exists(shop) ? shop._buy_free : false;
}

///@arg free
function Shop_SetBuyFree(v){
	if(!instance_exists(shop))return false;
	shop._buy_free=v;
	return true;
}

function Shop_GetBuyResult(){
	return instance_exists(shop) ? shop._buy_result : SHOP_BUY_RESULT.NULL;
}

///@arg result  SHOP_BUY_RESULT.*
function Shop_SetBuyResult(r){
	if(!instance_exists(shop))return false;
	shop._buy_result=r;
	return true;
}

function Shop_GetSellResult(){
	return instance_exists(shop) ? shop._sell_result : SHOP_SELL_RESULT.NULL;
}

///@arg result  SHOP_SELL_RESULT.*
function Shop_SetSellResult(r){
	if(!instance_exists(shop))return false;
	shop._sell_result=r;
	return true;
}

function Shop_GetLastBuyItem(){
	return shop._buy_item;
}

function Shop_GetLastSellItem(){
	return shop._sell_item;
}