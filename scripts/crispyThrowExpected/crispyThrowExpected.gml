/**
 * Helper function for Crispy to throw an error message that displays what type of value the function was expecting.
 * @function
 * @param {struct} self - Struct that is calling the function, usually self.
 * @param {string} name - String of the name of the function that is currently running the error message.
 * @param {string} expected - String of the type of value expected to receive.
 * @param {*} received - Value received.
 */
function crispyThrowExpected(_self, _name, _expected, _received) {
	var _char = string_lower(string_ord_at(_expected, 1));
	var _vowels = ["a", "e", "i", "o", "u"];
	var _len = array_length(_vowels);
	var _preposition = "a";
	for(var i = 0; i < _len; i++) {
		if _char == _vowels[i] {
			_preposition = "an";
			break;
		}
	}
	_name = _name == "" ? "" : "." + _name;
	var _msg = instanceof(_self) + _name + "() expected " + _preposition + " ";
	_msg += _expected + ", received " + _received + ".";
	throw(_msg);
}
