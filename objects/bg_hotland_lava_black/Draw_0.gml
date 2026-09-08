for(i = 0; i < 40; i += 1){
    var alpha = ((sin(bg_hotland_lava.siner / 12) * 0.5) + 0.5) * (1 - (i / 40));

    draw_sprite_ext(spr_pixel,0,x,(y + 19) - i,20 * image_xscale,1,0,c_black,alpha);
}