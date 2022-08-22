/**
 * Returns the difference between two times
 * @function
 * @param {real} _start_time - Starting time in milliseconds
 * @param {real} _stop_time - Stopping time in milliseconds
 * @returns {real} Difference between start_time and stop_time
 */
function crispyGetTimeDiff() {

	var _start_time = (argument_count > 0) ? argument[0] : undefined;
	var _stop_time = (argument_count > 1) ? argument[1] : undefined;

	if !is_real(_start_time) {
		throw("crispyGetTimeDiff() \"start_time\" expected a real number, received " + typeof(_start_time) + ".");
	}
	if !is_real(_stop_time) {
		throw("crispyGetTimeDiff() \"stop_time\" expected a real number, received " + typeof(_stop_time) + ".");
	}
	return _stop_time - _start_time;
}
