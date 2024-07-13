function Shop_EndDialog(){
	if(Shop_GetState()==SHOP_STATE.DIALOG){
		Shop_CallHostEvent(SHOP_HOST_EVENT.DIALOG_END);
		Shop_SetState(SHOP_STATE.MENU,false);
		Shop_GotoNextMenu();
		Dialog_Clear();
		return true;
	}else{
		return false;
	}
}