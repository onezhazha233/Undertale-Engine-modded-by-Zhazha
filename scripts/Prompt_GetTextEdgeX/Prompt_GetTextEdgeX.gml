function Prompt_GetTextEdgeX(typer,pos){
	var _right=Prompt_IsRightPos(pos);
	var _edge=typer.x;
	
	if(_right){
		_edge-=typer._measure_w;
	}
	else{
		_edge+=typer._measure_w;
	}
	
	return _edge;
}
