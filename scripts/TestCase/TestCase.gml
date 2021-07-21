/**
 * Creates a Test case object to run assertions.
 * @constructor
 * @param function
 * @param [name]
 * @param [struct] - Struct for crispyStructUnpack
 */
function TestCase(_function) constructor {
	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	if !is_method(_function) {
		crispyThrowExpected(self, "", "method", typeof(_function));
	}

	// @param log
	static addLog = function(_log) {
		array_push(logs, _log);
	}

	static clearLogs = function() {
		logs = [];
	}

	/**
	 * Test that first and second are equal.
	 * The first and second will be checked for the same type first, then check if they're equal.
	 * @function
	 * @param {*} first - First value.
	 * @param {*} second - Second value to check against.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertEqual = function(_first, _second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if typeof(_first) != typeof(_second) {
			addLog(new CrispyLog(self, {pass:false,msg:"Supplied value types are not equal: " + typeof(_first) + " and " + typeof(_second) + "."}));
			return;
		}
		if _first == _second {
			addLog(new CrispyLog(self));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are not equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test that first and second are not equal.
	 * @function
	 * @param {*} first - First type to check.
	 * @param {*} second - Second type to check against.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertNotEqual = function(_first, _second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if _first != _second {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test whether the provided expression is true.
	 * The test will first convert the expr to a boolean, then check if it equals true.
	 * @function
	 * @param {*} expression - Expression to check.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertTrue = function(_expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(_expr);
		}
		catch(err) {
			addLog(new CrispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == true {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not true."}));
		}
	}

	/**
	 * Test whether the provided expression is false.
	 * The test will first convert the expr to a boolean, then check if it equals false.
	 * @function
	 * @param {*} expression - Expression to check.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertFalse = function(_expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(_expr);
		}
		catch(err) {
			addLog(new CrispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == false {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not false."}));
		}
	}

	/**
	 * Test whether the provided expression is noone.
	 * @function
	 * @param {*} expression - Expression to check.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertIsNoone = function(_expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		if _expr == -4 {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not noone."}));
		}
	}

	/**
	 * Test whether the provided expression is not noone.
	 * @function
	 * @param {*} expression - Expression to check.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertIsNotNoone = function(_expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		if _expr != -4 {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is noone."}));
		}
	}

	/**
	 * Test whether the provided expression is undefined.
	 * @function
	 * @param {*} expression - Expression to check.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertIsUndefined = function(_expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		if is_undefined(_expr) {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not undefined."}));
		}
	}

	/**
	 * Test whether the provided expression is not undefined.
	 * @function
	 * @param {*} expression - Expression to check.
	 * @param {string} [message] - Custom message to output on failure.
	 */
	static assertIsNotUndefined = function(_expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		if !is_undefined(_expr) {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is undefined."}));
		}
	}

	// @param [function]
	static setUp = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				__setUp__ = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "setUp", "method", typeof(argument[0]));
			}
		} else {
			clearLogs();
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}
	
	// @param [function]
	static tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				__tearDown__ = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(argument[0]));
			}
		} else {
			if is_method(__tearDown__) {
				__tearDown__();
			}
		}
	}

	static run = function() {
		setUp();
		test();
		tearDown();
	}

	// @param name
	static setName = function(_name) {
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", typeof(_name));
		}
		name = _name;
	}

	if argument_count > 1 {
		setName(argument[1]);
	} else {
		name = undefined;
	}
	__setUp__ = undefined;
	__tearDown__ = undefined;
	class = instanceof(self);
	parent = undefined;
	test = method(self, _function);
	logs = [];

	// Struct unpacker
	if argument_count > 2 {
		crispyStructUnpack(argument[2]);
	}

}
