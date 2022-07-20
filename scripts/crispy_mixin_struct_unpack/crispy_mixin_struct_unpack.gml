/**
 * Mixin function that extends structs to have
 * 		the crispy_struct_unpack() function
 * @function crispy_mixin_struct_unpack
 * @param {struct} class - "Class" struct to give crispy_struct_unpack method to
 * @returns {struct} "Class" struct
 */
function crispy_mixin_struct_unpack(_class) {
	if !is_struct(_class) {
		throw("crispy_mixin_struct_unpack() \"class\" expected a struct, received " + typeof(_class) + ".");
	}
	_class.crispy_struct_unpack = method(_class, crispy_struct_unpack);
	return _class;
}
