/**
 * Base "class" test constructors will inherit from
 * @constructor BaseTestClass
 */
function BaseTestClass() {

	name = undefined;
	static set_up = undefined;
	static __set_up__ = undefined;
	static tear_down = undefined;
	static __tear_down__ = undefined;

	// Give self cripsyStructUnpack() function
	crispy_mixin_struct_unpack(self);

	/**
	 * Set the name of the class
	 * @function set_name
	 * @param {string} name - Name of class
	 */
	static set_name = function(_name) {
		if !is_string(_name) {
			crispy_throw_expected(self, "set_name", "string", typeof(_name));
		}
		name = _name;
	}

}
