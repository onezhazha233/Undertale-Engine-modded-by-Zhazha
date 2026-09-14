///@arg index/event
///Removes an event from the registry; IOE may be an index into global.events or an event
///struct. While Event_Step is running the removal is deferred (marked _dead and swept after
///the loop), so init/update callbacks can safely delete events - including their own.
function Event_Delete(IOE){
	if(!variable_global_exists("events") || !is_array(global.events)){
		return false;
	}
	if(is_real(IOE)){
		if(IOE>=0 && IOE<array_length(global.events)){
			if(variable_global_exists("_event_stepping") && global._event_stepping){
				global.events[IOE]._dead = true;
			}else{
				array_delete(global.events,IOE,1);
			}
			return true;
		}
		return false;
	}
	if(is_struct(IOE)){
		for(var i=0;i<array_length(global.events);i+=1){
			if(global.events[i]==IOE){
				if(variable_global_exists("_event_stepping") && global._event_stepping){
					IOE._dead = true;
				}else{
					array_delete(global.events,i,1);
				}
				return true;
			}
		}
	}
	return false;
}
