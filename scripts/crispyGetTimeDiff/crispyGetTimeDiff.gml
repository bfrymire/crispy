// Feather disable all

/**
 * Returns the difference between two times
 * @function crispyGetTimeDiff
 * @param {Real} _start_time - Starting time in milliseconds
 * @param {Real} _stop_time - Stopping time in milliseconds
 * @returns {Real} Difference between start_time and stop_time
 */
function crispyGetTimeDiff(_start_time, _stop_time) {
	if !is_real(_start_time) {
		throw("crispyGetTimeDiff() \"_start_time\" expected a real number, received " + typeof(_start_time) + ".");
	}
	if !is_real(_stop_time) {
		throw("crispyGetTimeDiff() \"_stop_time\" expected a real number, received " + typeof(_stop_time) + ".");
	}
	return _stop_time - _start_time;
}
