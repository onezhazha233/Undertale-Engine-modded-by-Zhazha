function Flag_Inventory(size, type, defaultvalue=-4) constructor{
	self.type = type;
	self.defaultvalue = defaultvalue;
	content = array_create(size,defaultvalue);
	
	function Set(index,value){
		content[index] = value;
	}
	function Get(index,default_value=0){
		if(index < array_length(content)){
			return (content[index] = 0 ? default_value : content[index]);
		}
		return default_value;
	}
	function IsValidValue(value){
		switch(self.type){
			case 0: return Item_IsValid(value)||Phone_IsValid(value);//object
			case 1: return is_string(value)&&value != "";//string
			case 2: return is_real(value)&&value != -4;//number
		}
		return false;
	}
	function Sort(filter=true){
		var content_temp = [];
		if(filter = true){
			for(var i=0;i<array_length(content);i+=1){
				if(IsValidValue(Get(i))){
					array_push(content_temp,Get(i));
				}
			}
		}
		else{
			for(var i=0;i<array_length(content);i+=1){
				array_push(content_temp,Get(i));
			}
		}
		var _valid_count = array_length(content_temp);
		array_resize(content_temp,array_length(content));
		for(var i=_valid_count;i<array_length(content_temp);i+=1){
			content_temp[i] = self.defaultvalue;
		}
		content = content_temp;
	}
	function GetNumber(filter=true){
		var number = 0;
		if(filter = true){
			for(var i=0;i<array_length(content);i+=1){
				if(IsValidValue(Get(i))){
					number += 1;
				}
			}
		}
		else{
			for(var i=0;i<array_length(content);i+=1){
				number += 1;
			}
		}
		return number;
	}
	function Add(value,filter=true){
		if(GetNumber(filter) < array_length(content)){
			Set(array_length(content)-1,value);
			Sort(filter);
			return true;
		}
		return false;
	}
	function Insert(index,value,filter=true){
		if(GetNumber(filter) < array_length(content)){
			array_insert(content,index,value);
			return true;
		}
		return false;
	}
	function Del(index,filter=true){
		if(index < array_length(content)){
			if(filter=true){
				if(IsValidValue(Get(index))){
					Set(index,self.defaultvalue);
					Sort(filter);
				}
			}
			else{
				Set(index,self.defaultvalue);
				Sort(filter);
			}
			return true;
		}
		return false;
	}
	function ToString(){
		var content_temp = array_create(array_length(content),self.defaultvalue);
	    for(var i=0;i<array_length(content);i+=1){
			switch(self.type){
				case 0:
			        if(Item_IsValid(content[i])){
						content_temp[i] = object_get_name(content[i]);
			        }
					break;
				case 1:
					content_temp[i] = content[i];
					break;
				case 2:
					content_temp[i] = content[i];
					break;
			}
	    }
		
		return{content: content_temp, type: self.type};
	}
	function ToId(){
		var content_temp = array_create(array_length(content),self.defaultvalue);
	    for(var i=0;i<array_length(content);i+=1){
			switch(self.type){
				case 0:
			        if(is_string(content[i])){
						content_temp[i] = asset_get_index(content[i]);
			        }
					break;
				case 1:
					content_temp[i] = content[i];
					break;
				case 2:
					content_temp[i] = content[i];
					break;
			}
	    }
		
		return content_temp;
	}
	function Clear(){
		content = array_create(array_length(content));
	}
}