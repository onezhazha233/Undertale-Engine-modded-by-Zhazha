///@arg state
function Battle_SetState() {
	var STATE=argument[0];

	battle._state=STATE;

	//菜单
	if(STATE==BATTLE_STATE.MENU){
		Battle_SetNextState(BATTLE_STATE.DIALOG);
		
		if(Battle_IsMenuDialogCandidateEnabled()&&Battle_GetMenuDialogCandidateNumber()>0){
			Battle_SetMenuDialog(Battle_GetMenuDialogFromCandidates());
			//tt = "";
			//for(i=0;i<Battle_GetMenuDialogCandidateNumber();i+=1)tt += battle._menu_dialog_candidates[|i]+"\n";
			//show_message(tt);
			if(Battle_IsMenuDialogCandidatesAutoClearEnabled()){
				Battle_ClearMenuDialogCandidates();
			}
		}
	
		Battle_SetMenuChoiceEnemy(0,false);
		Battle_SetMenuChoiceAction(0,false);
		Battle_SetMenu(BATTLE_MENU.BUTTON,false);
	
		Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_START);
	}

	//对话
	if(STATE==BATTLE_STATE.DIALOG){
		Battle_SetNextState(BATTLE_STATE.TURN_PREPARATION);
	
		Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.DIALOG_START);
	}

	//回合准备
	if(STATE==BATTLE_STATE.TURN_PREPARATION){
		Battle_SetNextState(BATTLE_STATE.IN_TURN);
	
		Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_PREPARATION_START);
	
		if(instance_exists(battle_turn)){
			with(battle_turn){
				event_user(BATTLE_TURN_EVENT.TURN_PREPARATION_START);
			}
		}
	
		Battle_SetTurnTime(Battle_GetTurnInfo(BATTLE_TURN.TIME,0));
	
		battle_soul.x=battle_board.x+Battle_GetTurnInfo(BATTLE_TURN.SOUL_X,0);
		battle_soul.y=battle_board.y+Battle_GetTurnInfo(BATTLE_TURN.SOUL_Y,0);
	
		var X_OLD=battle_board.x;
		var Y_OLD=battle_board.y;
		var UP_OLD=battle_board.up;
		var DOWN_OLD=battle_board.down;
		var LEFT_OLD=battle_board.left;
		var RIGHT_OLD=battle_board.right;
		var X_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_X,BATTLE_BOARD.X)-X_OLD;
		var Y_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_Y,BATTLE_BOARD.Y)-Y_OLD;
		var UP_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_UP,BATTLE_BOARD.UP)-UP_OLD;
		var DOWN_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_DOWN,BATTLE_BOARD.DOWN)-DOWN_OLD;
		var LEFT_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_LEFT,BATTLE_BOARD.LEFT)-LEFT_OLD;
		var RIGHT_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RIGHT,BATTLE_BOARD.RIGHT)-RIGHT_OLD;
		var MOVE_TWEEN=Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_TWEEN,ANIM_TWEEN.LINEAR);
		var MOVE_EASE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_EASE,ANIM_EASE.OUT);
		var MOVE_MODE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_MODE,BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		var MOVE_SPEED=Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_SPEED,10);
		var MOVE_DURATION=Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_DURATION,30);
		var SIZE_TWEEN=Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_TWEEN,ANIM_TWEEN.LINEAR);
		var SIZE_EASE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_EASE,ANIM_EASE.OUT);
		var SIZE_MODE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_MODE,BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		var SIZE_SPEED=Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_SPEED,10);
		var SIZE_DURATION=Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_DURATION,30);
	
		if(MOVE_MODE==BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED){
			Anim_Create(battle_board,"x",MOVE_TWEEN,MOVE_EASE,X_OLD,X_CHANGE,round(abs(X_CHANGE/MOVE_SPEED)));
			Anim_Create(battle_board,"y",MOVE_TWEEN,MOVE_EASE,Y_OLD,Y_CHANGE,round(abs(Y_CHANGE/MOVE_SPEED)));
		}else{
			Anim_Create(battle_board,"x",MOVE_TWEEN,MOVE_EASE,X_OLD,X_CHANGE,MOVE_DURATION);
			Anim_Create(battle_board,"y",MOVE_TWEEN,MOVE_EASE,Y_OLD,Y_CHANGE,MOVE_DURATION);
		}
		if(SIZE_MODE==BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED){
			Anim_Create(battle_board,"up",SIZE_TWEEN,SIZE_EASE,UP_OLD,UP_CHANGE,round(abs(UP_CHANGE/SIZE_SPEED)));
			Anim_Create(battle_board,"down",SIZE_TWEEN,SIZE_EASE,DOWN_OLD,DOWN_CHANGE,round(abs(DOWN_CHANGE/SIZE_SPEED)));
			Anim_Create(battle_board,"left",SIZE_TWEEN,SIZE_EASE,LEFT_OLD,LEFT_CHANGE,round(abs(LEFT_CHANGE/SIZE_SPEED)));
			Anim_Create(battle_board,"right",SIZE_TWEEN,SIZE_EASE,RIGHT_OLD,RIGHT_CHANGE,round(abs(RIGHT_CHANGE/SIZE_SPEED)));
		}else{
			Anim_Create(battle_board,"up",SIZE_TWEEN,SIZE_EASE,UP_OLD,UP_CHANGE,SIZE_DURATION);
			Anim_Create(battle_board,"down",SIZE_TWEEN,SIZE_EASE,DOWN_OLD,DOWN_CHANGE,SIZE_DURATION);
			Anim_Create(battle_board,"left",SIZE_TWEEN,SIZE_EASE,LEFT_OLD,LEFT_CHANGE,SIZE_DURATION);
			Anim_Create(battle_board,"right",SIZE_TWEEN,SIZE_EASE,RIGHT_OLD,RIGHT_CHANGE,SIZE_DURATION);
		}
	}

	//回合内
	if(STATE==BATTLE_STATE.IN_TURN){
		Battle_SetNextState(BATTLE_STATE.BOARD_RESETTING);
		Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_START);
	
		if(instance_exists(battle_turn)){
			with(battle_turn){
				event_user(BATTLE_TURN_EVENT.TURN_START);
			}
		}
	}

	//面版重置
	if(STATE==BATTLE_STATE.BOARD_RESETTING){
		Battle_SetNextState(BATTLE_STATE.MENU);
	
		var X_OLD=battle_board.x;
		var Y_OLD=battle_board.y;
		var UP_OLD=battle_board.up;
		var DOWN_OLD=battle_board.down;
		var LEFT_OLD=battle_board.left;
		var RIGHT_OLD=battle_board.right;
		var X_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_X,BATTLE_BOARD.X)-X_OLD;
		var Y_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_Y,BATTLE_BOARD.Y)-Y_OLD;
		var UP_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_UP,BATTLE_BOARD.UP)-UP_OLD;
		var DOWN_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_DOWN,BATTLE_BOARD.DOWN)-DOWN_OLD;
		var LEFT_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_LEFT,BATTLE_BOARD.LEFT)-LEFT_OLD;
		var RIGHT_CHANGE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_RIGHT,BATTLE_BOARD.RIGHT)-RIGHT_OLD;
		var MOVE_TWEEN=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_TWEEN,ANIM_TWEEN.LINEAR);
		var MOVE_EASE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_EASE,ANIM_EASE.OUT);
		var MOVE_MODE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_MODE,BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		var MOVE_SPEED=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_SPEED,10);
		var MOVE_DURATION=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_DURATION,30);
		var SIZE_TWEEN=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_TWEEN,ANIM_TWEEN.LINEAR);
		var SIZE_EASE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_EASE,ANIM_EASE.OUT);
		var SIZE_MODE=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_MODE,BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		var SIZE_SPEED=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_SPEED,10);
		var SIZE_DURATION=Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_DURATION,30);
	
		if(MOVE_MODE==BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED){
			Anim_Create(battle_board,"x",MOVE_TWEEN,MOVE_EASE,X_OLD,X_CHANGE,round(abs(X_CHANGE/MOVE_SPEED)));
			Anim_Create(battle_board,"y",MOVE_TWEEN,MOVE_EASE,Y_OLD,Y_CHANGE,round(abs(Y_CHANGE/MOVE_SPEED)));
		}else{
			Anim_Create(battle_board,"x",MOVE_TWEEN,MOVE_EASE,X_OLD,X_CHANGE,MOVE_DURATION);
			Anim_Create(battle_board,"y",MOVE_TWEEN,MOVE_EASE,Y_OLD,Y_CHANGE,MOVE_DURATION);
		}
		if(SIZE_MODE==BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED){
			Anim_Create(battle_board,"up",SIZE_TWEEN,SIZE_EASE,UP_OLD,UP_CHANGE,round(abs(UP_CHANGE/SIZE_SPEED)));
			Anim_Create(battle_board,"down",SIZE_TWEEN,SIZE_EASE,DOWN_OLD,DOWN_CHANGE,round(abs(DOWN_CHANGE/SIZE_SPEED)));
			Anim_Create(battle_board,"left",SIZE_TWEEN,SIZE_EASE,LEFT_OLD,LEFT_CHANGE,round(abs(LEFT_CHANGE/SIZE_SPEED)));
			Anim_Create(battle_board,"right",SIZE_TWEEN,SIZE_EASE,RIGHT_OLD,RIGHT_CHANGE,round(abs(RIGHT_CHANGE/SIZE_SPEED)));
		}else{
			Anim_Create(battle_board,"up",SIZE_TWEEN,SIZE_EASE,UP_OLD,UP_CHANGE,SIZE_DURATION);
			Anim_Create(battle_board,"down",SIZE_TWEEN,SIZE_EASE,DOWN_OLD,DOWN_CHANGE,SIZE_DURATION);
			Anim_Create(battle_board,"left",SIZE_TWEEN,SIZE_EASE,LEFT_OLD,LEFT_CHANGE,SIZE_DURATION);
			Anim_Create(battle_board,"right",SIZE_TWEEN,SIZE_EASE,RIGHT_OLD,RIGHT_CHANGE,SIZE_DURATION);
		}
	
		Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.BOARD_RESETTING_START);
	}

	return true;


}
