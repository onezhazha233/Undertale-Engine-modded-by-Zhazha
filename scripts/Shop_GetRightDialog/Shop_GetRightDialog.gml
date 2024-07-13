function Shop_GetRightDialog(){
	if(instance_exists(shop._inst_right_dialog)){
		return GetPlainText(shop._inst_right_dialog);
	}
	else{
		return false;
	}
}