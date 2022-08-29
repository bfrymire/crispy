/**
 * Base "class" that test constructors will inherit from
 * @constructor BaseTestClass
 * @param {string} _name - Name of class
 */
function BaseTestClass(_name) {

	name = undefined;
	static setUp = undefined;
	static __setUp__ = undefined;
	static tearDown = undefined;
	static __tearDown__ = undefined;
	static __onRunBegin__ = undefined;
	static __onRunEnd__ = undefined;

	crispyMixinStructUnpack();


	// Methods
	
	/**
	 * Set name of class object
	 * @function setName
	 * @param {string} _name - Name of the object
	 */
	static setName = function(_name) {
		if !is_string(_name) {
			throw(instanceof(self) + ".setName() \"name\" expected a string, received " + typeof(_name) + ".");
		}
		name = _name;
	}

	/**
	 * Event to be called at the beginning of run
	 * @function onRunBegin
	 * @param [function] _func - Method to override __onRunBegin__ with
	 */
	static onRunBegin = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__onRunBegin__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".onRunBegin() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__onRunBegin__) {
				__onRunBegin__();
			}
		}
	}

	/**
	 * Event to be called at the end of run
	 * @function onRunEnd
	 * @param [function] _func - Method to override __onRunEnd__ with
	 */
	static onRunEnd = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__onRunEnd__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".onRunEnd() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__onRunEnd__) {
				__onRunEnd__();
			}
		}
	}

	// Update variables

	setName(_name);

}
