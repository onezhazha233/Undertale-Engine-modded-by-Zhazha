if(instance_exists(block_cover)){
	with(block_cover){
		image_xscale = other.xscale/2+5;
		image_yscale = other.yscale/2+5+0.1;
		image_angle = other.angle;
		x = other.x;
		y = other.y;
	}
}
angle += rotate