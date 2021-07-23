/**
 * Creates a Test case object to run assertions
 * @constructor
 * @param {method} func - Test assertion to run for TestCase
 * @param {string} name - Name of TestCase
 * @param {struct} [unpack] - Struct for crispyStructUnpack
 */
function TestCase() constructor {

	var _func = (argument_count > 0) ? argument[0] : undefined;
	var _name = (argument_count > 1) ? argument[1] : undefined;

	if !is_method(_func) {
		crispyThrowExpected(self, "", "method", typeof(_func));
	}
	if !is_string(_name) {
		crispyThrowExpected(self, "", "string", typeof(_name));
	}

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	/**
	 * Adds a Log to the array of logs
	 * @function
	 * @param log - Log struct
	 */
	static addLog = function() {
		var _log = (argument_count > 0) ? argument[0] : undefined;
		array_push(logs, _log);
	}

	static clearLogs = function() {
		logs = [];
	}

	/**
	 * Test that first and second are equal
	 * The first and second will be checked for the same type first, then check if they're equal
	 * @function
	 * @param {*} first - First value
	 * @param {*} second - Second value to check against _first
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertEqual = function() {
		var _first = (argument_count > 0) ? argument[0] : undefined;
		var _second = (argument_count > 1) ? argument[1] : undefined;
		var _message = (argument_count > 2) ? argument[2] : undefined;
		if typeof(_first) != typeof(_second) {
			addLog(new CrispyLog(self, {pass:false,msg:"Supplied value types are not equal: " + typeof(_first) + " and " + typeof(_second) + "."}));
			return;
		}
		if _first == _second {
			addLog(new CrispyLog(self));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"first and second are not equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test that first and second are not equal
	 * @function
	 * @param {*} first - First type to check
	 * @param {*} second - Second type to check against
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertNotEqual = function() {
		var _first = (argument_count > 0) ? argument[0] : undefined;
		var _second = (argument_count > 1) ? argument[1] : undefined;
		var _message = (argument_count > 2) ? argument[2] : undefined;
		if _first != _second {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"first and second are equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test whether the provided expression is true
	 * The test will first convert the expr to a boolean, then check if it equals true
	 * @function
	 * @param {*} expr - Expression to check
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertTrue = function() {
		var _expr = (argument_count > 0) ? argument[0] : undefined;
		var _message = (argument_count > 1) ? argument[1] : undefined;
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
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not true."}));
		}
	}

	/**
	 * Test whether the provided expression is false
	 * The test will first convert the expr to a boolean, then check if it equals false
	 * @function
	 * @param {*} expr - Expression to check
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertFalse = function() {
		var _expr = (argument_count > 0) ? argument[0] : undefined;
		var _message = (argument_count > 1) ? argument[1] : undefined;
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
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not false."}));
		}
	}

	/**
	 * Test whether the provided expression is noone
	 * @function
	 * @param {*} expr - Expression to check
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertIsNoone = function() {
		var _expr = (argument_count > 0) ? argument[0] : undefined;
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if _expr == -4 {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not noone."}));
		}
	}

	/**
	 * Test whether the provided expression is not noone
	 * @function
	 * @param {*} expr - Expression to check
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertIsNotNoone = function() {
		var _expr = (argument_count > 0) ? argument[0] : undefined;
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if _expr != -4 {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is noone."}));
		}
	}

	/**
	 * Test whether the provided expression is undefined
	 * @function
	 * @param {*} expr - Expression to check
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertIsUndefined = function() {
		var _expr = (argument_count > 0) ? argument[0] : undefined;
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if is_undefined(_expr) {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not undefined."}));
		}
	}

	/**
	 * Test whether the provided expression is not undefined
	 * @function
	 * @param {*} expr - Expression to check
	 * @param {string} [message] - Custom message to output on failure
	 */
	static assertIsNotUndefined = function() {
		var _expr = (argument_count > 0) ? argument[0] : undefined;
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_undefined(_expr) {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is undefined."}));
		}
	}


	/**
	 * Function ran before test, used to set up test
	 * @function
	 * @param {method} [func] - Method to override __setUp__ with
	 */
	static setUp = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				crispyThrowExpected(self, "setUp", "method", typeof(_func));
			}
		} else {
			clearLogs();
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}
	
	/**
	 * Function ran after test, used to clean up test
	 * @function
	 * @param {method} [func] - Method to override __tearDown__ with
	 */
	static tearDown = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(_func));
			}
		} else {
			if is_method(__tearDown__) {
				__tearDown__();
			}
		}
	}

	/**
	 * Set of functions to run in order for the test
	 * @function
	 */
	static run = function() {
		setUp();
		test();
		tearDown();
	}

	/**
	 * Set the name of the TestCase
	 * @param {string} name - Name of the test
	 */
	static setName = function() {
		var _name = (argument_count > 0) ? argument[0] : undefined;
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", typeof(_name));
		}
		name = _name;
	}


	name = _name;
	__setUp__ = undefined;
	__tearDown__ = undefined;
	class = instanceof(self);
	parent = undefined;
	test = method(self, _func);
	logs = [];

	/**
	 * Struct unpacker if a struct was passed as unpack
	 */
	if argument_count > 2 {
		var _unpack = argument[2];
		if !is_struct(_unpack) {
			crispyThrowExpected(self, "", "struct", typeof(_unpack));
		}
		crispyStructUnpack(_unpack);
	}

}
