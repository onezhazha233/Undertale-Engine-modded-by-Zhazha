function Item_GetName(ITEM,TYPE=-1){
	if(Item_IsValid(ITEM)){
		var INST=instance_create_depth(0,0,0,ITEM);
		var NAME=INST._name;
		if(Player_IsInBattle()){
			if(INST._name_short!="")NAME=INST._name_short;
			if(Battle_IsSerious()){
				if(INST._name_short_serious!="")NAME=INST._name_short_serious;
			}
		}
		if(TYPE!=-1){
			switch(TYPE){
				case 0:	NAME=INST._name; break;
				case 1:	NAME=INST._name_short; break;
				case 2:	NAME=INST._name_short_serious; break;
			}
		}
		instance_destroy(INST);
		return NAME;
	}else{
		return "!!UnknownItem!!";
	}
}