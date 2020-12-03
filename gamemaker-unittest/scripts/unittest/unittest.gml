/// @description unittest();

#macro UNITTEST_VERSION "0.0.1"
#macro UNITTEST_DATE "12/3/2020"
#macro UNITTEST_RUN true
#macro UNITTEST_VERBOSITY 2 // {0|1|2}
#macro UNITTEST_AUTO_DESTROY true
#macro UNITTEST_TIME_PRECISION 6
#macro UNITTEST_PASS_MSG_SILENT "."
#macro UNITTEST_FAIL_MSG_SILENT "F"
#macro UNITTEST_PASS_MSG_VERBOSE "ok"
#macro UNITTEST_FAIL_MSG_VERBOSE "Fail"

global.UNITTEST_TIME = 0;
global.UNITTEST_TIME_START = 0;
global.UNITTEST_TIME_STOP = 0;

show_debug_message("Using GameMaker Unittest version " + UNITTEST_VERSION);

/**
 * Save the current in-game's time as a starting position.
 * @function
 */
function unittestTimeStart() {
	global.UNITTEST_TIME_START = get_timer();
}

/**
 * Save the current in-game's time as a stopping position and updates the difference.
 * @function
 */
function unittestTimeStop() {
	global.UNITTEST_TIME_STOP = get_timer();
	unittestTimeUpdate();
}

/**
 * Updates the current unittest time in seconds
 * @function
 */
function unittestTimeUpdate() {
	global.UNITTEST_TIME = (global.UNITTEST_TIME_STOP - global.UNITTEST_TIME_START) / 1000000;
}

/**
 * Returns the current unittest time difference as a string 
 * @function
 */
function unittestGetTime() {
	return string_format(global.UNITTEST_TIME, 0, UNITTEST_TIME_PRECISION);
}

/**
 * Test that first and second are equal.
 * The first and second will be checked for the same type first, then check if they're equal.
 * @function
 * @param {*} first - First value.
 * @param {*} second - Second value to check against.
 * @param {string} [_msg] - Custom message to output on failure.
 */
function assertEqual(first, second) {
	var _msg = (argument_count > 2) ? argument[2] : undefined;
	if typeof(first) != typeof(second) {
		self.parent.addLog(new unittestLog(self, {pass:false,msg:"Supplied typeof() values are not equal: " + typeof(first) + " and " + typeof(second) + "."}));
		return;
	}
	if first == second {
		self.parent.addLog(new unittestLog(self));
	} else {
		self.parent.addLog(new unittestLog(self, {pass:false,msg:_msg,helper_text:"first and second are not equal: " + string(first) + ", " + string(second)}));
	}
}

/**
 * Test that first and second are not equal.
 * @function
 * @param {*} first - First type to check.
 * @param {*} second - Second type to check against.
 * @param {string} [_msg] - Custom message to output on failure.
 */
function assertNotEqual(first, second) {
	var _msg = (argument_count > 2) ? argument[2] : undefined;
	if first != second {
		self.parent.addLog(new unittestLog(self, {pass:true}));
	} else {
		self.parent.addLog(new unittestLog(self, {pass:false,msg:_msg,helper_text:"first and second are equal: " + string(first) + ", " + string(second)}));
	}
}

/**
 * Test whether the provided expression is true.
 * The test will first convert the expr to a boolean, then check if it equals true.
 * @function
 * @param {*} expr - Expression to check.
 * @param {string} [_msg] - Custom message to output on failure.
 */
function assertTrue(expr) {
	var _msg = (argument_count > 1) ? argument[1] : undefined;
	try {
		var _bool = bool(expr);
	}
	catch(err) {
		self.parent.addLog(new unittestLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
		return;
	}
	if _bool == true {
		self.parent.addLog(new unittestLog(self, {pass:true}));
	} else {
		self.parent.addLog(new unittestLog(self, {pass:false,msg:_msg,helper_text:"expr is not true."}));
	}
}

/**
 * Test whether the provided expression is false.
 * The test will first convert the expr to a boolean, then check if it equals false.
 * @function
 * @param {*} expr - Expression to check.
 * @param {string} [_msg] - Custom message to output on failure.
 */
function assertFalse(expr) {
	var _msg = (argument_count > 1) ? argument[1] : undefined;
	try {
		var _bool = bool(expr);
	}
	catch(err) {
		self.parent.addLog(new unittestLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
		return;
	}
	if _bool == false {
		self.parent.addLog(new unittestLog(self, {pass:true}));
	} else {
		self.parent.addLog(new unittestLog(self, {pass:false,msg:_msg,helper_text:"Expression is not false."}));
	}
}

/**
 * Saves the result and output of assertion.
 * @constructor
 * @param {TestCase} _case - Testcase struct that ran the assertion.
 * @param [struct] Structure to replace existing constructor values.
 */
function unittestLog(_case) : unittestExtendStructUnpack() constructor {
	self.verbosity = UNITTEST_VERBOSITY;
	self.pass = true;
	self.msg = undefined;
	self.helper_text = undefined;
	self.class = _case.class;
	self.name = _case.name;

	if argument_count > 1 && !is_undefined(argument[1]) {
		self.unittestStructUnpack(argument[1]);
	}

	var _display_name = "";
	if !is_undefined(self.name) {
		_display_name += self.name;
	}
	if !is_undefined(self.class) {
		if _display_name != "" {
			_display_name += "." + self.class;
		} else {
			_display_name += self.class;
		}
	}
	self.display_name = _display_name;

	getMsg = function() {
		if self.verbosity == 2 && self.display_name != "" {
			var _msg = self.display_name + " ";
		} else {
			var _msg = "";
		}
		switch(self.verbosity) {
			case 0:
				if self.pass {
					_msg += UNITTEST_PASS_MSG_SILENT;
				} else {
					_msg += UNITTEST_FAIL_MSG_SILENT;
				}
				break;
			case 1:
				if self.pass {
					_msg += UNITTEST_PASS_MSG_VERBOSE;
				} else {
					_msg += UNITTEST_FAIL_MSG_VERBOSE;
				}
				break;
			case 2:
				if self.pass {
					_msg += "..." + UNITTEST_PASS_MSG_VERBOSE;
				} else {
					if !is_undefined(self.msg) && self.msg != "" {
						_msg += " - " + self.msg;
					} else {
						if !is_undefined(self.helper_text) {
							_msg += " - " + self.helper_text;
						}
					}
				}
				break;
		}
		return _msg;
	}
}

/**
 * Helper function that extends structs to have unittestStructUnpack() function.
 * @function
 * @param {struct} _struct - Struct to give method veriable.
 */
function unittestExtendStructUnpack() constructor {
	unittestStructUnpack = method(self, unittestStructUnpack);
}

/**
 * Helper function for constructorts that will replace its values with the struct's.
 * @function
 * @param {struct} _struct - Struct to replace existing values with.
 */
function unittestStructUnpack(_struct) {
	if is_undefined(_struct) {
		throw("unittestStructUnpack() supplied argument '_struct' is undefined.\nCheck if argument for _struct is being supplied correctly.");
	}
	if !is_struct(_struct) {
		throw("unittestStructUnpack() expected struct, received " + typeof(_struct));
	}
	var _names = variable_struct_get_names(_struct);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _value = variable_struct_get(_struct, _names[i]);
		if variable_struct_exists(self, _names[i]) {
			variable_struct_set(self, _names[i], _value);
		}
	}
}

/**
 * Suite to hold tests and will run each test when instructed to.
 * @constructor
 */
function TestSuite() constructor {

	tests = [];
	logs = [];

	addLog = function(log) {
		logs[array_length(logs)] = log;
	}

	addTest = function(_case) {
		_case.parent = self;
		self.tests[array_length(tests)] = _case;
	}

	setUp = function() {
		global.unittestTimeStart();
	}

	tearDown = function() {
		global.unittestTimeStop();

		// Display test results
		var _len = array_length(self.logs);
		var _t = "";
		for(var i = 0; i < _len; i++) {
			if self.logs[i].pass {
				_t += UNITTEST_PASS_MSG_SILENT;
			} else {
				_t += UNITTEST_FAIL_MSG_SILENT;
			}
		}
		show_debug_message(_t);

		// Create horizontal row
		var _hr = "";
		repeat(70) {
			_hr += "-";
		}
		show_debug_message(_hr);

		// Show individual log messages
		for(var i = 0; i < _len; i++) {
			show_debug_message(logs[i].getMsg());
		}

		// Finish by showing entire time it took to run the suite 
		show_debug_message("\n" + string(_len) + " tests ran in " + unittestGetTime() + "s");
	}

	run = function() {
		self.setUp();
		var _len = array_length(self.tests);
		for(var i = 0; i < _len; i++) {
			self.tests[i].run();
		}
		self.tearDown();
	}

}

/**
 * Test case to run assertion.
 * @constructor
 * @param {function} fun - Function that holds the test.
 * @param [string] name - Name of the test.
 */
function TestCase(fun) : unittestExtendAssertions() constructor {
	if typeof(fun) != "method" {
		throw("Expected script function, received " + string(typeof(fun)));
	}
	updateName = function(name) {
		self.name = name;
	}
	name = (argument_count > 1 && !is_undefined(argument[1]) && is_string(argument[1])) ? argument[1] : undefined;
	class = instanceof(self);
	parent = undefined;
	test = method(self, fun);
	run = function() {
		test();
	}
}

/**
 * Helper class that extends other constructors to have assertion functions as method variables.
 * @function
 */
function unittestExtendAssertions() constructor {
	assertEqual = method(self, assertEqual);
	assertNotEqual = method(self, assertNotEqual);
	assertTrue = method(self, assertTrue);
	assertFalse = method(self, assertFalse);
}
