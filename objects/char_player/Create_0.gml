event_inherited();

char_id=0;

res_idle_sprite[DIR.UP]=spr_char_frisk_up;
res_idle_sprite[DIR.DOWN]=spr_char_frisk_down;
res_idle_sprite[DIR.LEFT]=spr_char_frisk_right;
res_idle_sprite[DIR.RIGHT]=spr_char_frisk_right;
res_move_sprite[DIR.UP]=spr_char_frisk_up;
res_move_sprite[DIR.DOWN]=spr_char_frisk_down;
res_move_sprite[DIR.LEFT]=spr_char_frisk_right;
res_move_sprite[DIR.RIGHT]=spr_char_frisk_right;

move_speed[DIR.UP]=1.5;
move_speed[DIR.DOWN]=1.5;
move_speed[DIR.LEFT]=1.5;
move_speed[DIR.RIGHT]=1.5;

moveable=true;
_moveable_dialog=true;
_moveable_menu=true;
_moveable_save=true;
_moveable_warp=true;
_moveable_encounter=true;
_moveable_box=true;
_moveable_shop=true;