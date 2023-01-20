image_xscale = width/2-4
image_angle = angle
sprite_index = (sticky? spr_battle_platform_green: spr_battle_platform_purple);

if(Battle_GetState() != BATTLE_STATE.IN_TURN)instance_destroy();