/**
 * Helper function that applys variable values from source struct to
 *		destination struct
 * Any given functions will be converted to method variables
 * @function crispy_struct_unpack
 * @param {struct} source - Source struct to overwrite destination
 * 		scruct variables with
 * @param [struct={}] reserved_names - Struct of variable names that are either ignored or
 * 		will be ignored if passed through source struct
 * @param [boolean=false] ignore_reserved_names - Whether to ignore
 * 		reserved variable names to be overwritten by source struct
 */
function crispy_struct_unpack(_source, _reserved_names={}, _ignore_reserved_names=false) {

	// Check for correct types
	if !is_struct(_source) {
		throw("crispy_struct_unpack() \"source\" expected a struct, received " + typeof(_source) + ".");
	}
	if !is_struct(_reserved_names) {
		throw("crispy_struct_unpack() \"reserved_names\" expected a struct, received " + typeof(_reserved_names) + ".");
	}
	if !is_bool(_ignore_reserved_names) {
		throw("crispy_struct_unpack() \"ignore_reserved_names\" expected a boolean, received " + typeof(_ignore_reserved_names) + ".");
	}

	// Create structs for quick variable name retrieval
	// This is done instead of looping over the array multiple times
	var _struct_reserved = {};
	if variable_struct_exists(_reserved_names, "reserved") {
		var _len = array_length(_reserved_names.reserved);
		for(var i = 0; i < _len; i++) {
			variable_struct_set(_struct_reserved, _reserved_names.reserved[i], true);
		}
	}
	var _struct_method = {};
	if variable_struct_exists(_reserved_names, "overwrite") {
		var _len = array_length(_reserved_names.overwrite);
		for(var i = 0; i < _len; i++) {
			variable_struct_set(_struct_method, _reserved_names.overwrite[i], true);
		}
	}
	var _struct_specific = {};
	if variable_struct_exists(_reserved_names, "specific") {
		var _len = array_length(_reserved_names.specific);
		for(var i = 0; i < _len; i++) {
			variable_struct_set(_struct_specific, _reserved_names.specific[i].name, _reserved_names.specific[i]);
		}
	}
	
	// Apply name first so any error messages can be successfully called out
	if variable_struct_exists(_source, "name") {
		set_name(_source.name);
	}

	// Loop over Source Struct and apply changes
	var _names = variable_struct_get_names(_source);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _name = _names[i];
		// Name was already handled above, skip
		if _name == "name" {
			continue;
		}
		// Checking if variable name is reserved and should be ignored
		if !_ignore_reserved_names {
			if variable_struct_exists(_struct_reserved, _name) && !variable_struct_exists(_struct_method, _name) {
				crispy_debug_message("crispy_struct_unpack() found reserved variable name \"" + _name + "\", skip writing variable.");
				continue;
			}
		}
		// Check if variable name needs to be called within method variable
		if variable_struct_exists(_struct_method, _name) {
			if CRISPY_DEBUG {
				crispy_debug_message(instanceof(self) + ".crispy_struct_unpack() calling name as method: " + _name);
			}
			self[$ _name](_source[$ _name]);
		} else
		// Check if there's a function to run
		if variable_struct_exists(_struct_specific, _name) {
			_struct_specific[$ _name].func(_source[$ _name]);
			if CRISPY_DEBUG {
				crispy_debug_message(instanceof(self) + ".crispy_struct_unpack() running specific function for: " + _name);
			}
		} else {
			if is_method(_source[$ _name]) {
				// If a method is passed, make it a method variable
				if CRISPY_DEBUG {
					crispy_debug_message(instanceof(self) + ".crispy_struct_unpack() creating method variable: " + _name);
				}
				self[$ _name] = method(self, _source[$ _name]);
			} else {
				// Otherwise, just overwrite the value
				if CRISPY_DEBUG {
					crispy_debug_message(instanceof(self) + ".crispy_struct_unpack() overwriting variable \"" + _name + "\" with " + string(_source[$ _name]));
				}
				self[$ _name] = _source[$ _name];
			}
		}
	}
}
