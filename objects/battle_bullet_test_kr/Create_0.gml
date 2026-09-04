depth = DEPTH_BATTLE.BULLET_OUTSIDE_HIGH

image_xscale = 2
image_yscale = 2

kr = 6                    // innate karma：首次接触一次性叠加
_kr_innate_done = false   // 本发是否已给过 innate(区分“首帧”与“持续接触”)
dmg = 1                   // 每帧结算目标对应的直接伤害(奇数→用累加器峰谷)
_dmg_acc = 0              // 直接伤害小数累加器(60fps 平滑，DPS 与原版一致)
_kr_acc  = 0              // 持续 KR 小数累加器