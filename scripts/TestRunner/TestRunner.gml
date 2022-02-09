/**
 * Runner to hold test suites and iterates through each TestSuite, running its tests
 * @constructor TestRunner
 * @param {struct} runner_struct - Struct containing instructions to set up TestRunner
 */
function TestRunner(_runner_struct) : BaseTestClass() constructor {

	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];

	// Struct of variable names that are reserved by the library
	reserved_names = {
		reserved: [
			"__set_up__",
			"__tear_down__",
			"__output__",
		],
		overwrite: [
			"set_up",
			"tear_down",
			"output",
		],
	}

	// Apply test_struct to TestCase
	crispy_struct_unpack(_runner_struct, reserved_names);

	// show_message("name: " + string(name));
	show_debug_message(_runner_struct);

	// Checks whether the name was set up correctly
	check_name();


	/**
	 * Adds a Log to the array of logs
	 * @function add_log
	 * @param {Log} log - Log struct to add to logs
	 * @returns {struct} self
	 */
	static add_log = function(_log) {
		array_push(logs, _log);
		return self;
	}

	/**
	 * Adds Logs to the array of logs
	 * @function capture_logs
	 * @param {CrispyLog|TestCase|TestSuite} inst - Adds logs of inst to logs
	 * @returns {struct} self
	 */
	static capture_logs = function() {
		var _inst = (argument_count > 0) ? argument[0] : undefined;
		switch (instanceof(_inst)) {
			case "CrispyLog":
				add_log(_inst);
				break;
			case "TestCase":
				var _logs_len = array_length(_inst.logs);
				for(var i = 0; i < _logs_len; i++) {
					add_log(_inst.logs[i]);
				}
				break;
			case "TestSuite":
				var _tests_len = array_length(_inst.tests);
				for(var k = 0; k < _tests_len; k++) {
					var _logs_len = array_length(_inst.tests[k].logs);
					for(var i = 0; i < _logs_len; i++) {
						add_log(_inst.tests[k].logs[i]);
					}
				}
				break;
			default:
				var _type = !is_undefined(instanceof(_inst)) ? instanceof(_inst) : typeof(_inst);
				crispy_throw_expected(self, "capture_logs", "{CrispyLog|TestCase|TestSuite}", _type);
				break;
		}
		return self;
	}

	/**
	 * Adds TestSuite to array of suites
	 * @function add_test_suite
	 * @param {TestSuite} suite - TestSuite to add
	 * @returns {struct} self
	 */
	static add_test_suite = function(_suite) {
		var _inst = instanceof(_suite);
		if _inst != "TestSuite" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_inst);
			crispy_throw_expected(self, "add_test_suite", "TestSuite", _type);
		}
		_suite.parent = self;
		array_push(suites, _suite);
		return self;
	}

	/**
	 * Creates a horizontal row string
	 * @function hr
	 * @param [string="-"] srt - String to concat n times
	 * @param [real=70] count - Number of times to concat _str.
	 * @returns {string} String of horizontal row
	 */
	static hr = function(_str="-", _count=70) {
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
		set_up();
		run_suites();
		tear_down();
	}

	/**
	 * Runs test suites
	 * @function run_suites
	 */
	static run_suites = function() {
		var _len = array_length(suites);
		for(var i = 0; i < _len; i++) {
			suites[i].run();
			capture_logs(suites[i]);
		}
	}

	/**
	 * Clears logs, starts timer, and runs __set_up__
	 * @function set_up
	 * @param [method] func - Method to override __set_up__ with
	 */
	static set_up = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__set_up__ = method(self, _func);
			} else {
				crispy_throw_expected(self, "set_up", "method", typeof(_func));
			}
		} else {
			logs = [];
			start_time = crispy_get_time();
			if is_method(__set_up__) {
				__set_up__();
			}
		}
	}

	/**
	 * Function ran after test, used to clean up test
	 * @function tear_down
	 * @param [method] func - Method to override __tear_down__ with
	 */
	static tear_down = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tear_down__ = method(self, _func);
			} else {
				crispy_throw_expected(self, "tear_down", "method", typeof(_func));
			}
		} else {
			// Get total run time
			stop_time = crispy_get_time();
			total_time = crispy_get_time_diff(start_time, stop_time);
			display_time = crispy_time_convert(total_time);

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
				var _msg = logs[i].get_msg();
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

			if is_method(__tear_down__) {
				__tear_down__();
			}
			
		}

	}

	/**
	 * Function for discovering individual test functions within
	 * 		scripts, and adds them to a TestSuite
	 * @function discover
	 * @param [test_suite] test_suite - TestSuite to add
	 * 		discovered test script to, else create a temporary TestSuite
	 * @param [string="test_"] script_name_start - String that script
	 * 		functions need to start with in order to be discoverable
	 */
	static discover = function(_test_suite, _script_start_pattern="test_") {
		var _created_test_suite = is_undefined(_test_suite);
		// Throw error if function pattern is not a string
		if !is_string(_script_start_pattern) {
			crispy_throw_expected(self, "_script_start_pattern", "string", typeof(_script_start_pattern));
		}
		// Throw error if function pattern is an empty string
		if _script_start_pattern == "" {
			throw(name + ".discover() argument 'script_start_pattern' cannot be an empty string.");
		}
		// If value is passed for test_suite
		if !is_undefined(_test_suite) {
			if instanceof(_test_suite) != "TestSuite" {
				crispy_throw_expected(self, "test_suite", "[TestSuite|undefined]", typeof(_test_suite));
			}
			// Throw error if test_suite was not previously added to test_runner
			if _test_suite.parent != self {
				throw(name + ".discover() argument '_test_suite' parent is not self. _test_suite may not have been added to " + self.name + " prior to running 'discover()'.");
			}
		} else {
			_test_suite = new TestSuite("__discovered_test_suite__");
		}

		// Loop through known indexes of scripts
		var _len = string_length(_script_start_pattern);
		for(var i = 100000; i < 110000; i++) {
			if script_exists(i) {
				var _script_name = script_get_name(i);
				if string_pos(_script_start_pattern, _script_name) == 1 && string_length(_script_name) > _len {
					var _test_struct = i();
					// Throw error if what is return is not a struct
					// @TODO: make a switch here to change what to do if given a method or struct
					if !is_struct(_test_struct) && !is_method(_test_struct) {
						show_error("Discovered test function \"" + _script_name + "\" did not return a struct, recieved " + typeof(_test_struct) + ".", true);
						continue;
					}
					// Use name of the function if a name variable isn't supplied by the test_struct
					if !variable_struct_exists(_test_struct, "name") {
						_test_struct.name = _script_name;
					}
					var _test_case = new TestCase(_test_struct);
					_test_case.discovered = true; // Mark the TestCase as discovered
					_test_suite.add_test_case(_test_case);
					if CRISPY_DEBUG {
						crispy_debug_message("Discovered test script: " + _test_case.name + " (" + string(i) + ")");
					}
				}
			}
		}
		if _created_test_suite {
			if array_length(_test_suite.tests) == 0 {
				delete _test_suite;
				if CRISPY_DEBUG {
					crispy_debug_message(name + ".discover() local TestSuite deleted.");
				}
			} else {
				add_test_suite(_test_suite);
				if CRISPY_DEBUG {
					crispy_debug_message(name + ".discover() local TestSuite added: " + _test_suite.name);
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
					crispy_throw_expected(self, "input", "{string|method}", typeof(_input));
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

}
