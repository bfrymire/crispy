/**
 * Returns the given time in seconds as a string
 * @function
 * @param [number] time - Time in milliseconds.
 */
function crispyTimeConvert(_time) {
	if !is_real(_time) {
		crispyThrowExpected(self, "crispyTimeConvert", "number", typeof(_time));
	}
	return string_format(_time / 1000000, 0, CRISPY_TIME_PRECISION);
}
