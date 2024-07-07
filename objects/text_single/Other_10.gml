///@desc Draw
RenderCharEval();

var HALIGN_ORI = draw_get_halign();
draw_set_halign(halign);
draw_set_valign(valign);

if(font_exists(font)||FORCE_TYPE=1){
	draw_set_font(font);
	if(shadow){
		RenderCharFixed(shadow_x * scale_x, shadow_y * scale_y, color_shadow, _tmpAS);
	}
	if(outline){	
		var XO_OH = lengthdir_x(1,angle);
		var YO_OH = lengthdir_y(1,angle);
		var XO_OV = lengthdir_x(1,angle-90);
		var YO_OV = lengthdir_y(1,angle-90);
		for(PROC=1;PROC<= scale_x;PROC+=1){
			RenderCharFixed(XO_OH*PROC,YO_OH*PROC,color_outline,_tmpAO);
			RenderCharFixed(-XO_OH*PROC,-YO_OH*PROC,color_outline,_tmpAO);
		}
		for(PROC=1;PROC<= scale_y;PROC+=1){
			RenderCharFixed(XO_OV*PROC,YO_OV*PROC,color_outline,_tmpAO);
			RenderCharFixed(-XO_OV*PROC,-YO_OV*PROC,color_outline,_tmpAO);
		}
	}
	RenderCharFixed(0,0);
}

if(sprite_exists(sprite)){
	RenderSprFixed(0,0);
}

/*
draw_set_halign(1);
draw_set_valign(1);
draw_text(x, y, _line)
*/

draw_set_halign(HALIGN_ORI);
/*live;
///@desc Draw
draw_set_halign(align=0 ? fa_left : (align=1 ? fa_center : fa_right))
if(font_exists(font)){
	draw_set_font(font);
	if(shadow){
		draw_text_transformed_color(x+_offset_x+shadow_x*scale_x,y+_offset_y+shadow_y*scale_y,text,scale_x,scale_y,angle,color_shadow[0],color_shadow[1],color_shadow[3],color_shadow[2],alpha_shadow*alpha);
	}
	if(outline){
		var proc=0;
		repeat(scale_x){
			proc+=1;
			draw_text_transformed_color(x+_offset_x+proc,y+_offset_y,text,scale_x,scale_y,angle,color_outline[0],color_outline[1],color_outline[3],color_outline[2],alpha_outline*alpha);
			draw_text_transformed_color(x+_offset_x-proc,y+_offset_y,text,scale_x,scale_y,angle,color_outline[0],color_outline[1],color_outline[3],color_outline[2],alpha_outline*alpha);
		}
		proc=0;
		repeat(scale_y){
			proc+=1;
			draw_text_transformed_color(x+_offset_x,y+_offset_y+proc,text,scale_x,scale_y,angle,color_outline[0],color_outline[1],color_outline[3],color_outline[2],alpha_outline*alpha);
			draw_text_transformed_color(x+_offset_x,y+_offset_y-proc,text,scale_x,scale_y,angle,color_outline[0],color_outline[1],color_outline[3],color_outline[2],alpha_outline*alpha);
		}
	}
	draw_text_transformed_color(x+_offset_x,y+_offset_y,text,scale_x,scale_y,angle,color_text[0],color_text[1],color_text[3],color_text[2],alpha_text*alpha);
}
if(sprite_exists(sprite)){
	draw_sprite_ext(sprite,sprite_image,x+_offset_x,y+_offset_y,scale_x,scale_y,angle,color_text[0],alpha_text*alpha);
}
draw_set_halign(fa_left)