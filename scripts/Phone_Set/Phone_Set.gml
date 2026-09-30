///@arg phone_slot
///@arg phone_id
function Phone_Set(SLOT, PHONE){
	if(Phone_IsSlotValid(SLOT) && (Phone_IsValid(PHONE) || PHONE==-1)){
		Flag_Get(FLAG_STATIC,"phone").Set(SLOT, PHONE);
		Phone_Update();
		return true;
	}else{
		return false;
	}
}