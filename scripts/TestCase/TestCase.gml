/**
 * Creates a Test case object to run assertions
 * @constructor TestCase
 * @param {string} name - Name of case
 * @param {method} func - Test assertion to run for TestCase
 * @param [struct] unpack - Struct for crispyStructUnpack
 */
function TestCase(_name, _func) : BaseTestClass() constructor {

	if !is_method(_func) {
		crispyThrowExpected(self, "", "method", typeof(_func));
	}

	setName(_name);
	class = instanceof(self);
	parent = undefined;
	test = undefined;
	logs = [];
	__is_discovered__ = false;
	__discovered_script__ = undefined;
	createTestMethod(_func);

	/**
	 * Turns a function into a method variable for the test.
	 * @function createTestMethod
	 * @param {method} func - Function to turn into a method variable
	 */
	static createTestMethod = function(_func) {
		if !is_method(_func) {
			crispyThrowExpected(self, "createMethodVariable", "method", typeof(_func));
		}
		test = method(self, _func);
	}

	/**
	 * Adds a Log to the array of logs
	 * @function addLog
	 * @param {struct} log - Log struct
	 */
	static addLog = function() {
		var _log = (argument_count > 0) ? argument[0] : undefined;
		array_push(logs, _log);
	}

	/**
	 * Clears array of Logs
	 * @function clearLogs
	 */
	static clearLogs = function() {
		logs = [];
	}

	/**
	 * Test that first and second are equal
	 * The first and second will be checked for the same type first, then check if they're equal
	 * @function assertEqual
	 * @param {*} first - First value
	 * @param {*} second - Second value to check against _first
	 * @param [string] message - Custom message to output on failure
	 */
	static assertEqual = function() {
		// Check supplied arguments
		if argument_count < 2 {
			show_error("assertEqual expects 2 arguments, got " + string(argument_count) + ".", true);
		}
		var _first = argument[0];
		var _second = argument[1];
		var _message = (argument_count > 2) ? argument[2] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		// Check types of first and second
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
	 * @function assertNotEqual
	 * @param {*} first - First type to check
	 * @param {*} second - Second type to check against
	 * @param [string] message - Custom message to output on failure
	 */
	static assertNotEqual = function() {
		// Check supplied arguments
		if argument_count < 2 {
			show_error("assertNotEqual expects 2 arguments, got " + string(argument_count) + ".", true);
		}
		var _first = argument[0];
		var _second = argument[1];
		var _message = (argument_count > 2) ? argument[2] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if _first != _second {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"first and second are equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test whether the provided expression is true
	 * The test will first convert the expression to a boolean, then check if it equals true
	 * @function assertTrue
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assertTrue = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assertTrue expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
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
	 * The test will first convert the expression to a boolean, then check if it equals false
	 * @function assertFalse
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assertFalse = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assertFalse expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
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
	 * @function assertIsNoone
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assertIsNoone = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assertIsNoone expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if _expr == -4 {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not noone."}));
		}
	}

	/**
	 * Test whether the provided expression is not noone
	 * @function assertIsNotNoone
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assertIsNotNoone = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assertIsNotNoone expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if _expr != -4 {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is noone."}));
		}
	}

	/**
	 * Test whether the provided expression is undefined
	 * @function assertIsUndefined
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assertIsUndefined = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assertIsUndefined expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(message) || !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if is_undefined(_expr) {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not undefined."}));
		}
	}

	/**
	 * Test whether the provided expression is not undefined
	 * @function assertIsNotUndefined
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assertIsNotUndefined = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assertIsNotUndefined expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if !is_undefined(_expr) {
			addLog(new CrispyLog(self, {pass:true}));
		} else {
			addLog(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is undefined."}));
		}
	}


	/**
	 * Function ran before test, used to set up test
	 * @function setUp
	 * @param [method] func - Method to override __setUp__ with
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
	 * @function tearDown
	 * @param [method] func - Method to override __tearDown__ with
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
	 * @function run
	 */
	static run = function() {
		setUp();
		test();
		tearDown();
	}

	/**
	 * Sets up a discovered script to use as the test
	 * @function __discover__
	 * @param {real} script - ID of script
	 * @returns {struct} self
	 */
	static __discover__ = function(_script) {
		if !is_real(_script) {
			crispyThrowExpected(self, "__discovered__", "real", typeof(_script));
		}
		__discovered_script__ = _script;
		__is_discovered__ = true;
		createTestMethod(function() {__discovered_script__()});
		return self;
	}

	/**
	 * Run struct unpacker if unpack argument was provided
	 */
	if argument_count > 2 {
		crispyStructUnpack(argument[2]);
	}

}
