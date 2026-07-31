instance_create_depth(0,0,DEPTH_SHOP.UI,shop_ui);
instance_create_depth(0,0,DEPTH_SHOP.UI,shop_ui_itemdesc);

var BGM=Shop_GetBGM(_shop_id);
if(audio_exists(BGM)){
	BGM_Play(4,BGM);
	BGM_Pause(0);
}

_host_inst=instance_create_depth(320,240,DEPTH_SHOP.HOST,_host_object);

Shop_ResetMainChoices();
Shop_CallHostEvent(SHOP_HOST_EVENT.SHOP_INIT);
Shop_SetState(SHOP_STATE.MENU,true);