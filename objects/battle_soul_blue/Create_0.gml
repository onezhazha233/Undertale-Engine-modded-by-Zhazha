event_inherited()
moveable = 1
dir = 270
move = 0
impact = 1
impact_shake = true
impact_damage = false
on_block = 0
on_platform = 0
on_board = 0
inst_plat = noone

jump_state = 0
//0为在地上不动 1为向上跳 2为自由下落
gravity_jump = 0.15
gravity_fall = 0.15
jump_speed = 4.8
max_speed = 20

moving = 0

/*
这是一个向左甩灵魂的代码示例，最后四行不能漏掉

Here is a example of slaming soul, last 4 lines mustn't be omitted

battle_soul.dir = 90;
battle_soul.move = 6;
battle_soul.impact = 1;
battle_soul.jump_state = 2;
battle_soul.on_block = 0;
battle_soul.on_board = 0;
battle_soul.on_platform = 0;
