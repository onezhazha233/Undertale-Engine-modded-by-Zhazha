if(feedback_time>0){
	feedback_time-=delta_time/1000000;
	if(feedback_time<0){
		feedback_time=0;
		feedback="";
	}
}

if(!global.debug){
	armed=false;
	charge=0;
	cur_key="";
	exit;
}

if(instance_exists(debugger_list)){
	armed=false;
	charge=0;
	cur_key="";
	exit;
}

if(keyboard_check(vk_tab)){
	armed=true;
}else{
	armed=false;
	charge=0;
	cur_key="";
	exit;
}

var k="";
if(keyboard_key!=vk_tab&&keyboard_key>0){
	var ch=chr(keyboard_key);
	if(string_length(ch)==1){
		var code=ord(ch);
		// printable ASCII, no space
		if(code>=33&&code<=126){
			k=string_lower(ch);
		}
	}
}
cur_key=k;

if(k==""||!variable_struct_exists(commands,k)){
	charge=0;
	exit;
}

var cmd=commands[$ k];
var hold_need=hold_default;
if(variable_struct_exists(cmd,"hold")){
	hold_need=cmd.hold;
}
if(hold_need<=0){
	hold_need=0.01;
}

charge+=delta_time/1000000;
if(charge>=hold_need){
	cmd.run();
	var tip=cmd.name;
	if(variable_struct_exists(cmd,"tip")&&is_method(cmd.tip)){
		tip=cmd.tip();
	}
	feedback=tip;
	feedback_time=feedback_duration;
	charge=0;
	cur_key="";
	armed=false;
	keyboard_clear(vk_tab);
}
