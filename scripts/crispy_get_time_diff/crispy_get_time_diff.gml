/**
 * Returns the difference between two times
 * @function
 * @param {number} start_time - Starting time in milliseconds
 * @param {number} stop_time - Stopping time in milliseconds
 * @returns {number} Difference between start_time and stop_time
 */
function crispy_get_time_diff() {

	var _start_time = (argument_count > 0) ? argument[0] : undefined;
	var _stop_time = (argument_count > 1) ? argument[1] : undefined;

	if !is_real(_start_time) {
		crispy_throw_expected(self, "crispy_get_time_diff", "number", typeof(_start_time));
	}
	if !is_real(_stop_time) {
		crispy_throw_expected(self, "crispy_get_time_diff", "number", typeof(_stop_time));
	}
	return _stop_time - _start_time;
}
