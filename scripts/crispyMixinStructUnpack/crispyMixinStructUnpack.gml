/**
 * Mixin function that extends structs to have the crispyStructUnpack() function.
 * @function
 * @param {struct} struct - Struct to give method variable to.
 */
function crispyMixinStructUnpack(_struct) {
	if !is_struct(_struct) {
		crispyThrowExpected(self, crispyMixinStructUnpack, "struct", typeof(_struct));
	}
	_struct.crispyStructUnpack = method(_struct, crispyStructUnpack);
}
