/// MENU_SWITCH — exit / empty-sell / steal-once / unlock conditional stock
/*
// 进入购买菜单
if(Shop_GetNextMenu()==SHOP_MENU.BUY&&Shop_GetMenu()==SHOP_MENU.MENU){
	Dialog_Add("* Let's see what's on sale...");
}

// 进入出售菜单
if(Shop_GetNextMenu()==SHOP_MENU.SELL&&Shop_GetMenu()==SHOP_MENU.MENU){
	Dialog_Add("* What do you want to sell?");
}

// 进入对话菜单
if(Shop_GetNextMenu()==SHOP_MENU.TALK&&Shop_GetMenu()==SHOP_MENU.MENU){
	Dialog_Add("* Sure, what's on your mind?");
}

// 退出购买菜单
if(Shop_GetNextMenu()==SHOP_MENU.MENU&&Shop_GetMenu()==SHOP_MENU.BUY){
	Dialog_Add("* Done shopping?");
}

// 退出出售菜单
if(Shop_GetNextMenu()==SHOP_MENU.MENU&&Shop_GetMenu()==SHOP_MENU.SELL){
	Dialog_Add("* Keeping your stuff? Alright.");
}

// 退出对话菜单
if(Shop_GetNextMenu()==SHOP_MENU.MENU&&Shop_GetMenu()==SHOP_MENU.TALK){
	Dialog_Add("* Come back anytime!");
}*/

// 离开商店
if(Shop_GetNextMenu()==SHOP_MENU.EXIT){
	if(_geno){
		Dialog_Add("* Finally. Don't come back.");
	}else{
		Dialog_Add("* Thanks for stopping by!&* Stay safe out there.");
	}
}

// 空背包无法出售
if(Shop_GetNextMenu()==SHOP_MENU.SELL){
	if(Item_GetNumber() <= 0){
		Shop_SetNextMenu(SHOP_MENU.MENU);
		Dialog_Add("* You don't have anything to sell.");
	}
}

// Geno steal (main slot 1): only once
if(_geno&&Shop_GetNextMenu()==SHOP_MENU.MENU&&shop._menu_choice==1){
	var steal_key=Shop_GetHostShortName()+"_steal";
	var steal_data=Flag_GetStorage(FLAG_PLOT);
	if(steal_data.Get(steal_key,0)==0){
		steal_data.Set(steal_key,1);
		Player_AddGold(50);
		Dialog_Add("{define `GOLD` 50}"+Lang_GetString("shop.demo.steal"));
		Shop_SetMainChoice(1,SHOP_MAIN_ACTION.DIALOG,Lang_GetString("shop.menu.choice.steal","Steal"),"* You already stole everything.");
	}
}

// Talk 0 progressed → unlock ribbon (index 2)
if(Shop_GetTalkProgress(0)>=2&&Shop_GetBuyNumber()>2){
	if(Shop_GetBuyBuyable(2)==SHOP_BUYABLE.UNBUYABLE){
		Shop_PatchBuy(2,{
			buyable:SHOP_BUYABLE.BUYABLE,
			desc:"* A faded pink ribbon.&* It smells like flowers."
		});
	}
}

// Talk 3 (A joke) first completion → append bonus talk
var bonus_key=Shop_GetHostShortName()+"_bonus_talk";
if(Shop_GetTalkProgress(3)>=2&&Flag_Get(FLAG_PLOT,bonus_key,0)==0){
	Flag_Set(FLAG_PLOT,bonus_key,1);
	Shop_AddTalk("Hidden Joke","* OK fine, one more.&*&* What do you call&  a skeleton who won't work?&* Lazy bones!");
	Shop_SetTalkProgress(Shop_GetTalkNumber()-1,1);
}