///@desc Anim
if(Battle_GetMenuFightDamage()>0){
	var ENEMY=Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
	var X=Battle_GetEnemyCenterPosX(ENEMY);
	var Y=Battle_GetEnemyCenterPosY(ENEMY);
	var anim=instance_create_depth(X,Y,0,battle_menu_fight_anim_shoe);
	if(_crit){
		anim.image_blend=merge_color(c_yellow,c_white,0.5);
		audio_play_sound(snd_shoe_crit,0,false);
	}
	Anim_Create(id,"image_alpha",0,0,1,-1,30);
}