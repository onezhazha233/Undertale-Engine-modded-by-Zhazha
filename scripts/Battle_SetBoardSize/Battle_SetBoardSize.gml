///@arg up
///@arg down
///@arg left
///@arg right
///@arg time*
function Battle_SetBoardSize() {
	var U=argument[0];
	var D=argument[1];
	var L=argument[2];
	var R=argument[3];
	var TIME=25;
	if(argument_count>=5){
		TIME=argument[4];
	}

	if(is_real(U)){
		if(TIME==0){
			battle_board.up=U;
		}else{
			Anim_Create(battle_board,"up",0,0,battle_board.up,U-battle_board.up,TIME);
		}
	}
	if(is_real(D)){
		if(TIME==0){
			battle_board.down=D;
		}else{
			Anim_Create(battle_board,"down",0,0,battle_board.down,D-battle_board.down,TIME);
		}
	}
	if(is_real(L)){
		if(TIME==0){
			battle_board.left=L;
		}else{
			Anim_Create(battle_board,"left",0,0,battle_board.left,L-battle_board.left,TIME);
		}
	}
	if(is_real(R)){
		if(TIME==0){
			battle_board.right=R;
		}else{
			Anim_Create(battle_board,"right",0,0,battle_board.right,R-battle_board.right,TIME);
		}
	}

	return true;
}

//旧版ute中的脚本，后来被糖萌芦删除了，但它确实好用
//Script in older version Undertale Engine,it was deleted by TML later but I think it's really useful