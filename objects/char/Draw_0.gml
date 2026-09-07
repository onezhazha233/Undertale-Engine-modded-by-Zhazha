var cx=x;
var cy=y;
if(camera.target==id){
	cx=floor(x);
	cy=floor(y);
}
draw_sprite_ext(sprite_index,image_index,floor(x),floor(y),image_xscale,image_yscale,image_angle,image_blend,image_alpha)