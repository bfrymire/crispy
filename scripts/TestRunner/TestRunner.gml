/**
 * Runner to hold test suites and iterates through each TestSuite, running its tests
 * @constructor TestRunner
 * @param {string} name - Name of runner
 * @param [struct] unpack - Struct for crispyStructUnpack
 */
function TestRunner(_name) : BaseTestClass() constructor {

	setName(_name);
	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];


	/**
	 * Adds a Log to the array of logs
	 * @function addLog
	 * @param {Log} log - Log struct to add to logs
	 */
	static addLog = function(_log) {
		array_push(logs, _log);
	}

	/**
	 * Adds Logs to the array of logs
	 * @function captureLogs
	 * @param {CrispyLog|TestCase|TestSuite} inst - Adds logs of inst to logs
	 */
	static captureLogs = function() {
		var _inst = (argument_count > 0) ? argument[0] : undefined;
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

	/**
	 * Adds TestSuite to array of suites
	 * @function addTestSuite
	 * @param {TestSuite} suite - TestSuite to add
	 */
	static addTestSuite = function(_suite) {
		var _inst = instanceof(_suite);
		if _inst != "TestSuite" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_inst);
			crispyThrowExpected(self, "addTestSuite", "TestSuite", _type);
		}
		_suite.parent = self;
		array_push(suites, _suite);
	}

	/**
	 * Creates a horizontal row string
	 * @function hr
	 * @param [string="-"] srt - String to concat n times
	 * @param [real=70] count - Number of times to concat _str.
	 * @returns {string} String of horizontal row
	 */
	static hr = function() {
		var _str = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "-";
		var _count = (argument_count > 1 && is_real(argument[1])) ? max(0, round(argument[1])) : 70;
		var _hr = "";
		repeat(_count) {
			_hr += _str;
		}
		return _hr;
	}

	/**
	 * Runs test suites and logs results
	 * @function run
	 */
  	static run = function() {
		setUp();
		var _len = array_length(suites);
		for(var i = 0; i < _len; i++) {
			suites[i].run();
			captureLogs(suites[i]);
		}
		tearDown();
	}

	/**
	 * Clears logs, starts timer, and runs __setUp__
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
			logs = [];
			start_time = crispyGetTime();
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

	/**
	 * Function for discovering individual test functions within
	 * 		scripts, and adds them to a TestSuite
	 * @function discover
	 * @param [test_suite=undefined] test_suite - TestSuite to add
	 * 		discovered test script to, else create a temporary TestSuite
	 * @param [string="test_"] script_name_start - String that script
	 * 		functions need to start with in order to be discoverable
	 */
	static discover = function(_test_suite, _script_start_pattern="test_") {
		var _created_test_suite = is_undefined(_test_suite);
		// Throw error if function pattern is not a string
		if !is_string(_script_start_pattern) {
			crispyThrowExpected(self, "_script_start_pattern", "string", typeof(_script_start_pattern));
		}
		// Throw error if function pattern is an empty string
		if _script_start_pattern == "" {
			throw(name + ".discover() argument 'script_start_pattern' cannot be an empty string.");
		}
		// If value is passed for test_suite
		if !is_undefined(_test_suite) {
			if instanceof(_test_suite) != "TestSuite" {
				crispyThrowExpected(self, "test_suite", "[TestSuite|undefined]", typeof(_test_suite));
			}
			// Throw error if test_suite was not previously added to test_runner
			if _test_suite.parent != self {
				throw(name + ".discover() argument '_test_suite' parent is not self. _test_suite may not have been added to " + self.name + " prior to running 'discover()'.");
			}
		} else {
			_test_suite = new TestSuite("__discovered_test_suite__");
		}
		var _len = string_length(_script_start_pattern);
		for(var i = 100000; i < 110000; i++) {
			if script_exists(i) {
				var _script_name = script_get_name(i);
				if string_pos(_script_start_pattern, _script_name) == 1 && string_length(_script_name) > _len {
					if CRISPY_DEBUG && CRISPY_VERBOSITY {
						crispyDebugMessage("Discovered test script: " + _script_name + " (" + string(i) + ").");
					}
					var _test_case = new TestCase(_script_name, function(){});
					_test_case.__discover__(i);
					_test_suite.addTestCase(_test_case);
				}
			}
		}
		if _created_test_suite {
			if array_length(_test_suite.tests) == 0 {
				delete _test_suite;
				if CRISPY_DEBUG && CRISPY_VERBOSITY == 2 {
					crispyDebugMessage(name + ".discover() local TestSuite deleted.");
				}
			} else {
				addTestSuite(_test_suite);
				if CRISPY_DEBUG && CRISPY_VERBOSITY == 2 {
					crispyDebugMessage(name + ".discover() local TestSuite added: " + _test_suite.name);
				}
			}
		}
	}

	/**
	 * Pass input to __output__ if string. Overwrite __output__ if method
	 * @function output
	 * @param {string|method} input - String to output or function to
	 * 		overwrite __output__
	 */
	static output = function() {
		var _input = (argument_count > 0) ? argument[0] : undefined;
		if argument_count > 0 {
			switch (typeof(_input)) {
				case "string":
						__output__(_input);
					break;
				case "method":
						__output__ = method(self, _input);
					break;
				default:
					crispyThrowExpected(self, "input", "{string|method}", typeof(_input));
					break;
			}
		} else {
			throw(name + ".output() expected 1 argument, received " + string(argument_count) + " arguments.");
		}
	}

	/**
	 * Function that gets called on output
	 * @function __output__
	 * @param {string} message - By default, outputs string to Output Console
	 * @tip This function can be overwritten by a function passed into
	 * 		the output function
	 */
	static __output__ = function(_message) {
		show_debug_message(_message);
	}
	
	/**
	 * Run struct unpacker if unpack argument was provided
	 */
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}
