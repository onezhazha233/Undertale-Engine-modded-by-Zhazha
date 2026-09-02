function Battle_CreateEnemyDust(X,Y,SPR,IMG=0,SCALE=2,OLD=false){
	var DUST;
	if(OLD){
		DUST = instance_create_depth(X,Y,depth,battle_death_particle);
	}
	else{
		DUST = instance_create_depth(X,Y,depth,battle_death_particle_creator);
	}
	DUST.sprite = SPR;
	DUST.image = IMG;
	DUST.scale_x = SCALE;
	DUST.scale_y = SCALE;
	audio_play_sound(snd_vaporize,0,0);
	
	return DUST;
}