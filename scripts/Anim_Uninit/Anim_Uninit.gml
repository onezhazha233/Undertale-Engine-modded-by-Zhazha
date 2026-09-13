function Anim_Uninit(){
	//Structs are garbage-collected; clearing the registry releases every anim.
	//Anim structs still held by user code keep working as plain structs.
	global._gmu_anim_list=[];
	return true;
}
