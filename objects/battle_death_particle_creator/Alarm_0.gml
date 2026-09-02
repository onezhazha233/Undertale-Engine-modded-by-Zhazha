if!(sprite_exists(sprite))instance_destroy();
w = sprite_get_width(sprite);
h = sprite_get_height(sprite);
xoff = sprite_get_xoffset(sprite);
yoff = sprite_get_yoffset(sprite);

surf = surface_create(w,h);
surface_set_target(surf);
draw_clear_alpha(c_black,0);
draw_sprite_ext(sprite,image,xoff,yoff,1,1,0,-1,1);
surface_reset_target();

buff = buffer_create(4*w*h,buffer_fixed,1);
buffer_get_surface(buff,surf,0);