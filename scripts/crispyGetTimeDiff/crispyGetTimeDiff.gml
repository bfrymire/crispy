/**
 * Returns the difference between two times
 * @function
 * @param start_time
 * @param stop_time
 */
function crispyGetTimeDiff(_start_time, _stop_time) {
	if !is_real(_start_time) {
		crispyThrowExpected(self, "crispyGetTimeDiff", "number", typeof(_start_time));
	}
	if !is_real(_stop_time) {
		crispyThrowExpected(self, "crispyGetTimeDiff", "number", typeof(_stop_time));
	}
	return _stop_time - _start_time;
}
