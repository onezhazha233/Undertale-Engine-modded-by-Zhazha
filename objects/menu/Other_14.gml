///@desc Name Check
var _data = [
	["aaaaaa", true],
	["alphys", false],
	["alphy", true],
	["asgore", false],
	["toriel", false],
	["asriel", false],
	["flowey", false],
	["sans", false],
	["papyru", true],
	["undyne", false],
	["mtt", true, "metta", "mett"],
	["chara", true],
	["murder", true, "mercy"],
	["catty", true],
	["bratty", true],
	["gerson", true],
	["shyren", true],
	["aaron", true],
	["jerry", true],
	["temmie", true],
	["bpants", true],
	["woshua", true],
	["napsta", true, "blooky"],
	["frisk", true],
];
var _text = Lang_GetString("menu.confirm.title");
var _valid = true;
var _name = string_lower(_naming_name);
for (var i = 0; i < array_length(_data); i++) {
	var _hit = (_name == _data[i][0]);
	for (var j = 2; j < array_length(_data[i]) && !_hit; j++) {
		_hit = (_name == _data[i][j]);
	}
	if (_hit) {
		_text = Lang_GetString("menu.confirm.title." + _data[i][0]);
		_valid = _data[i][1];
		break;
	}
}

_confirm_title = _text;
_confirm_valid = _valid;