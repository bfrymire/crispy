/**
 * This test can be discovered by TestRunner.discover()
 */
function test_discoverable_function() {
	assert_true(__is_discovered__, name + ".__is_discovered__ is not true.");
}
