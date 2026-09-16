///@arg space_current
///@arg space_next_face
///@arg char
///@arg next_char
/// Returns trailing face space_x
function Typer_FaceSpaceX() {
	var CUR=argument[0];
	var NXT=argument[1];
	var CH=argument[2];
	var NEXT=argument[3];
	if(CH==" "||CH=="　"||NEXT==""||NEXT==" "||NEXT=="　"){
		return CUR;
	}
	if(NXT>CUR){
		return NXT;
	}
	return CUR;
}
