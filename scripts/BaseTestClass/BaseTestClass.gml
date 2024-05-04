// Feather disable all

/**
 * Base class Cripsy test constructors will inherit from
 * @constructor BaseTestClass
 * @param {String} _name - Name of class
 */
function BaseTestClass(_name) constructor {

	name = undefined;
	static setUp = undefined;
	static __setUp__ = undefined;
	static tearDown = undefined;
	static __tearDown__ = undefined;
	static __onRunBegin__ = undefined;
	static __onRunEnd__ = undefined;
	crispyMixinStructUnpack();
	setName(_name);

	// Methods
	
	/**
	 * Set name of class object
	 * @function setName
	 * @param {String} _name - Name of the object
	 * @returns {Struct}
	 */
	static setName = function(_name) {
		if !is_string(_name) {
			throw(instanceof(self) + ".setName() \"_name\" expected a String, received " + typeof(_name) + ".");
		}
		name = _name;
		return self;
	}

	/**
	 * Event to be called at the beginning of run
	 * @function onRunBegin
	 * @param {Function} [_func] - Method to override __onRunBegin__ with
	 * @return {Struct}
	 */
	static onRunBegin = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__onRunBegin__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".onRunBegin() \"_func\" expected a Function, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__onRunBegin__) {
				__onRunBegin__();
			}
		}
		return self;
	}

	/**
	 * Event to be called at the end of run
	 * @function onRunEnd
	 * @param {Function} [_func] - Method to override __onRunEnd__ with
	 * @return {Struct}
	 */
	static onRunEnd = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__onRunEnd__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".onRunEnd() \"_func\" expected a Function, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__onRunEnd__) {
				__onRunEnd__();
			}
		}
		return self;
	}

}
