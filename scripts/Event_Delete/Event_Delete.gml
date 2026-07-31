///@arg index/event
function Event_Delete(IOE){
	if(is_real(IOE)){
		array_delete(global.events,IOE,1);
		
		return true;
	}
	else if(is_struct(IOE)){
		for(i=0;i<array_length(global.events);i+=1){
			if(global.events[i] = IOE){
				Event_Delete(i);
			}
		}
		
		return true;
	}
	else{
		return false;
	}
}