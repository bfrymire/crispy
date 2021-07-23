/**
 * Helper function for Crispy to display its debug messages
 * @function
 * @param {string} message - Text to be displayed in the Output Window
 */
function crispyDebugMessage() {

	var _message = (argument_count > 0) ? argument[0] : undefined;

	if !is_string(_message) {
		crispyThrowExpected(self, "crispyDebugMessage", "string", typeof(_message));
	}
	show_debug_message(CRISPY_NAME + ": " + _message);
}
