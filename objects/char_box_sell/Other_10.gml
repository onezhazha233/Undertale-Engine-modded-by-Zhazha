sell = Event_Create()
Event_Choice(sell,Lang_GetString("box_sell"),function(result){
	if(result = 0){
		if(Player_GetGold() >= 10){
			if(Item_GetNumber() < 8){
				Player_AddGold(-10);
				Item_Add(item_legendary_hero);
				dd = Event_Create();
				Event_Dialog(dd,"{ui_buy_destroy}{define `ITEM` `"+Item_GetName(item_legendary_hero)+"`}"+Lang_GetString("item.get"));
				Event_Launch(dd);
			}
			else{
				dd = Event_Create();
				Event_Dialog(dd,"{ui_buy_destroy}"+Lang_GetString("item.toomuch"));
				Event_Launch(dd);
			}
		}
		else{
			dd = Event_Create();
			Event_Dialog(dd,"{ui_buy_destroy}"+Lang_GetString("box_sell.nomoney"));
			Event_Launch(dd);
		}
	}
});
Event_Launch(sell);