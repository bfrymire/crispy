// Feather disable all

/**
 * Helper function for Crispy to display its debug messages
 * @function crispyDebugMessage
 * @param {Any} [_message] - Text to be displayed in the Output Window
 */
function crispyDebugMessage() {
	if argument_count == 0 {
		exit;
	}
	var _sep = " ";
	var _text = "";
	var i = 0;
	repeat (argument_count) {
		_text += string(argument[i]);
		if i != argument_count - 1 {
			_text += _sep;
		}
		++i;
	}
	show_debug_message(CRISPY_NAME + ": " + _text);
}
