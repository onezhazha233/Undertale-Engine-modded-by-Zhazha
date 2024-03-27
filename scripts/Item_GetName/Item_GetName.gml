///@arg item_id
function Item_GetName() {
	var ITEM=argument[0];

	if(Item_IsValid(ITEM)){
		var INST=instance_create_depth(0,0,0,ITEM);
		var NAME=INST._name;
		if(Player_IsInBattle()){
			if!(INST._name_short = "Item"){
				NAME=INST._name_short;
			}
			if(Battle_IsSerious()){
				if!(INST._name_short_serious = "Item"){
					NAME=INST._name_short_serious;
				}
			}
		}
		instance_destroy(INST);
		return NAME;
	}else{
		return "";
	}
}