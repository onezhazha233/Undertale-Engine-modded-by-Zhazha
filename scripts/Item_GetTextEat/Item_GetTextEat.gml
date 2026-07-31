///@arg item_name
function Item_GetTextEat(NAME){
	var result="{define `ITEM` `"+NAME+"`}";
	result+=Lang_GetString("item.eat");
	return result;
}
