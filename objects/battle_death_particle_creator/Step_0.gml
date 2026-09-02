if(surface_exists(surf)){
	pixel = 0;
	a = 0;
	r = 0;
	g = 0;
	b = 0;
	delay = 0;
	
	for(i=0;i<rowspd;i+=1){
		if(height+i < h){
			for(j=0;j<w;){
				pixel = buffer_peek(buff,4*(j+((height+i)*w)),buffer_u32);
				a = (pixel >> 24) & 255;
			    r = pixel & 255;
			    g = (pixel >> 8) & 255;
			    b = (pixel >> 16) & 255;
				
				if(a > 0){
					ed = 0;
				    gg = random(0.25) + 0.1;
				    hh = random(2) - 1;
					var _run_start = j;
					var _run_end = j + 1;
					var _run_r = r;
					var _run_g = g;
					var _run_b = b;
					var _run_a = a;
					
					while(_run_end < w){
						var _next_pixel = buffer_peek(buff,4*(_run_end+((height+i)*w)),buffer_u32);
						var _next_a = (_next_pixel >> 24) & 255;
						var _next_r = _next_pixel & 255;
						var _next_g = (_next_pixel >> 8) & 255;
						var _next_b = (_next_pixel >> 16) & 255;
						
						if(_next_a == _run_a && _next_r == _run_r && _next_g == _run_g && _next_b == _run_b){
							_run_end += 1;
						}
						else{
							break;
						}
					}
					
					ll = _run_end - _run_start;
					if(r+g+b == 0){
			            ed = random(3);
			            gg = random(0.25) + 0.1;
			            hh = random(2) - 1;
			        }
					
					var _p = {
						px: x+(_run_start-xoff)*scale_x,
						py: y+(height+i-yoff)*scale_y,
						psx: scale_x*ll,
						psy: scale_y,
						pdelay: (height+i+ed)*spd,
						pgg: gg,
						phh: hh,
						pslow: slow,
						pblend: make_color_rgb(r,g,b),
						pr: r,
						pg: g,
						pb: b,
						palpha: 1,
						pfading: 0,
						pvspeed: 0,
						active: true
					};
					array_push(particles, _p);
					active_count += 1;
					
					j = _run_end;
				}
				else{
					j += 1;
				}
			}
			sheight += 1;
		}
		else{
			all_rows_done = true;
			break;
		}
	}
	height += rowspd;
}

for(var _i = 0; _i < array_length(particles); _i += 1){
	var _p = particles[_i];
	if(!_p.active) continue;
	
	if(_p.pblend == make_color_rgb(0,0,0)){
		_p.palpha -= 0.2 * _p.pfading * (_p.pslow ? 0.6 : 1);
	}
	
	if(_p.pdelay > 0 && _p.pfading == 0){
		_p.pdelay -= 1;
	}
	else{
		if(_p.pfading == 0){
			_p.pfading = 1;
			_p.pr = _p.pblend & 255;
			_p.pg = (_p.pblend >> 8) & 255;
			_p.pb = (_p.pblend >> 16) & 255;
		}
		_p.pvspeed += _p.pgg * (_p.pslow ? 0.3 : 1);
		_p.py -= _p.pvspeed;
		_p.px += _p.phh;
	}
	
	if(_p.palpha <= 0){
		_p.active = false;
		active_count -= 1;
		continue;
	}
	
	if(_p.phh != 0 && _p.pfading == 1){
		_p.palpha -= 0.05 * (_p.pslow ? 0.6 : 1);
		if!(_p.pr + _p.pg + _p.pb == 0){
			_p.pr += (255 - _p.pr) / 4;
			_p.pg += (255 - _p.pg) / 4;
			_p.pb += (255 - _p.pb) / 4;
			_p.pblend = make_color_rgb(_p.pr, _p.pg, _p.pb);
		}
	}
}

if(all_rows_done && active_count <= 0){
	instance_destroy();
}