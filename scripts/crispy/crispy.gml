/**
 * @description Crispy is an automated unit testing framework built in GML for GameMaker Studio 2.3+
 * https://github.com/bfrymire/crispy
 * Copyright (c) 2020-2021 bfrymire
 */

#macro CRISPY_VERSION "1.1.0"
#macro CRISPY_DATE "12/13/2020"
#macro CRISPY_NAME "Crispy"
#macro CRISPY_RUN true
#macro CRISPY_DEBUG false
#macro CRISPY_VERBOSITY 2 // {0|1|2}
#macro CRISPY_TIME_PRECISION 6
#macro CRISPY_PASS_MSG_SILENT "."
#macro CRISPY_FAIL_MSG_SILENT "F"
#macro CRISPY_PASS_MSG_VERBOSE "ok"
#macro CRISPY_FAIL_MSG_VERBOSE "Fail"

show_debug_message("Using " + CRISPY_NAME + " automated unit testing framework version " + CRISPY_VERSION);


/**
 * Creates a runner object to hold TestSuites and run TestCases.
 * @constructor
 */
function TestRunner() constructor {
	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	addLog = function(log) {
		logs[array_length(logs)] = log;
	}

	captureLogs = function(_inst) {
		switch (instanceof(_inst)) {
			case "CrispyLog":
				self.addLog(_inst);
				break;
			case "TestCase":
				var _logs_len = array_length(_inst.logs);
				for(var i = 0; i < _logs_len; i++) {
					self.addLog(_inst.logs[i]);
				}
				break;
			case "TestSuite":
				var _tests_len = array_length(_inst.tests);
				for(var k = 0; k < _tests_len; k++) {
					var _logs_len = array_length(_inst.tests[k].logs);
					for(var i = 0; i < _logs_len; i++) {
						self.addLog(_inst.tests[k].logs[i]);
					}
				}
				break;
			default:
				crispyThrowExpected(self, "captureLogs", "{CrispyLog|TestCase|TestSuite}", logger);
				break;
		}
	}

	addTestSuite = function(_suite) {
		var _inst = instanceof(_suite);
		if _inst != "TestSuite" {
			var _type_received = !is_undefined(_inst) ? _inst : typeof(suite);
			crispyThrowExpected(self, "addTestSuite", "TestSuite", _type_received);
		}
		_suite.parent = self;
		self.suites[array_length(self.suites)] = _suite;
	}

	hr = function() {
		var _str = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "-";
		var _count = (argument_count > 1 && is_real(argument[1])) ? clamp(floor(argument[1]), 0, 120) : 70;
		var _hr = "";
		repeat(_count) {
			_hr += _str;
		}
		return _hr;
	}

  	run = function() {
		self.setUp();
		var _len = array_length(self.suites);
		for(var i = 0; i < _len; i++) {
			self.suites[i].run();
			self.captureLogs(self.suites[i]);
		}
		self.tearDown();
	}

	setUp = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__setUp = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "setUp", "method function", argument[0]);
			}
		} else {
			self.logs = [];
			self.start_time = crispyGetTime();
			if !is_undefined(self.__setUp) {
				self.__setUp();
			}
		}
	}

	tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__tearDown = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method function", argument[0]);
			}
		} else {
			// Get total run time
			self.stop_time = crispyGetTime();
			self.total_time = crispyGetTimeDiff(self.start_time, self.stop_time);
			self.display_time = crispyTimeConvert(self.total_time);

			// Display test results
			var _passed_tests = 0;
			var _len = array_length(self.logs);
			var _t = "";
			for(var i = 0; i < _len; i++) {
				if self.logs[i].pass {
					_t += CRISPY_PASS_MSG_SILENT;
				} else {
					_t += CRISPY_FAIL_MSG_SILENT;
				}
			}
			show_debug_message(_t);

			// Horizontal row
			show_debug_message(hr());

			// Show individual log messages
			for(var i = 0; i < _len; i++) {
				if logs[i].pass {
					_passed_tests += 1;
				}
				var _msg = logs[i].getMsg();
				if _msg != "" {
					show_debug_message(_msg);
				}
			}

			// Finish by showing entire time it took to run the suite
			show_debug_message("\n" + string(_len) + " tests ran in " + self.display_time + "s");

			if _passed_tests == _len {
				show_debug_message(string_upper(CRISPY_PASS_MSG_VERBOSE));
			}

			if !is_undefined(self.__tearDown) {
				self.__tearDown();
			}
			
		}

	}

	__setUp = undefined;
	__tearDown = undefined;
	name = (argument_count > 0 && !is_string(argument[0])) ? argument[0] : "TestRunner";
	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];

	// Struct Unpacker
	if argument_count > 1 {
		self.crispyStructUnpack(argument[1]);
	}

}

/**
 * Creates a suite to hold tests.
 * @constructor
 */
function TestSuite() constructor {
	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	addTestCase = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type_received = !is_undefined(_inst) ? _inst : typeof(_case);
			crispyThrowExpected(self, "addTestCase", "TestCase", _type_received);
		}
		_case.parent = self;
		self.tests[array_length(tests)] = _case;
	}

	setUp = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__setUp = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "setUp", "method function", argument[0]);
			}
		} else {
			if !is_undefined(self.__setUp) {
				self.__setUp();
			}
		}
	}

	tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__tearDown = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method function", argument[0]);
			}
		} else {
			if !is_undefined(self.__tearDown) {
				self.__tearDown();
			}
		}
	}

	run = function() {
		self.setUp();
		var _len = array_length(self.tests);
		for(var i = 0; i < _len; i++) {
			self.tests[i].run();
		}
		self.tearDown();
	}

	setName = function(_name) {
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", _name);
		}
		self.name = _name;
	}

	__setUp = undefined;
	__tearDown = undefined;
	parent = undefined;
	tests = [];
	name = "TestSuite";

	// Struct Unpacker
	if argument_count > 0 {
		self.crispyStructUnpack(argument[0]);
	}

}

/**
 * Creates a Test case object to run assertions.
 * @constructor
 * @param {function} fun - Function that holds the test.
 * @param [string] name - Name of the test.
 */
function TestCase(_fun) constructor {
	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	if !is_method(_fun) {
		crispyThrowExpected(self, "", "method function", _fun);
	}

	addLog = function(_log) {
		self.logs[array_length(self.logs)] = _log;
	}

	clearLogs = function() {
		self.logs = [];
	}

	/**
	 * Test that first and second are equal.
	 * The first and second will be checked for the same type first, then check if they're equal.
	 * @function
	 * @param {*} first - First value.
	 * @param {*} second - Second value to check against.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertEqual = function(_first, _second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if typeof(_first) != typeof(_second) {
			self.addLog(new CrispyLog(self, {pass:false,msg:"Supplied typeof() values are not equal: " + typeof(_first) + " and " + typeof(_second) + "."}));
			return;
		}
		if _first == _second {
			self.addLog(new CrispyLog(self));
		} else {
			self.addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are not equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test that first and second are not equal.
	 * @function
	 * @param {*} first - First type to check.
	 * @param {*} second - Second type to check against.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertNotEqual = function(_first, _second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if _first != _second {
			self.addLog(new CrispyLog(self, {pass:true}));
		} else {
			self.addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Test whether the provided expression is true.
	 * The test will first convert the expr to a boolean, then check if it equals true.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertTrue = function(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(expr);
		}
		catch(err) {
			self.addLog(new CrispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == true {
			self.addLog(new CrispyLog(self, {pass:true}));
		} else {
			self.addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"expr is not true."}));
		}
	}

	/**
	 * Test whether the provided expression is false.
	 * The test will first convert the expr to a boolean, then check if it equals false.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertFalse = function(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(expr);
		}
		catch(err) {
			self.addLog(new CrispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == false {
			self.addLog(new CrispyLog(self, {pass:true}));
		} else {
			self.addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not false."}));
		}
	}

	/**
	 * Test whether the provided expression is noone.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertIsNoone = function(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		if expr == -4 {
			self.addLog(new CrispyLog(self, {pass:true}));
		} else {
			self.addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"expr is not noone."}));
		}
	}

	/**
	 * Test whether the provided expression is not noone.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertIsNotNoone = function(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		if expr != -4 {
			self.addLog(new CrispyLog(self, {pass:true}));
		} else {
			self.addLog(new CrispyLog(self, {pass:false,msg:_msg,helper_text:"expr is noone."}));
		}
	}

	setUp = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__setUp = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "setUp", "method function", argument[0]);
			}
		} else {
			self.clearLogs();
			if !is_undefined(self.__setUp) {
				self.__setUp();
			}
		}
	}
	
	tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__tearDown = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method function", argument[0]);
			}
		} else {
			if !is_undefined(self.__tearDown) {
				self.__tearDown();
			}
		}
	}

	run = function() {
		self.setUp();
		self.test();
		self.tearDown();
	}

	setName = function(name) {
		if !is_string(name) {
			crispyThrowExpected(self, "setName", "string", name);
		}
		self.name = name;
	}

	if argument_count > 1 {
		setName(argument[1]);
	} else {
		self.name = undefined;
	}
	__setUp = undefined;
	__tearDown = undefined;
	class = instanceof(self);
	parent = undefined;
	test = method(self, _fun);
	logs = [];

}

/**
 * Returns the current time in micro-seconds since the project started running
 * @function
 */
function crispyGetTime() {
	return get_timer();
}

/**
 * Returns the difference between two times
 * @function
 */
function crispyGetTimeDiff(start_time, stop_time) {
	if !is_real(start_time) {
		crispyThrowExpected(self, "crispyGetTimeDiff", "number", start_time);
	}
	if !is_real(stop_time) {
		crispyThrowExpected(self, "crispyGetTimeDiff", "number", stop_time);
	}
	return stop_time - start_time;
}

/**
 * Returns the given time in seconds as a string
 * @function
 */
function crispyTimeConvert(time) {
	if !is_real(time) {
		crispyThrowExpected(self, "crispyTimeConvert", "number", time);
	}
	return string_format(time / 1000000, 0, CRISPY_TIME_PRECISION);
}

/**
 * Saves the result and output of assertion.
 * @constructor
 * @param {TestCase} _case - TestCase struct that ran the assertion.
 * @param [struct] Structure to replace existing constructor values.
 */
function CrispyLog(_case) constructor {
	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	getMsg = function() {
		if self.verbosity == 2 && self.display_name != "" {
			var _msg = self.display_name + " ";
		} else {
			var _msg = "";
		}
		switch(self.verbosity) {
			case 0:
				if self.pass {
					_msg += CRISPY_PASS_MSG_SILENT;
				} else {
					_msg += CRISPY_FAIL_MSG_SILENT;
				}
				break;
			case 1:
				/*
				if self.pass {
					_msg += CRISPY_PASS_MSG_VERBOSE;
				} else {
					_msg += CRISPY_FAIL_MSG_VERBOSE;
				}
				*/
				break;
			case 2:
				if self.pass {
					_msg += "..." + CRISPY_PASS_MSG_VERBOSE;
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

	self.verbosity = CRISPY_VERBOSITY;
	self.pass = true;
	self.msg = undefined;
	self.helper_text = undefined;
	self.class = _case.class;
	self.name = _case.name;

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

	// Struct Unpacker
	if argument_count > 1 {
		self.crispyStructUnpack(argument[1]);
	}

}

/**
 * Mixin function that extends structs to have the crispyStructUnpack() function.
 * @function
 * @param {struct} _struct - Struct to give method variable to.
 */
function crispyMixinStructUnpack(_struct) {
	if !is_struct(_struct) {
		crispyThrowExpected(self, crispyMixinStructUnpack, "struct", _struct);
	}
	_struct.crispyStructUnpack = method(_struct, crispyStructUnpack);
}

/**
 * Helper function for structs that will replace a destination's variable name values with the given source's variable
 * 		name values.
 * @function
 * @param {struct} struct - Struct used to replace existing values with.
 * @param {boolean} [name_must_exist=true] - Boolean flag that prevents new variable names from
 * 		being added to the destination struct if the variable name does not already exist.
 */
function crispyStructUnpack(_struct) {
	var _name_must_exist = (argument_count > 1 && is_bool(argument[1])) ? argument[1] : true;
	if !is_struct(_struct) {
		crispyThrowExpected(self, "crispyStructUnpack", "struct", _struct);
	}
	var _names = variable_struct_get_names(_struct);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _name = _names[i];
		if string_pos(_name, "__") == 1 {
			if CRISPY_DEBUG {
				crispyDebugMessage("Variable names beginning in '__' are reserved for the framework.");
			}
			continue;
		}
		var _value = variable_struct_get(_struct, _name);
		if _name_must_exist {
			if !variable_struct_exists(self, _name) {
				if CRISPY_DEBUG {
					crispyDebugMessage("Variable name " + _name + " not found in struct, skipping writing variable name.");
				}
				continue;
			}
		}
		variable_struct_set(self, _name, _value);
	}
}

/**
 * Helper function for Crispy to display its debug messages
 * @function
 * @param {string} msg - Text to be displayed in the Output Window.
 */
function crispyDebugMessage(msg) {
	if !is_string(msg) {
		crispyThrowExpected(self, "crispyDebugMessage", "string", msg);
	}
	show_debug_message(CRISPY_NAME + ": " + msg);
}

/**
 * Helper function for Crispy to throw an error message that displays what type of value the function was expecting.
 * @function
 * @param {struct} _self - Struct that is calling the function, usually self.
 * @param {string} _name - String of the name of the function that is currently running the error message.
 * @param {string} _expected - String of the type of value expected to receive.
 * @param {*} _received - Value received.
 */
function crispyThrowExpected(_self, _name, _expected, _received) {
	var _char = string_ord_at(string_lower(_expected), 1);
	var _vowels = ["a", "e", "i", "o", "u"];
	var _len = array_length(_vowels);
	var _preposition = "a";
	for(var i = 0; i < _len; i++) {
		if _char == _vowels[i] {
			_preposition = "an";
			break;
		}
	}
	_name = _name == "" ? _name : "." + _name;
	var _msg = instanceof(_self) + _name + "() expected " + _preposition + " ";
	_msg += _expected + ", received " + typeof(_received) + ".";
	throw(_msg);
}
