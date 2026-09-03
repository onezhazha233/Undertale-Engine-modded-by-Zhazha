/// SHOP_INIT — catalog + route template
_geno=(Player_GetKills()>=1);

// 0: Bandage — default stock 1
Shop_AddBuy(item_bandage,15,Lang_GetString("shop.demo.buy.bandage.desc"));
// 1: Stick — stock 2
Shop_AddBuy(item_stick,5,Lang_GetString("shop.demo.buy.stick.desc"),SHOP_BUYABLE.BUYABLE,2);
// 2: Faded Ribbon — locked until Talk 0 heard once
Shop_AddBuy(item_faded_ribbon,25,Lang_GetString("shop.demo.buy.ribbon.locked"),SHOP_BUYABLE.UNBUYABLE);
// 3: Toy Knife — display only; geno Take unlocks
Shop_AddBuy(item_toy_knife,50,Lang_GetString("shop.demo.buy.knife.desc"),SHOP_BUYABLE.UNBUYABLE);
// 4: Phone — stock 1
Shop_AddBuy(item_tml,100,Lang_GetString("shop.demo.buy.tml.desc"));
// 5: Mystery Box — stock 1, infinite actually
Shop_AddBuy(item_sea_tea,40,Lang_GetString("shop.demo.buy.sea_tea.desc"));
Shop_PatchBuy(5,{display_name: Item_GetName(item_legendary_hero)})

// --- Talks ---

Shop_AddTalk(Lang_GetString("shop.demo.talk.0.name"),[
	Lang_GetString("shop.demo.talk.0"),
	Lang_GetString("shop.demo.talk.0.b")
]);

Shop_AddTalk(Lang_GetString("shop.demo.talk.1.name"),[
	Lang_GetString("shop.demo.talk.1"),
	Lang_GetString("shop.demo.talk.1.b")
]);

Shop_AddTalk(Lang_GetString("shop.demo.talk.2.name"),Lang_GetString("shop.demo.talk.2"));
Shop_AddTalk(Lang_GetString("shop.demo.talk.3.name"),Lang_GetString("shop.demo.talk.3"));
Shop_AddTalk(Lang_GetString("shop.demo.talk.4.name"),Lang_GetString("shop.demo.talk.4"));
Shop_AddTalk(Lang_GetString("shop.demo.talk.5.name"),Lang_GetString("shop.demo.talk.5"));

if(_geno){
	Shop_ApplyMainTemplate("geno");
	Shop_PatchBuy(3,{buyable: SHOP_BUYABLE.BUYABLE});
}