var _s = 0.5; // 缩放补偿：镜头放大一倍，因此缩小一半

var spike_spr=(wide_spike ? spr_battle_dialog_enemy_spike_wide : spr_battle_dialog_enemy_spike);
var corner_spr=spr_battle_dialog_enemy_corner;

var cw = sprite_get_width(corner_spr) * _s;
var ch = sprite_get_height(corner_spr) * _s;

//四角（保留负值翻转）
//左上
draw_sprite_ext(corner_spr,0,x-left-cw,y-up-ch,_s,_s,0,c_white,1);
//左下
draw_sprite_ext(corner_spr,0,x-left-cw,y+down+ch+_s,_s,-_s,0,c_white,1);
//右上
draw_sprite_ext(corner_spr,0,x+right+cw,y-up-ch,-_s,_s,0,c_white,1);
//右下
draw_sprite_ext(corner_spr,0,x+right+cw,y+down+ch+_s,-_s,-_s,0,c_white,1);

//边框（厚度缩放为 _s）
//上
draw_sprite_ext(spr_pixel,0,x-left,y-up-ch,left+right,_s,0,c_black,1);
//左
draw_sprite_ext(spr_pixel,0,x-left-cw,y-up,_s,up+down+_s,0,c_black,1);
//下
draw_sprite_ext(spr_pixel,0,x-left,y+down+ch,left+right,_s,0,c_black,1);
//右
draw_sprite_ext(spr_pixel,0,x+right+cw-_s,y-up,_s,up+down+_s,0,c_black,1);

//填充
//横向填充
draw_sprite_ext(spr_pixel,0,x-left-cw+_s,y-up,cw-_s+left+right+cw-_s,up+down+_s,0,c_white,1);
//纵向填充
draw_sprite_ext(spr_pixel,0,x-left,y-up-ch+_s,left+right,ch-_s+up+down+ch,0,c_white,1);

//尖刺
if(show_spike){
	//朝左
	if(dir==DIR.LEFT){
		draw_sprite_ext(spike_spr,0,x-left-cw,y,_s,_s,0,c_white,1);
	}
	//朝右
	if(dir==DIR.RIGHT){
		draw_sprite_ext(spike_spr,0,x+right+cw,y,-_s,_s,0,c_white,1);
	}
	//朝上
	if(dir==DIR.UP){
		draw_sprite_ext(spike_spr,0,x,y-up-ch,-_s,_s,90,c_white,1);
	}
	//朝下
	if(dir==DIR.DOWN){
		draw_sprite_ext(spike_spr,0,x,y+down+ch+_s,_s,_s,90,c_white,1);
	}
}