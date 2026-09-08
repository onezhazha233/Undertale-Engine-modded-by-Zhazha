a += 1.5;

for(var i=0;i<40;i+= 2){
    a += 1;
    var xx = -20 + sin(a / boff) * coff;

    for (var j = -1; j < 44; j++) {
        for (var k = 0; k < 11; k++) {
            draw_sprite_part(sprite_index, image_index, 0, i, sprite_width, 2, xx + j * 20, i + k * 40);
        }
    }
}

siner += 1/2;
draw_sprite_ext(spr_pixel,0,0,0,room_width,room_height,0,0,((sin((siner / 12)) * 0.3) + 0.5));