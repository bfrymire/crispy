/**
 * Base class that test constructors will inherit from
 * @constructor BaseTestClass
 * @param {string} name - Name of class
 */
function BaseTestClass() constructor {

	name = undefined;
	static set_up = undefined;
	static __set_up__ = undefined;
	static tear_down = undefined;
	static __tear_down__ = undefined;
	static __on_run_begin__ = undefined;
	static __on_run_end__ = undefined;


	// Mixin for BaseClass to give itself crispy_struct_unpack() function
	crispy_mixin_struct_unpack(self);


	/**
	 * Checks whether the name of the class was set up correctly
	 * @function validate_name
	 * @returns {bool} Whether the name was set up correctly
	 */
	static validate_name = function() {
		// Only allow strings
		if !is_string(name) {
			throw(instanceof(self) + ".validate_name() \"name\" expected a string, received " + typeof(name) + ".");
			return false;
		}
		// Don't allow empty strings
		if name == "" {
			throw(instanceof(self) + ".validate_name() \"name\" cannot be an empty string.");
			return false;
		}
		return true;
	}

	/**
	 * Event to be called at the beginning of run
	 * @function on_run_begin
	 * @param [method] func - Method to override __on_run_begin__ with
	 */
	static on_run_begin = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__on_run_begin__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".on_run_begin() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__on_run_begin__) {
				__on_run_begin__();
			}
		}
	}

	/**
	 * Event to be called at the end of run
	 * @function on_run_end
	 * @param [method] func - Method to override __on_run_end__ with
	 */
	static on_run_end = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__on_run_end__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".on_run_end() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__on_run_end__) {
				__on_run_end__();
			}
		}
	}

	/**
	 * Set the name of the class
	 * @function set_name
	 * @param {string} name - Name of class
	 * @returns {struct} Self
	 */
	static set_name = function(_name) {
		if !is_string(_name) {
			throw(instanceof(self) + ".set_name() \"name\" expected a string, received " + typeof(_name) + ".");
		}
		name = _name;
		validate_name();
		return self;
	}

}
