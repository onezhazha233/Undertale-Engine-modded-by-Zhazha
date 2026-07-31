/// Shop catalog: buy list, talk list, stock/talk save, TryBuy/TrySell

/// Host object name without shop_host_ prefix (talk/stock keys).
function Shop_GetHostShortName(){
	var host_name="shop";
	if(instance_exists(shop)&&object_exists(shop._host_object)){
		host_name=object_get_name(shop._host_object);
	}
	var prefix="shop_host_";
	if(string_pos(prefix,host_name)==1){
		host_name=string_delete(host_name,1,string_length(prefix));
	}
	return host_name;
}

function Shop_GetBuyEntry(index){
	if(!instance_exists(shop))return undefined;
	if(index<0||index>=array_length(shop._buy_list))return undefined;
	return shop._buy_list[index];
}

/// Load stock from static if key exists (after AddBuy / SetBuy).
function Shop_LoadBuyStock(index){
	var e=Shop_GetBuyEntry(index);
	if(is_undefined(e))return false;
	var key=Shop_GetHostShortName()+"_stock_"+string(index);
	var s=Flag_Get(FLAG_PLOT,key,-999);
	if(s==-999)return false;
	if(!is_real(s))return false;
	e.stock=s;
	if(s==0){
		e.buyable=SHOP_BUYABLE.SELLOUT;
	}else if(s>0&&e.buyable==SHOP_BUYABLE.SELLOUT){
		e.buyable=SHOP_BUYABLE.BUYABLE;
	}
	return true;
}

/// Persist finite stock; infinite (-1) stored as-is.
function Shop_SaveBuyStock(index){
	var e=Shop_GetBuyEntry(index);
	if(is_undefined(e))return false;
	var key=Shop_GetHostShortName()+"_stock_"+string(index);
	var s=variable_struct_exists(e,"stock") ? e.stock : 1;
	Flag_Set(FLAG_PLOT,key,s);
	return true;
}

///@arg item_id
///@arg price
///@arg description*
///@arg buyable*  SHOP_BUYABLE.* (default BUYABLE)
///@arg stock*  remaining count (default -1); -1 = infinite
///@arg display_name*  override item name shown (default "" uses real item name)
function Shop_AddBuy(item_id,price,desc="",buyable=SHOP_BUYABLE.BUYABLE,stock=-1,display_name=""){
	return Shop_SetBuy(Shop_GetBuyNumber(),item_id,price,desc,buyable,stock,display_name);
}

/// Replace buy-list entry at index (or append if index==length).
///@arg index
///@arg item_id
///@arg price
///@arg description*
///@arg buyable*  SHOP_BUYABLE.* (default BUYABLE)
///@arg stock*  remaining count (default -1); -1 = infinite
///@arg display_name*  override item name shown (default "" uses real item name)
function Shop_SetBuy(index,item_id,price,desc="",buyable,stock=-1,display_name=""){
	if(!instance_exists(shop))return false;
	var n=array_length(shop._buy_list);
	if(index<0||index>n)return false;
	if(stock<-1)stock=-1;
	var entry={
		item_id:item_id,
		price:price,
		desc:desc,
		buyable:buyable,
		stock:stock
	};
	if(display_name!="")entry.display_name=display_name;
	if(stock==0)entry.buyable=SHOP_BUYABLE.SELLOUT;
	if(index==n){
		array_push(shop._buy_list,entry);
	}else{
		shop._buy_list[index]=entry;
	}
	Shop_LoadBuyStock(index);
	return true;
}

/// Patch fields on an existing buy entry. Optional keys: price, desc, buyable, stock.
/// stock: -1 infinite; 0 → SELLOUT; >0 restocks SELLOUT → BUYABLE (and saves).
function Shop_PatchBuy(index,patch){
	var e=Shop_GetBuyEntry(index);
	if(is_undefined(e)||!is_struct(patch))return false;
	if(variable_struct_exists(patch,"price"))e.price=patch.price;
	if(variable_struct_exists(patch,"desc"))e.desc=patch.desc;
	if(variable_struct_exists(patch,"display_name"))e.display_name=patch.display_name;
	if(variable_struct_exists(patch,"buyable"))e.buyable=patch.buyable;
	if(variable_struct_exists(patch,"stock")){
		var stock=patch.stock;
		if(stock<0){
			e.stock=-1;
		}else{
			e.stock=stock;
			if(stock==0){
				e.buyable=SHOP_BUYABLE.SELLOUT;
			}else if(e.buyable==SHOP_BUYABLE.SELLOUT){
				e.buyable=SHOP_BUYABLE.BUYABLE;
			}
		}
		Shop_SaveBuyStock(index);
	}
	return true;
}

function Shop_RemoveBuy(index){
	if(!instance_exists(shop))return false;
	if(index<0||index>=array_length(shop._buy_list))return false;
	array_delete(shop._buy_list,index,1);
	return true;
}

function Shop_ClearBuy(){
	if(!instance_exists(shop))return false;
	shop._buy_list=[];
	return true;
}

function Shop_GetBuyNumber(){
	return instance_exists(shop) ? array_length(shop._buy_list) : 0;
}

function Shop_GetBuyPageMax(){
	return max(1,ceil(Shop_GetBuyNumber()/4));
}

function Shop_GetBuyChoice(){
	if(!instance_exists(shop))return -1;
	return shop._page_buy*4+shop._buy_choice;
}

function Shop_GetBuyName(index){
	var e=Shop_GetBuyEntry(index);
	if(is_undefined(e))return "";
	if(variable_struct_exists(e,"display_name"))return e.display_name;
	return Item_GetName(e.item_id);
}

function Shop_GetBuyPrice(index){
	var e=Shop_GetBuyEntry(index);
	return is_undefined(e) ? 0 : e.price;
}

function Shop_GetBuyDesc(index){
	var e=Shop_GetBuyEntry(index);
	return is_undefined(e) ? "" : e.desc;
}

function Shop_GetBuyBuyable(index){
	var e=Shop_GetBuyEntry(index);
	return is_undefined(e) ? SHOP_BUYABLE.UNBUYABLE : e.buyable;
}

/// Remaining stock; -1 = infinite. Missing field defaults to 1.
function Shop_GetBuyStock(index){
	var e=Shop_GetBuyEntry(index);
	if(is_undefined(e))return 1;
	if(!variable_struct_exists(e,"stock"))return 1;
	return e.stock;
}

/// True only for BUYABLE (not UNBUYABLE / SELLOUT).
///@arg index
function Shop_IsBuyChoiceAvailable(index){
	return Shop_GetBuyBuyable(index)==SHOP_BUYABLE.BUYABLE;
}

///@arg name
///@arg dialog*  string, or array of stage strings
///@arg flag_key*  static key; default {hostShortName}_talk_{talkIndex}
function Shop_AddTalk(name,dialog="",flag_key=""){
	if(!instance_exists(shop))return false;

	var dialogs=[];
	if(is_array(dialog)){
		dialogs=dialog;
	}else if(is_string(dialog)&&dialog!=""){
		dialogs=[dialog];
	}

	var index=array_length(shop._talk_list);
	if(flag_key=="")flag_key=Shop_GetHostShortName()+"_talk_"+string(index);

	array_push(shop._talk_list,{
		name:name,
		dialogs:dialogs,
		flag_key:flag_key
	});
	return true;
}

function Shop_GetTalkNumber(){
	return instance_exists(shop) ? array_length(shop._talk_list) : 0;
}

function Shop_GetTalkPageMax(){
	return max(1,ceil(Shop_GetTalkNumber()/4));
}

function Shop_GetTalkChoice(){
	if(!instance_exists(shop))return -1;
	return shop._page_talk*4+shop._talk_choice;
}

function Shop_GetTalkName(index){
	if(!instance_exists(shop))return "";
	if(index<0||index>=array_length(shop._talk_list))return "";
	return shop._talk_list[index].name;
}

/// 0 never / odd = NEW unread / even = read (+ NEW for next if more)
function Shop_GetTalkProgress(index){
	if(!instance_exists(shop))return 0;
	if(index<0||index>=array_length(shop._talk_list))return 0;
	return Flag_Get(FLAG_PLOT,shop._talk_list[index].flag_key)
}

function Shop_SetTalkProgress(index,progress){
	if(!instance_exists(shop))return false;
	if(index<0||index>=array_length(shop._talk_list))return false;
	Flag_Set(FLAG_PLOT,shop._talk_list[index].flag_key,progress)
	return true;
}

function Shop_GetTalkStageCount(index){
	if(!instance_exists(shop))return 0;
	if(index<0||index>=array_length(shop._talk_list))return 0;
	return array_length(shop._talk_list[index].dialogs);
}

function Shop_GetTalkDialogIndex(index){
	var n=Shop_GetTalkStageCount(index);
	if(n<=0)return 0;
	var p=Shop_GetTalkProgress(index);
	var stage=0;
	if(p<=0){
		stage=0;
	}else if(p mod 2==1){
		stage=(p-1) div 2;
	}else{
		stage=p div 2;
	}
	return clamp(stage,0,n-1);
}

function Shop_IsTalkNew(index){
	var n=Shop_GetTalkStageCount(index);
	if(n<=0)return false;
	var p=Shop_GetTalkProgress(index);
	if(p==1)return true;
	if(p>=3&&(p mod 2==1))return true;
	if(n>1&&p>=2&&(p mod 2==0)&&(p div 2)<n)return true;
	return false;
}

function Shop_GetTalkDialog(index){
	if(!instance_exists(shop))return "";
	if(index<0||index>=array_length(shop._talk_list))return "";
	var dialogs=shop._talk_list[index].dialogs;
	var n=array_length(dialogs);
	if(n<=0)return "";
	return dialogs[Shop_GetTalkDialogIndex(index)];
}

/// After selecting a talk: 0/1→2, odd→+1, even→+2 (cap at 2*stageCount).
function Shop_AdvanceTalk(index){
	var n=Shop_GetTalkStageCount(index);
	if(n<=0)return false;
	var p=Shop_GetTalkProgress(index);
	var next;
	if(p<=0){
		next=2;
	}else if(p mod 2==1){
		next=p+1;
	}else{
		next=p+2;
	}
	var maxp=2*n;
	if(next>maxp)next=maxp;
	Shop_SetTalkProgress(index,next);
	return true;
}

/// Host may set _sell_refuse_text.
function Shop_GetSellRefuseText(){
	if(instance_exists(shop)&&instance_exists(shop._host_inst)){
		if(variable_instance_exists(shop._host_inst,"_sell_refuse_text")){
			var t=shop._host_inst._sell_refuse_text;
			if(is_string(t)&&t!="")return t;
		}
	}
	return Lang_GetString("shop.menu.sell.refuse");
}

function Shop_GetSellPriceLabel(item_id){
	var p=Item_GetPriceSell(item_id);
	if(p<=0)return Shop_GetSellRefuseText()+"G";
	return string(p)+"G";
}

function Shop_TryBuy(index){
	var e=Shop_GetBuyEntry(index);
	if(is_undefined(e))return SHOP_BUY_RESULT.UNABLE;
	if(!Shop_IsBuyChoiceAvailable(index))return SHOP_BUY_RESULT.UNABLE;
	var price=Shop_IsBuyFree() ? 0 : e.price;
	if(Player_GetGold()<price)return SHOP_BUY_RESULT.NO_MONEY;
	if(Item_GetNumber() >= 8)return SHOP_BUY_RESULT.NO_ROOM;
	if(price>0)Player_SetGold(Player_GetGold()-price);
	Item_Add(e.item_id);
	var stock=Shop_GetBuyStock(index);
	if(stock>=0){
		stock-=1;
		e.stock=stock;
		if(stock<=0){
			e.stock=0;
			e.buyable=SHOP_BUYABLE.SELLOUT;
		}
		Shop_SaveBuyStock(index);
	}
	audio_play_sound(snd_shop_item,0,false);
	return SHOP_BUY_RESULT.YES;
}

function Shop_TrySell(slot){
	if(slot<0||slot>=Item_GetNumber())return SHOP_SELL_RESULT.UNABLE;
	var item_id=Item_Get(slot);
	var price=Item_GetPriceSell(item_id);
	if(price<=0)return SHOP_SELL_RESULT.UNABLE;
	Player_SetGold(Player_GetGold()+price);
	Item_Remove(slot);
	if(instance_exists(shop))shop._sell_thanks+=1;
	audio_play_sound(snd_shop_item,0,false);
	return SHOP_SELL_RESULT.YES;
}
