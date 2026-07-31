/// SHOP_INIT — catalog + route template
//_geno=(Player_GetKills()>=1);

// 0: Bandage — default stock 1
Shop_AddBuy(item_bandage,15,"* A simple bandage.&* Heals 10 HP.");
// 1: Stick — stock 2
Shop_AddBuy(item_stick,5,"* A sturdy stick.&* Don't poke your eye out.",SHOP_BUYABLE.BUYABLE,2);
// 2: Faded Ribbon — locked until Talk 0 heard once
Shop_AddBuy(item_faded_ribbon,25,"* A faded pink ribbon.&* It's locked for now...",SHOP_BUYABLE.UNBUYABLE);
// 3: Toy Knife — display only; geno Take unlocks
Shop_AddBuy(item_toy_knife,50,"* A plastic knife.&* Looks... real enough.",SHOP_BUYABLE.UNBUYABLE);
// 4: Phone — stock 1
Shop_AddBuy(item_tml,100,"* tml");
// 5: Mystery Box — stock 1, infinite actually
Shop_AddBuy(item_bandage,200,"物品&帮你回复&超多的HP！&口感极其顺滑",SHOP_BUYABLE.BUYABLE,-1);
Shop_PatchBuy(5,{display_name: "S.补药"})

// --- Talks ---
// 0: About this place (2 segments)
Shop_AddTalk("About this place",[
	"* This shop has been here&for as long as I can remember.",
	"* Well, that's not very long.&But still! It's a nice place."
]);
// 1: Rumors (2 segments)
Shop_AddTalk("Rumors",[
	"* I heard there's a secret&door somewhere in the Ruins.",
	"* Don't tell anyone I told you.&* ...Oops."
]);
// 2: Advice (1 segment)
Shop_AddTalk("Advice",[
	"* Always carry a spare bandage.&* You never know when you'll need it."
]);
// 3: A joke (1 segment)
Shop_AddTalk("A joke",[
	"* Why did the skeleton&cross the road?&*&* ...&* He didn't. He fell apart."
]);
// 4: Secret (1 segment, appears after any purchase)
Shop_AddTalk("Secret",[
	"* Psst... come closer.&*&* The Mystery Box is totally&worth it. Trust me."
]);

if(_geno){
	Shop_ApplyMainTemplate("geno");
	Shop_PatchBuy(3,{buyable: SHOP_BUYABLE.BUYABLE});
}