/**
 * Converts the given time milliseconds to seconds as a string
 * @function
 * @param {real} _time - Time in milliseconds
 * @returns {string} time in seconds with CRISPY_TIME_PRECISION number
 * 		of decimal points as a string
 */
function crispyTimeConvert(_time) {
	if !is_real(_time) {
		throw("crispyTimeConvert() \"time\" expected a real number, received " + typeof(_time) + ".");
	}
	return string_format(_time / 1000000, 0, CRISPY_TIME_PRECISION);
}
