function Anim_Init(){
	//GMU_Anim v4.0.0 (struct-driven)
	//Always a fresh registry on Game Start; structs are garbage-collected so nothing leaks.

	global._gmu_anim_list=[];

	enum ANIM_TWEEN{
		LINEAR,
		SINE,
		QUAD,
		CUBIC,
		QUART,
		QUINT,
		EXPO,
		CIRC,
		BACK,
		ELASTIC,
		BOUNCE
	};

	enum ANIM_EASE{
		IN,
		OUT,
		IN_OUT
	};
}
