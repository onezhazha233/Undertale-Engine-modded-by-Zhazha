size += 0.04;
image_xscale = size;
image_yscale = size;
image_alpha -= 0.035;

if(image_alpha < 0.1)instance_destroy();

image_angle += 3;