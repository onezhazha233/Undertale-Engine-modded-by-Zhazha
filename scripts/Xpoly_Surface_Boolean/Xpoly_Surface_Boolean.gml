//这个函数为surface提供布尔运算
function Xpoly_Surface_Boolean(surface1, surface2, surface_helper, type)
{
    // ---- 参数合法性检查 ----
    if (!surface_exists(surface1)) return false;
    if (!surface_exists(surface2)) return false;
    if (!surface_exists(surface_helper)) return false;

    // 保存当前绘制目标和混合模式，以便恢复
    var prev_blend = gpu_get_blendmode();
	
    // 工具函数：在指定 surface 上执行一次"带混合模式的绘制"
    // 我们用 surface_helper 作为通用中间缓冲

    switch (type)
    {
        // ============================================================
        // UNION：并集 —— 任一为白色即为白色
        // 策略：surface1 已在其上，再把 surface2 以 bm_max 画上去取 alpha 最大值
        // ============================================================
        case BATTLE_BOARD_TYPE.ADD:
        {
            surface_set_target(surface1);
            gpu_set_blendmode(bm_normal);
            draw_surface(surface2, 0, 0);
            gpu_set_blendmode(prev_blend);
            surface_reset_target();
            break;
        }

        // ============================================================
        // INTERSECT：交集 —— 两者都为白色才为白色
        // 策略：result = surface1 * surface2（alpha 相乘）
        // 用 helper 先画 surface1，再在 helper 上以 bm_normal 画 surface2（src_alpha 控制）
        // 实际上最稳妥：helper = surface1，然后 surface1 = helper * surface2
        // ============================================================
        case BATTLE_BOARD_TYPE.INTERSECT:
        {
            surface_set_target(surface1);
            gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
            draw_surface(surface2, 0, 0);
			gpu_set_blendmode(prev_blend)
            surface_reset_target();
            break;
        }

        // ============================================================
        // DIFFERENCE：差集 —— surface1 减去 surface2（surface1 有且 surface2 无）
        // 策略：result = surface1 * (1 - surface2.alpha)
        // ============================================================
        case BATTLE_BOARD_TYPE.SUBTRACT:
        {
            surface_set_target(surface1);
            gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha)
            draw_surface(surface2, 0, 0);
			gpu_set_blendmode(prev_blend)
            surface_reset_target();
            break;
        }

        default:
        {
            // 未知操作，不做处理
            return false;
        }
    }
	
    return true;
}