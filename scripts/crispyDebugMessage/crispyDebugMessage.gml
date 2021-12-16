/**
 * Helper function for Crispy to display its debug messages
 * @function crispy_debug_message
 * @param {string} message - Text to be displayed in the Output Window
 */
function crispy_debug_message(_message) {
	if !is_string(_message) {
		crispy_throw_expected(self, "crispy_debug_message", "string", typeof(_message));
	}
	show_debug_message(CRISPY_NAME + ": " + _message);
}
