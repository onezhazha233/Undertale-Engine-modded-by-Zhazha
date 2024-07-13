function Shop_GotoNextMenu(){
	if(Shop_GetNextMenu() > -1){
		Shop_SetMenu(Shop_GetNextMenu());
		Shop_SetNextMenu(-1);
	}
}
