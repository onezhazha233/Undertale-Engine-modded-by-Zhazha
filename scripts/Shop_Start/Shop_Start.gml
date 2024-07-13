///@arg shop_id
function Shop_Start(){
	var SHOP=argument[0];

	if(instance_exists(char_player))char_player._moveable_shop = true;
	if(Shop_IsExists(SHOP)){
		Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP,SHOP);
		
		Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP_ROOM_RETURN,room);
		room_persistent=true;

		room_goto(room_shop);
	
		return true;
	}else{
		Console_OutputLine("Shop ID "+string(SHOP)+" doesn't exists!");
		return false;
	}
}