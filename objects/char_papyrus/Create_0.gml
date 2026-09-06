event_inherited();

char_id=1;

res_idle_sprite[DIR.DOWN]=spr_char_papyrus_down;
res_idle_sprite[DIR.LEFT]=spr_char_papyrus_right;
res_idle_sprite[DIR.RIGHT]=spr_char_papyrus_right;

res_move_sprite[DIR.DOWN]=spr_char_papyrus_down;
res_move_sprite[DIR.LEFT]=spr_char_papyrus_right;
res_move_sprite[DIR.RIGHT]=spr_char_papyrus_right;

res_talk_sprite[DIR.DOWN]=spr_char_papyrus_down_talk;

res_idle_flip_x[DIR.LEFT] = true;
res_move_flip_x[DIR.LEFT] = true;
res_talk_flip_x[DIR.LEFT] = true;

move_speed[DIR.UP]=1.5;
move_speed[DIR.DOWN]=1.5;
move_speed[DIR.LEFT]=1.5;
move_speed[DIR.RIGHT]=1.5;