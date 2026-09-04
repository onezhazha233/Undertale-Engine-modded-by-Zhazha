Battle_SetEnemyName(_enemy_slot,Lang_GetString("battle.enemy.krtest.name"))
Battle_SetEnemyActionNumber(_enemy_slot,4)
Battle_SetEnemyActionName(_enemy_slot,0,Lang_GetString("battle.enemy.krtest.action.0"))
Battle_SetEnemyActionName(_enemy_slot,1,Lang_GetString("battle.enemy.krtest.action.1"))
Battle_SetEnemyActionName(_enemy_slot,2,Lang_GetString("battle.enemy.krtest.action.2"))

Battle_SetEnemyDEF(_enemy_slot,0)
Battle_SetFleeableOverride(1)

Player_SetKrEnabled(true)
Player_SetKr(0)
Player_SetHpMax(92)
Player_SetHp(92)