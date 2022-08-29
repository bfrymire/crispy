/**
 * Saves the result and output of assertion
 * @constructor CrispyLog
 * @param {struct} _test_case - Struct that holds the test case
 * @param [struct] _unpack - Struct to use with crispyStructUnpack
 */
function CrispyLog(_test_case, _unpack) constructor {

	if !is_struct(_test_case) {
		throw(instanceof(self) + " \"test_case\" expected a struct, received " + _type + ".");
	}

	crispyMixinStructUnpack();

	verbosity = CRISPY_VERBOSITY;
	pass = true;
	msg = undefined;
	helper_text = undefined;
	class = _test_case.class;
	name = _test_case.name;
	display_name = undefined;

	// Methods

	/**
	 * Constructs text based on outcome of test assertion and verbosity
	 * @function getMsg
	 * @returns {string} Text based on outcome of test assertion and
	 * 		verbosity
	 */
	static getMsg = function() {
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
			case 1: // TODO: Figure out if anything specific should be
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

	// Update variables

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

	/**
	 * Run struct unpacker if unpack argument was provided
	 * Stays after all variables are initialized so they may be overwritten
	 */
	if !is_undefined(_unpack) {
		if is_struct(_unpack) {
			crispyStructUnpack(_unpack);
		} else {
			throw(instanceof(self) + " \"unpack\" expected a struct or undefined, recieved " + typeof(_unpack) + ".");
		}
	}

}
