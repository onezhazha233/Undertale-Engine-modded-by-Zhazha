function Event_Step(){
	for(var i=0;i<array_length(global.events);i+=1){
	    var ee = global.events[i];
	    if(ee.active && !ee.paused) {
	        if(ee._room != room){
	            ee.active = false;
	            continue;
	        }
	        if(ee.currentIndex < array_length(ee.functions)){
	            ee.timer -= 1;
	            if(ee.timer <= 0) {
	                var func = ee.functions[ee.currentIndex];
	                if(ee.currentIndex != ee.lastCustomIndex){
	                    func.init();
	                    ee.lastCustomIndex = ee.currentIndex;
	                }
	                if(func.update()) {
	                    ee.timer = 0;
	                }else {
	                    ee.timer = ee.delays[ee.currentIndex];
	                    ee.currentIndex += 1;
	                }
	            }
	        }
			else{
	            ee.active = false;
	        }
	    }
	}
}