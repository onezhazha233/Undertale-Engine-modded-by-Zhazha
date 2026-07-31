function Event_EncounterStart(EVENT,ENCOUNTER_ID,ANIM=true,EXCLAMATION=true){
	Event_AddFunction(EVENT,
	method(
	{
		ENCOUNTER_ID: ENCOUNTER_ID,
		ANIM: ANIM,
		EXCLAMATION: EXCLAMATION
	},
	function(){
		Encounter_Start(ENCOUNTER_ID,ANIM,EXCLAMATION);
	}),
	function(){
		return (instance_exists(encounter_anim)||room == room_battle);
	});
	
	return true;
}