global.is_moving = 0
global._inv = 0
// Karma(KR) 结算计时器(帧) —— 完全移植自 c2-sans-fight-master(BTS) 的 KR 系统
kr_t = 0
// 同帧多子弹合并：本帧是否已结算过 KR 伤害(只让首颗生效，其余合并→显示原-1)
kr_hit_this_frame = false