/**
 * Base "class" test constructors will inherit from
 * @constructor BaseTestClass
 */
function BaseTestClass() constructor {

	name = undefined;
	static set_up = undefined;
	static __set_up__ = undefined;
	static tear_down = undefined;
	static __tear_down__ = undefined;

	// Mixin for BaseClass to give itself crispy_struct_unpack() function
	crispy_mixin_struct_unpack(self);

	/**
	 * Set the name of the class
	 * @function set_name
	 * @param {string} name - Name of class
	 * @returns {struct} Self
	 */
	static set_name = function(_name) {
		if !is_string(_name) {
			crispy_throw_expected(self, "set_name", "string", typeof(_name));
		}
		name = _name;
		return self;
	}

	/**
	 * Checks whether the name of the class was set up correctly
	 * @function check_name
	 * @returns {bool} Whether the name was set up correctly
	 */
	check_name = function() {
		// Only allow strings
		if !is_string(name) {
			throw(instanceof(self) + "() requires a \"name\" variable in \"source_struct\" to be passed, received " + typeof(name));
			return false;
		}
		// Don't allow empty strings
		if name == "" {
			throw(instanceof(self) + "() \"name\" variable requires a string, received empty string.");
			return false;
		}
		return true;
	}

	/**
	 * Checks whether the name of the struct was set up correctly
	 * @function check_name
	 */
	check_name = function() {
		// Only allow strings
		if !is_string(name) {
			throw(instanceof(self) + "() requires a \"name\" variable in \"source_struct\" to be passed, received " + typeof(name));
		}
		// Don't allow empty strings
		if name == "" {
			throw(instanceof(self) + "() \"name\" variable requires a string, received empty string.");
		}
	}

}
