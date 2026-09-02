if(Battle_GetMenu() = BATTLE_MENU.FIGHT_TARGET){
	a = instance_create_depth(0,0,0,battle_menu_fight_hp_bar);
	a.enemy_slot = _enemy_slot;
	a.hp_max = hp_max;
	a.hp = hp;
}
if(Battle_GetMenu() = BATTLE_MENU.FIGHT_DAMAGE){
	if(Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()) = _enemy_slot){
		if(Battle_GetMenuFightDamage() > 0){
			a = instance_create_depth(x,y-140,0,battle_damage);
			a.damage = Battle_GetMenuFightDamage();
			a.bar_hp_max = hp_max;
			a.bar_hp_original = hp;
			a.bar_hp_target = max(0,hp-Battle_GetMenuFightDamage());
			hp = max(0,hp-Battle_GetMenuFightDamage());
			a = instance_create_depth(0,0,0,shaker);
			a.target = id;
			a.var_name = "x";
			a.shake_distance = 10;
			a.shake_speed = 3;
			a.shake_decrease = 2;
			Anim_Create(id,"color_mix",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,0,1,30);
			if(hp > 0){
				Anim_Create(id,"color_mix",ANIM_TWEEN.QUAD,ANIM_EASE.IN,1,-1,30,30);
			}
			audio_play_sound(snd_damage,0,0);
		}
		else{
			a = instance_create_depth(x,y-140,0,battle_damage);
			a.damage = -1;
		}
	}
}