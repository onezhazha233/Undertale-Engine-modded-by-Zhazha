draw_set_font(font_mars_needs_cunnilingus);
draw_set_color(c_white);
draw_text(x,y,Player_GetName()+"   LV "+string(Player_GetLv()));
draw_sprite(spr_battle_ui_hp,0,x+214,y+5);

draw_sprite_ext(spr_pixel,0,x+245,y,Player_GetHpMax()*1.25,21,0,make_color_rgb(192,0,0),1);
draw_sprite_ext(spr_pixel,0,x+245,y,Player_GetHp()*1.25,21,0,make_color_rgb(255,255,0),1);

//draw_text(x+245+Player_GetHpMax()*1.25+14,y,(Player_GetHp() < 10 ? "0" : "") + string(Player_GetHp())+" / "+string(Player_GetHpMax()));

kr_color = make_color_rgb(255,0,255)
if(Player_GetKr() > 0){
    color = kr_color;
}
else{
	color = c_white;
}
draw_sprite_ext(spr_pixel,0,x+245+Player_GetHp()*1.25,y,-Player_GetKr()*1.25,21,0,kr_color,1);

if!(Player_IsKrEnabled()){
	draw_text_transformed_color(x+245+Player_GetHpMax()*1.25+14,y,(Player_GetHp() < 10 ? "0" : "")+string(Player_GetHp())+" / "+string(Player_GetHpMax()),1,1,0,c_white,c_white,c_white,c_white,1);
}
else{
	draw_text_ext_transformed_color(x+245+Player_GetHpMax()*1.25+14,y,"    "+(Player_GetHp()<10 ? "0" : "")+string(Player_GetHp())+" / "+string(Player_GetHpMax()),-1,-1,1,1,0,color,color,color,color,1);
	draw_sprite_ext(spr_battle_ui_kr,0,x+245+Player_GetHpMax()*1.25+10,y+5,1,1,0,c_white,1);
}