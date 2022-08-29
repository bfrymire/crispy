/**
 * Helper function for Crispy that returns whether or not a given variable name follows internal variable
 * 		naming convention
 * @function
 * @param {string} _name - Name of variable to check
 * @returns {bool} If name follows internal variable naming convention
 */
function crispyIsInternalVariable(_name) {

	if !is_string(_name) {
		throw("crispyIsInternalVariable() \"name\" expected a string, received " + typeof(_name) + ".");
	}
	
	var _len = string_length(_name);
	if _len > 4 && string_copy(_name, 1, 2) == "__" && string_copy(_name, _len - 1, _len) == "__" {
		return true;
	}
	return false;
}
