// Feather disable all

/**
 * Converts the given time milliseconds to seconds as a string
 * @function crispyTimeConvert
 * @param {Real} _time - Time in milliseconds
 * @returns {String} time in seconds with CRISPY_TIME_PRECISION number
 * 		of decimal points as a string
 */
function crispyTimeConvert(_time) {
	if !is_real(_time) {
		throw("crispyTimeConvert() \"_time\" expected a real number, received " + typeof(_time) + ".");
	}
	return string_format(_time / 1000000, 0, CRISPY_TIME_PRECISION);
}
