function Shop_GetTalkPageMax(){
	var size = ds_list_size(shop._host_talk);
	
	if(size = 0){
		return 1;
	}
	else if(size mod 4 = 0){
		return size div 4;
	}
	else{
		return size div 4 + 1;
	}
}