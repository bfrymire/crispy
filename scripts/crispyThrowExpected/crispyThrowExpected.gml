/**
 * Helper function for Crispy to throw an error message that displays what type of value the function was expecting
 * @function
 * @param {struct} self - Struct that is calling the function, usually self
 * @param {string} name - String of the name of the function that is currently running the error message
 * @param {string} expected - String of the type of value expected to receive
 * @param {string} received - String of the type of value received
 */
function crispyThrowExpected() {

	var _self = (argument_count > 0) ? argument[0] : undefined;
	var _name = (argument_count > 1) ? argument[1] : undefined;
	var _expected = (argument_count > 2) ? argument[2] : undefined;
	var _received = (argument_count > 3) ? argument[3] : undefined;

	// Throw error message if wrong type is passed into functions
	if !is_struct(_self) {
		throw("crispyThrowExpected() _self parameter expected a struct, received " + typeof(_self) + ".");
	}
	if !is_string(_name) {
		throw("crispyThrowExpected() _name parameter expected a string, received " + typeof(_name) + ".");
	}
	if !is_string(_expected) {
		throw("crispyThrowExpected() _expected parameter expected a string, received " + typeof(_expected) + ".");
	}
	if !is_string(_received) {
		throw("crispyThrowExpected() _received parameter expected a string, received " + typeof(_received) + ".");
	}

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
