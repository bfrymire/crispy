/**
 * Helper function for structs that will replace a destination's variable name values with the given source's variable
 * 		name values.
 * @function
 * @param {struct} struct - Struct used to replace existing values with.
 * @param {boolean} [name_must_exist=true] - Boolean flag that prevents new variable names from
 * 		being added to the destination struct if the variable name does not already exist.
 */
function crispyStructUnpack(_struct) {
	var _name_must_exist = (argument_count > 1 && is_bool(argument[1])) ? argument[1] : true;
	if !is_struct(_struct) {
		crispyThrowExpected(self, "crispyStructUnpack", "struct", typeof(_struct));
	}
	var _names = variable_struct_get_names(_struct);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _name = _names[i];
		if !CRISPY_STRUCT_UNPACK_ALLOW_DUNDER && crispyIsInternalVariable(_name) {
			if CRISPY_DEBUG {
				crispyDebugMessage("Variable names beginning and ending in double underscores are reserved for the framework. Skip unpacking struct name: " + _name);
			}
			continue;
		}
		var _value = variable_struct_get(_struct, _name);
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
