text=1
_inst = instance_create_depth(160+Lang_GetLayout("battle.gameover.base_x"),316+Lang_GetLayout("battle.gameover.base_y"),DEPTH_UI.GUI,text_typer)
_inst.text = prefix+Lang_GetString("gameover."+string(irandom(4)))+"{pause}{clear}"+Lang_GetString("gameover.dt")+"{pause}{end}"