instance_create_depth(0,0,0,shop_ui)
instance_create_depth(0,0,0,shop_ui_itemdesc)

var SHOP=Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP);
var BGM=Shop_GetBGM(SHOP);
if(audio_exists(BGM)){
	BGM_Play(4,BGM);
}

_host_object=instance_create_depth(320,240,DEPTH_SHOP.HOST,Shop_GetHost(SHOP));

//调用事件
Shop_CallHostEvent(SHOP_HOST_EVENT.SHOP_INIT);

Shop_SetState(SHOP_STATE.MENU,1)

Console_OutputLine("Shop initialized. Shop ID "+string(SHOP)+".");