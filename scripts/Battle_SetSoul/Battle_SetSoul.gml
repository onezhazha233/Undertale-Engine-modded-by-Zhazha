///@arg soul_obj,*spr
function Battle_SetSoul() {
	var SOUL=argument[0];

	if(Battle_IsSoulValid(SOUL)&&object_exists(SOUL)){
		var X=-100
		var Y=-100
		if(instance_exists(battle_soul)){
			X=battle_soul.x;
			Y=battle_soul.y;
			instance_destroy(battle_soul);
		}
		var inst=instance_create_depth(X,Y,DEPTH_BATTLE.SOUL,SOUL);
		if(argument_count>1){
		inst.default_spr=argument[1]
		inst.sprite_index=argument[1]
		}
		return true;
	}else{
		return false;
	}


}
