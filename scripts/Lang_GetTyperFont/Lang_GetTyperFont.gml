function Lang_GetTyperFont(GROUP, FACE="ascii", DEF=-1) {
	var KEY=Lang_GetTyper(string(GROUP)+"."+string(FACE)+".font","");
	if(!is_string(KEY)||KEY==""){
		return DEF;
	}
	return Lang_GetFont(KEY,DEF);
}
