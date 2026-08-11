if(!global.debug){
	instance_destroy();
	exit;
}

var count=array_length(rows);

if(count<=0&&!search_enabled){
	instance_destroy();
	exit;
}

Debugger_ListUpdateLayout(id);

if(Debugger_ListStepSearch(id)){
	exit;
}

Debugger_ListStepNav(id);
