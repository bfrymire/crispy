/**
 * Helper function for structs that will replace a destination's
 * 		variable name values with the given source's variable name values
 * @function crispyStructUnpack
 * @param {struct} unpack - Struct used to replace existing values with
 * @param [boolean=true] name_must_exist - Boolean flag that prevents
 * 		new variable names from being added to the destination struct if
 * 		the variable name does not already exist
 */
function crispyStructUnpack(_unpack, _name_must_exist) {

	// Throw error if passed value isn't a struct
	if !is_struct(_unpack) {
		crispyThrowExpected(self, "crispyStructUnpack", "struct", typeof(_unpack));
	}

	// Optional parameter _name_must_exist defaults to true
	if !is_bool(_name_must_exist) {
		_name_must_exist = true;
	}

	var _names = variable_struct_get_names(_unpack);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _name = _names[i];
		if !CRISPY_STRUCT_UNPACK_ALLOW_DUNDER && crispyIsInternalVariable(_name) {
			if CRISPY_DEBUG {
				crispyDebugMessage("Variable names beginning and ending in double underscores are reserved for the framework. Skip unpacking struct name: " + _name);
			}
			continue;
		}
		var _value = variable_struct_get(_unpack, _name);
		if _name_must_exist {
			if !variable_struct_exists(self, _name) {
				if CRISPY_DEBUG {
					crispyDebugMessage("Variable name \"" + _name + "\" not found in struct, skip writing variable name.");
				}
				continue;
			}
		}
		variable_struct_set(self, _name, _value);
	}
}
