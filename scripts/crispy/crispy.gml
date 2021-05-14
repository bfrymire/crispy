/**
 * @description Crispy is an automated unit testing framework built in GML for GameMaker Studio 2.3+
 * https://github.com/bfrymire/crispy
 * Copyright (c) 2020-2021 bfrymire
 */

#macro CRISPY_NAME "Crispy"
#macro CRISPY_VERSION "1.2.0"
#macro CRISPY_DATE "5/14/2021"
#macro CRISPY_RUN true
#macro CRISPY_DEBUG false
#macro CRISPY_VERBOSITY 2 // {0|1|2}
#macro CRISPY_TIME_PRECISION 6
#macro CRISPY_PASS_MSG_SILENT "."
#macro CRISPY_FAIL_MSG_SILENT "F"
#macro CRISPY_PASS_MSG_VERBOSE "ok"
#macro CRISPY_FAIL_MSG_VERBOSE "Fail"
#macro CRISPY_STRUCT_UNPACK_ALLOW_DUNDER false

show_debug_message("Using " + CRISPY_NAME + " automated unit testing framework version " + CRISPY_VERSION);


/**
 * Runner to hold TestSuites and iterates through each TestSuite, running its TestUnits when instructed to.
 * @constructor
 * @param [name]
 * @param [struct] - Struct for crispyStructUnpack
 */
function TestRunner() constructor {

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	// @param log
	static addLog = function(_log) {
		array_push(logs, _log);
	}

	// @param instance
	static captureLogs = function(_inst) {
		switch (instanceof(_inst)) {
			case "CrispyLog":
				addLog(_inst);
				break;
			case "TestCase":
				var _logs_len = array_length(_inst.logs);
				for(var i = 0; i < _logs_len; i++) {
					addLog(_inst.logs[i]);
				}
				break;
			case "TestSuite":
				var _tests_len = array_length(_inst.tests);
				for(var k = 0; k < _tests_len; k++) {
					var _logs_len = array_length(_inst.tests[k].logs);
					for(var i = 0; i < _logs_len; i++) {
						addLog(_inst.tests[k].logs[i]);
					}
				}
				break;
			default:
				var _type = !is_undefined(instanceof(_inst)) ? instanceof(_inst) : typeof(_inst);
				crispyThrowExpected(self, "captureLogs", "{CrispyLog|TestCase|TestSuite}", _type);
				break;
		}
	}

	// @param suite
	static addTestSuite = function(_suite) {
		var _inst = instanceof(_suite);
		if _inst != "TestSuite" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_inst);
			crispyThrowExpected(self, "addTestSuite", "TestSuite", _type);
		}
		_suite.parent = self;
		array_push(suites, _suite);
	}


	// @param [string]
	// @param [count]
	static hr = function() {
		var _str = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "-";
		var _count = (argument_count > 1 && is_real(argument[1])) ? clamp(floor(argument[1]), 0, 120) : 70;
		var _hr = "";
		repeat(_count) {
			_hr += _str;
		}
		return _hr;
	}

  	static run = function() {
		setUp();
		var _len = array_length(suites);
		for(var i = 0; i < _len; i++) {
			suites[i].run();
			captureLogs(suites[i]);
		}
		tearDown();
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
			logs = [];
			start_time = crispyGetTime();
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}

	// @param [name]
	// @param [function]
	static tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				__tearDown__ = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(argument[0]));
			}
		} else {
			// Get total run time
			stop_time = crispyGetTime();
			total_time = crispyGetTimeDiff(start_time, stop_time);
			display_time = crispyTimeConvert(total_time);

			// Display silent test results
			var _passed_tests = 0;
			var _len = array_length(logs);
			var _t = "";
			for(var i = 0; i < _len; i++) {
				if logs[i].pass {
					_t += CRISPY_PASS_MSG_SILENT;
				} else {
					_t += CRISPY_FAIL_MSG_SILENT;
				}
			}
			output(_t);

			// Horizontal row
			output(hr());

			// Show individual log messages
			for(var i = 0; i < _len; i++) {
				if logs[i].pass {
					_passed_tests += 1;
				}
				var _msg = logs[i].getMsg();
				if _msg != "" {
					output(_msg);
				}
			}

			// Finish by showing entire time it took to run the tests
			var _string_tests = _len == 1 ? "test" : "tests";
			output("");
			output(string(_len) + " " + _string_tests + " ran in " + display_time + "s");

			if _passed_tests == _len {
				output(string_upper(CRISPY_PASS_MSG_VERBOSE));
			} else {
				output(string_upper(CRISPY_FAIL_MSG_VERBOSE) + "ED (failures==" + string(_len - _passed_tests) + ")");
			}

			if is_method(__tearDown__) {
				__tearDown__();
			}
			
		}

	}

	// @param message|function
	static output = function() {
		var _input = argument[0];
		if argument_count == 1 {
			switch (typeof(_input)) {
				case "string":
						__output__(_input);
					break;
				case "method":
						__output__ = method(self, _input);
					break;
				default:
					crispyThrowExpected(self, "output", "[string|method]", typeof(_input));
					break;
			}
		} else {
			throw(name + ".output() expected 1 argument, received " + string(argument_count) + " arguments.");
		}
	}

	// @param message
	static __output__ = function(_message) {
		show_debug_message(_message);
	}
	
	__setUp__ = undefined;
	__tearDown__ = undefined;
	name = (argument_count > 0 && !is_string(argument[0])) ? argument[0] : "TestRunner";
	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];

	// Struct unpacker
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}


/**
 * Suite to hold tests and will run each test when instructed to.
 * @constructor
 * @param [name]
 * @param [struct] - Struct for crispyStructUnpack
 */
function TestSuite() constructor {

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	// @param case
	static addTestCase = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_case);
			crispyThrowExpected(self, "addTestCase", "TestCase", _type);
		}
		_case.parent = self;
		array_push(tests, _case);
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
		var _len = array_length(tests);
		for(var i = 0; i < _len; i++) {
			tests[i].run();
		}
		tearDown();
	}

	// @param name
	static setName = function(_name) {
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", typeof(_name));
		}
		name = _name;
	}

	__setUp__ = undefined;
	__tearDown__ = undefined;
	parent = undefined;
	tests = [];
	name = (argument_count > 0 && !is_string(argument[0])) ? argument[0] : "TestSuite";


	// Struct unpacker
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}

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
 * @param start_time
 * @param stop_time
 */
function crispyGetTimeDiff(_start_time, _stop_time) {
	if !is_real(_start_time) {
		crispyThrowExpected(self, "crispyGetTimeDiff", "number", typeof(_start_time));
	}
	if !is_real(_stop_time) {
		crispyThrowExpected(self, "crispyGetTimeDiff", "number", typeof(_stop_time));
	}
	return _stop_time - _start_time;
}

/**
 * Returns the given time in seconds as a string
 * @function
 * @param [number] time - Time in milliseconds.
 */
function crispyTimeConvert(_time) {
	if !is_real(_time) {
		crispyThrowExpected(self, "crispyTimeConvert", "number", typeof(_time));
	}
	return string_format(_time / 1000000, 0, CRISPY_TIME_PRECISION);
}

/**
 * Saves the result and output of assertion.
 * @constructor
 * @param {TestCase} case - TestCase struct that ran the assertion.
 * @param [struct] struct - Structure to replace existing constructor values.
 */
function CrispyLog(_case) constructor {
	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	static getMsg = function() {
		if verbosity == 2 && display_name != "" {
			var _msg = display_name + " ";
		} else {
			var _msg = "";
		}
		switch(verbosity) {
			case 0:
				if pass {
					_msg += CRISPY_PASS_MSG_SILENT;
				} else {
					_msg += CRISPY_FAIL_MSG_SILENT;
				}
				break;
			case 1:
				/*
				if pass {
					_msg += CRISPY_PASS_MSG_VERBOSE;
				} else {
					_msg += CRISPY_FAIL_MSG_VERBOSE;
				}
				*/
				break;
			case 2:
				if pass {
					_msg += "..." + CRISPY_PASS_MSG_VERBOSE;
				} else {
					if !is_undefined(msg) && msg != "" {
						_msg += "- " + msg;
					} else {
						if !is_undefined(helper_text) {
							_msg += "- " + helper_text;
						}
					}
				}
				break;
		}
		return _msg;
	}

	verbosity = CRISPY_VERBOSITY;
	pass = true;
	msg = undefined;
	helper_text = undefined;
	class = _case.class;
	name = _case.name;

	var _display_name = "";
	if !is_undefined(name) {
		_display_name += name;
	}
	if !is_undefined(class) {
		if _display_name != "" {
			_display_name += "." + class;
		} else {
			_display_name += class;
		}
	}
	display_name = _display_name;

	// Struct unpacker
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}

/**
 * Mixin function that extends structs to have the crispyStructUnpack() function.
 * @function
 * @param {struct} struct - Struct to give method variable to.
 */
function crispyMixinStructUnpack(_struct) {
	if !is_struct(_struct) {
		crispyThrowExpected(self, crispyMixinStructUnpack, "struct", typeof(_struct));
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
		crispyThrowExpected(self, "crispyStructUnpack", "struct", typeof(_struct));
	}
	var _names = variable_struct_get_names(_struct);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _name = _names[i];
		if !CRISPY_STRUCT_UNPACK_ALLOW_DUNDER && crispyIsInternalVariable(_name) {
			if CRISPY_DEBUG {
				crispyDebugMessage("Variable names beginning and ending in double underscores are reserved for the framework. Skip unpacking struct name: " + _name);
			}
			continue;
		}
		var _value = variable_struct_get(_struct, _name);
		if _name_must_exist {
			if !variable_struct_exists(self, _name) {
				if CRISPY_DEBUG {
					crispyDebugMessage("Variable name \"" + _name + "\" not found in struct, skip writing variable name.");
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
 * @param {string} message - Text to be displayed in the Output Window.
 */
function crispyDebugMessage(_message) {
	if !is_string(_message) {
		crispyThrowExpected(self, "crispyDebugMessage", "string", typeof(_message));
	}
	show_debug_message(CRISPY_NAME + ": " + _message);
}

/**
 * Helper function for Crispy to throw an error message that displays what type of value the function was expecting.
 * @function
 * @param {struct} self - Struct that is calling the function, usually self.
 * @param {string} name - String of the name of the function that is currently running the error message.
 * @param {string} expected - String of the type of value expected to receive.
 * @param {*} received - Value received.
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
	_name = _name == "" ? "" : "." + _name;
	var _msg = instanceof(_self) + _name + "() expected " + _preposition + " ";
	_msg += _expected + ", received " + _received + ".";
	throw(_msg);
}

/**
 * Helper function for Crispy that returns whether or not a given variable name follows internal variable
 * 		naming convention.
 * @function
 * @param {string} name - Name of variable to check.
 */
function crispyIsInternalVariable(_name) {
	if !is_string(_name) {
		crispyThrowExpected("crispyIsInternalVariable", "", "string", typeof(_name));
	}
	var _len = string_length(_name);
	if _len > 4 && string_copy(_name, 1, 2) == "__" && string_copy(_name, _len - 1, _len) == "__" {
		return true;
	}
	return false;
}
