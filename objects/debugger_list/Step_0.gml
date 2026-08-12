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
	// 搜索步骤已消费本帧输入，排空键盘缓冲，防止命令键 R/E 的残留字符积累
	keyboard_string="";
	exit;
}

Debugger_ListStepNav(id);

// 每帧排空键盘缓冲，避免 Tab+R/E 的命令键字符（r/e）泄漏进搜索框
keyboard_string="";
