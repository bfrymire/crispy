// Feather disable all

/**
 * Helper function for structs that will replace a destination's
 * 		variable name values with the given source's variable name values
 * @function __crispyStructUnpack
 * @param {Struct} _unpack - Struct used to replace existing values with
 * @param {Bool} [_name_must_exist=true] - Boolean flag that prevents
 * 		new variable names from being added to the destination struct if
 * 		the variable name does not already exist
 * @ignore
 */
function __crispyStructUnpack(_unpack, _name_must_exist=true) {

	if !is_struct(_unpack) {
		throw("crispyStructUnpack() \"_unpack\" expected a struct, received " + typeof(_unpack) + ".");
	}
	if !is_bool(_name_must_exist) {
		throw("crispyStructUnpack() \"_name_must_exist\" expected a boolean, received " + typeof(_name_must_exist) + ".");
	}

	var _names = variable_struct_get_names(_unpack);
	var _len = array_length(_names);
	var i = 0;
	repeat (_len) {
		var _name = _names[i];
		if !CRISPY_STRUCT_UNPACK_ALLOW_DUNDER && crispyIsInternalVariable(_name) {
			if CRISPY_DEBUG {
				crispyDebugMessage("Variable names beginning and ending in double underscores are reserved for the framework. Skip unpacking struct name: " + _name);
			}
			++i;
			continue;
		}
		var _value = variable_struct_get(_unpack, _name);
		if _name_must_exist {
			// Feather disable once GM1041
			if !variable_struct_exists(self, _name) {
				if CRISPY_DEBUG {
					crispyDebugMessage("Variable name \"" + _name + "\" not found in struct, skip writing variable name.");
				}
				++i;
				continue;
			}
		}
		// Feather disable once GM1041
		variable_struct_set(self, _name, _value);
		++i;
	}
}
