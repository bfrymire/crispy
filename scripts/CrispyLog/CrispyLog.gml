/**
 * Saves the result and output of assertion
 * @constructor CrispyLog
 * @param {TestCase} test_case - TestCase struct
 * @param {struct} unpack - Struct to use with crispyStructUnpack
 */
function CrispyLog(_test_case) constructor {

	if instanceof(_test_case) != "TestCase" {
		var _type = !is_undefined(instanceof(_inst)) ? instanceof(_inst) : typeof(_inst);
		throw(instanceof(self) + " \"test_case\" expected an instance of TestCase, received " + _type + ".");
	}

	verbosity = CRISPY_VERBOSITY;
	pass = true;
	msg = undefined;
	helper_text = undefined;
	class = _test_case.class;
	name = _test_case.name;

	// Create the display name of log based on TestCase name and class
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

	// Give self crispy_struct_unpack() function
	crispy_mixin_struct_unpack(self);

	/**
	 * Run struct unpacker if unpack argument was provided
	 */
	if argument_count > 1 {
		crispy_struct_unpack(argument[1]);
	}

	/**
	 * Constructs text based on outcome of test assertion and verbosity
	 * @function get_msg
	 * @returns {string} Text based on outcome of test assertion and
	 * 		verbosity
	 */
	static get_msg = function() {
		if verbosity == 2 && display_name != "" {
			var _msg = display_name + " ";
		} else {
			var _msg = "";
		}
		switch (verbosity) {
			case 0:
				if pass {
					_msg += CRISPY_PASS_MSG_SILENT;
				} else {
					_msg += CRISPY_FAIL_MSG_SILENT;
				}
				break;
			case 1: // @TODO: Figure out if anything specific should be
					// 		 output when CRISPY_VERBOSITY is 1
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

}
