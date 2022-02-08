/**
 * Base "class" test constructors will inherit from
 * @constructor BaseTestClass
 */
function BaseTestClass() {

	name = undefined;
	static setUp = undefined;
	static __setUp__ = undefined;
	static tearDown = undefined;
	static __tearDown__ = undefined;

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	/**
	 * Set the name of the TestCase
	 * @function setName
	 * @param {string} name - Name of the test
	 */
	static setName = function(_name) {
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", typeof(_name));
		}
		name = _name;
	}

}
