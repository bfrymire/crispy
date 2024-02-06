# setUp() and tearDown()

`TestRunner`, `TestSuite`, and `TestCase` all have a `setUp()` and `tearDown()` function that comes with pre-defined instructions. By providing a function, the function will be ran alongside the pre-defined instructions.

### setUp([function])

Provide a function to run during `setUp()`. If anything other than a function is provided, an error message will be thrown.

<br>

### tearDown([function])

Provide a function to run during `tearDown()`. If anything other than a function is provided, an error message will be thrown.

```gml
// Create TestCase
test_example = new TestCase("test_example", function() {
    // The number variable is defined in the setUp() function
    assertEqual(number, 24);
});

// Define setUp() function
test_example.setUp(function() {
    // Here we're defining a variable to use in our test
    number = 24;
});

// Define tearDown() function
test_example.tearDown(function() {
    // We can call our number variable in the tearDown() too
    show_debug_message("Your number is: " + string(number));
});
```

In the example above, we're able to add instructions to this `TestCase.setUp()` and `TestCase.tearDown()` functions. These functions are very powerful. Notice in the example that we're able to define a variable to the `TestCase` in the `setUp()` function and be able to call upon it in the `TestCase` struct and `tearDown` function. Passing variables in this fashion applies the variables directly to the structure. This could possibly lead to you overwriting variables and breaking the objects. Be careful with these functions.

<br>

## Parent Variable

When a TestCase gets added to a TestSuite, or a TestSuite gets added to a TestRunner, it becomes a child of the class it's being added to. That parent class can now be accessed from the child through the `parent` variable. This in conjunction with the `setUp`, `tearDown`, and `onRun*` methods gives access to additional values the parent class is storing.

Suppose for example you have a player character and want to test its receiving and healing damage methods.

```gml
// Create runner and suite
runner = new TestRunner("runner");
suite = new TestSuite("suite");

// The suite will be responsible for creating the player on run,
// setting the player's health to full before each test, and
// destroying the player after the suite is done running
suite.setUp(function() {
    player = instance_create_depth(0, 0, 0, obj_player);
});
suite.onRunBegin(function() {
    player.hp = player.hp_max;
});
suite.tearDown(function() {
    instance_destroy(player);
});

// Create tests that uses the player object created in the suite via
// the parent variable
test_give_damage = new TestCase("test_player_give_damage", function() {
    var _player = parent.player;
    _player.give_damage(1);
    assertEqual(_player.hp, 2);
});
test_heal_damage = new TestCase("test_player_heal_damage", function() {
    var _player = parent.player;
    _player.hp = 0;
    _player.heal(1);
    assertEqual(_player.hp, 1);
});

// Add tests to suite, add suite to runner, run tests
suite.addTestCase(test_give_damage);
suite.addTestCase(test_heal_damage);
runner.addTestSuite(suite);
runner.run();
```

The `player` variable is created once by the test's parent suite on run begin:

```gml
suite.setUp(function() {
    player = instance_create_depth(0, 0, 0, obj_player);
});
```

In the give damage test, we get the player object via it's parent, `parent.player`:

```gml
test_give_damage = new TestCase("test_player_give_damage", function() {
    var _player = parent.player;
    _player.give_damage(1);
    assertEqual(_player.hp, 2);
});
```
