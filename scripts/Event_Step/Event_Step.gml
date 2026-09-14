function Event_Step(){
	if(!variable_global_exists("events") || !is_array(global.events)){
		return false;
	}
	global._event_stepping = true;
	var current_Room = room;
	for(var i=0;i<array_length(global.events);i+=1){
		var ee = global.events[i];
		if(ee.active && !ee.paused && !ee._dead){
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
		//Room check runs for every active event, paused ones included.
		if(ee.active && !ee.persistent_room && current_Room != ee._room){
			ee.active = false;
		}
	}
	global._event_stepping = false;
	//Deferred deletions requested from inside init/update callbacks are swept here so the
	//iteration above never mutates the array it is walking.
	for(var i=array_length(global.events)-1;i>=0;i--){
		if(global.events[i]._dead){
			array_delete(global.events,i,1);
		}
	}
	return true;
}
