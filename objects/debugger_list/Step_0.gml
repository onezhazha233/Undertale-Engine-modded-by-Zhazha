if(!global.debug){
	instance_destroy();
	exit;
}

var count=array_length(rows);
if(count<=0){
	instance_destroy();
	exit;
}

var moved=false;
var dir=0;

if(keyboard_check_pressed(vk_up)){
	dir=-1;
	hold_dir=-1;
	hold_time=0;
	repeat_cd=0;
	moved=true;
}else if(keyboard_check_pressed(vk_down)){
	dir=1;
	hold_dir=1;
	hold_time=0;
	repeat_cd=0;
	moved=true;
}

var holding_up=keyboard_check(vk_up);
var holding_down=keyboard_check(vk_down);
if(holding_up||holding_down){
	hold_dir=holding_up?-1:1;
	hold_time+=delta_time/1000000;
	if(hold_time>=hold_delay){
		repeat_cd-=delta_time/1000000;
		if(repeat_cd<=0){
			dir=hold_dir;
			moved=true;
			repeat_cd=max(0.035,0.11-(hold_time-hold_delay)*0.04);
		}
	}
}else{
	hold_dir=0;
	hold_time=0;
	repeat_cd=0;
}

if(moved&&dir!=0){
	var next=selection;
	var guard=0;
	do{
		next+=dir;
		if(next<0){
			next=count-1;
		}else if(next>=count){
			next=0;
		}
		guard+=1;
	}until(rows[next].kind=="item"||guard>count);
	selection=next;
}

if(keyboard_check_pressed(vk_left)||keyboard_check_pressed(vk_right)){
	var cdir=keyboard_check_pressed(vk_left)?-1:1;
	var i=selection;
	var guard=0;
	var seen_header=false;
	do{
		i+=cdir;
		if(i<0){
			i=count-1;
		}else if(i>=count){
			i=0;
		}
		if(rows[i].kind=="header"){
			seen_header=true;
		}else if(seen_header&&rows[i].kind=="item"){
			selection=i;
			break;
		}
		guard+=1;
	}until(guard>count);
}

var max_scroll=max(0,count-visible_rows);
var edge_pad=5;
if(visible_rows<=edge_pad*2+1){
	edge_pad=max(1,floor((visible_rows-1)/2));
}
var view_top=scroll_target+edge_pad;
var view_bottom=scroll_target+visible_rows-1-edge_pad;
if(selection<view_top){
	scroll_target=selection-edge_pad;
}else if(selection>view_bottom){
	scroll_target=selection-(visible_rows-1-edge_pad);
}
scroll_target=clamp(scroll_target,0,max_scroll);

scroll=lerp(scroll,scroll_target,0.4);
if(abs(scroll-scroll_target)<0.03){
	scroll=scroll_target;
}

if(keyboard_check_pressed(vk_enter)||keyboard_check_pressed(ord("Z"))){
	var row=rows[selection];
	if(row.kind=="item"){
		var val=row.value;
		on_select(val);
		instance_destroy();
	}
	exit;
}

if(keyboard_check_pressed(vk_escape)||keyboard_check_pressed(ord("X"))){
	instance_destroy();
}
