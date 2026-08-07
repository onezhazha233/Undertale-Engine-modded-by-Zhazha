event_inherited();

// 示例事件：演示 Event 系统的对话、选择、角色移动、自定义函数功能

// 创建事件
var e = Event_Create();

Event_AddFunction(e,function(){
	char_player.moveable = false;
})
// ====== 1. 对话 ======
Event_Dialog(e, "嘿，你踩到我了！");

// ====== 2. 多段对话 ======
Event_Dialog(e, [
	"好吧，既然你来了……",
	"我需要你帮我一个忙！",
	"前面有条岔路，你选哪边？"
]);

// ====== 3. 选择 ======
Event_Choice(e, "你要走哪条路？&{choice 0}左&{choice 1}右&{choice_end}", function(choice){
	if(choice == 0){
		StartDialog("好！那我们往左走！");
	}else{
		StartDialog("右边是吧，跟我来！");
	}
});

// ====== 4. 角色移动 ======
Event_CharMove(e, char_player, DIR.RIGHT, 20);

// ====== 5. 自定义函数：创建临时实例并销毁 ======
Event_AddFunction(e,
	function(){
		// init: 创建临时实例
		_inst = instance_create_depth(char_player.x, char_player.y - 30, 0, exclamation);
	},
	function(){
		// update: 实例被销毁时结束
		return instance_exists(_inst);
	}
);

// ====== 6. 结束时重置触发器 ======
Event_AddFunction(e,
	function(){
		_triggered = false;
		char_player.moveable = true;
	}
);

Event_Launch(e)