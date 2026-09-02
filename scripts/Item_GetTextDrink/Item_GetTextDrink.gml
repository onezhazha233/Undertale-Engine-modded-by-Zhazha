///@arg item_name
function Item_GetTextDrink(NAME){
	var result="{define `ITEM` `"+NAME+"`}";
	result+=Lang_GetString("item.drink");
	return result;
}
