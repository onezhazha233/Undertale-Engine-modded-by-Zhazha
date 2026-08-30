a = instance_create_depth(50,60,0,battle_dialog_enemy)
a.text = Lang_GetString("bd.test")

a = instance_create_depth(500,60,0,battle_dialog_enemy)
a.text = Lang_GetString("bd.test")
a.template = 1

a = instance_create_depth(140,200,0,battle_dialog_enemy)
a.text = Lang_GetString("bd.test")
a.template = 2

a = instance_create_depth(340,200,0,battle_dialog_enemy)
a.text = Lang_GetString("bd.test")
a.template = 3

a = instance_create_depth(500,200,0,battle_dialog_enemy)
a.text = Lang_GetString("bd.test")
a.template = 4
//Battle_SetSoul(battle_soul_blue)

Battle_SetBoardSize(65,65,65,65)