/**
 * Mixin function that extends structs to have the crispyStructUnpack() function
 * @function
 * @param {struct} struct - Struct to give crispyStructUnpack method to
 */
function crispyMixinStructUnpack() {

	var _struct = (argument_count > 0) ? argument[0] : undefined;

	if !is_struct(_struct) {
		crispyThrowExpected(self, crispyMixinStructUnpack, "struct", typeof(_struct));
	}

	_struct.crispyStructUnpack = method(_struct, crispyStructUnpack);

}
