event_inherited();

_dir=choose(DIR.LEFT,DIR.RIGHT);
_input_acceptable=true;
_aim_x=0;
_aim_image=0;

if(_dir==DIR.LEFT){
	_aim_x=x+battle_board.right+sprite_get_width(spr_battle_menu_fight_aim)/2;
	Anim_Create(id,"_aim_x",0,0,_aim_x,-(battle_board.left+battle_board.right+sprite_get_width(spr_battle_menu_fight_aim)),90*0.8);
}else{
	_aim_x=x-battle_board.left-sprite_get_width(spr_battle_menu_fight_aim)/2;
	Anim_Create(id,"_aim_x",0,0,_aim_x,battle_board.left+battle_board.right+sprite_get_width(spr_battle_menu_fight_aim),90*0.8);
}

_attack=0;
_attack_time=0;

attack_max=4;
attack_time_max=60;

damage = 0