if!(surface_exists(surf))surf = surface_create(sprite_get_width(sprite),sprite_get_height(sprite));

for(var _i = 0; _i < array_length(particles); _i += 1){
	var _p = particles[_i];
	if(!_p.active) continue;
	draw_sprite_ext(spr_pixel, 0, _p.px, _p.py, _p.psx, _p.psy, 0, _p.pblend, _p.palpha);
}

draw_sprite_part_ext(sprite,image,0,sheight,sprite_get_width(sprite),sprite_get_height(sprite)-sheight,x-sprite_get_xoffset(sprite)*scale_x,y-(sprite_get_yoffset(sprite)-sheight)*scale_y,scale_x,scale_y,-1,1)