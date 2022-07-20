/**
 * Returns the difference between two times
 * @function crispy_get_time_diff
 * @param {number} start_time - Starting time in milliseconds
 * @param {number} stop_time - Stopping time in milliseconds
 * @returns {number} Difference between start_time and stop_time
 */
function crispy_get_time_diff(_start_time, _stop_time) {
	if !is_real(_start_time) {
		throw("crispy_get_time_diff() \"start_time\" expected a real number, received " + typeof(_start_time) + ".");
	}
	if !is_real(_stop_time) {
		throw("crispy_get_time_diff() \"stop_time\" expected a real number, received " + typeof(_stop_time) + ".");
	}
	return _stop_time - _start_time;
}
