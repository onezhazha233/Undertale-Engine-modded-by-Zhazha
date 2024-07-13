///@arg page
function Shop_SetMenuTalk(){
	var PAGE=argument[0];
	
	//更新文字
	var text="";
	for(i=PAGE*4;i<PAGE*4+4;i+=1){
		if(i < ds_list_size(shop._host_talk)){
			text += shop._host_talk[|i]+"&";
		}
		else{
			text += "&";
		}
	}
	text += Lang_GetString("shop.menu.exit");
	if(Shop_GetTalkPageMax() > 1)text += "                      "+"{define `PAGE` `"+string(PAGE)+"`}"+Lang_GetString("shop.menu.page");
	Shop_SetDialog(text,true);
	Dialog_Clear();
	
	return true;
}