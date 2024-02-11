# Quick Start

## Installation

1. [Download the **.yymps** file](https://github.com/bfrymire/crispy/releases/latest) of the latest version of Crispy.

![Download YYMPS from GitHub Releases](/assets/images/github-yymps-asset-download.png)

> [!TIP]
> All previous versions of Crispy are also available on the [Releases page](https://github.com/bfrymire/crispy/releases).
>
> However, it's recommended to stay up-to-date with the [latest Release](https://github.com/bfrymire/crispy/releases/latest).

2. Import the **.yymps** file into your project from the top menu:
    * Tools **>** Import Local Package

![GameMaker LTS Import Local Package](/assets/images/gamemaker-lts-import-local-package.png)

> [!TIP]
> The **.yymps** file can also be dropped directly onto your GameMaker IDE to import.
>
> When the message box for _Asset Package Detected_ pops up, click _Yes_.

3. A resource selection box will pop up asking you to select the resources from the asset package to import. You want to import all of Crispy's resources.

Clicking on the _Add All_ button will select all of Crispy's resources to be imported. After all of Crispy's resources are selected, click _Import_.

Here is a video demonstrating the installation steps above by dragging the **.yymps** file onto the GameMaker IDE:

<video style="max-width:100%;width:640px;height:auto;" controls loop>
    <source src="/assets/videos/installing-crispy-yymps.mp4" type="video/mp4">
    Sorry, your browser does not support the video tags.
</video>

Crispy is now imported in your project and ready for use! For further help with GameMaker's package import, [check the manual for Local Asset Packages](https://manual.yoyogames.com/IDE_Tools/Local_Asset_Packages.htm); Specifically the section about **Importing An Asset Package**.

## Updating Your Crispy Version

> [!WARNING]
> Keep in mind that if you made any modifications to the `__crispy_config_macros` script, to save them and migrate them over to the new file after updating.

When updating Crispy if it is already imported into your project, it's best to delete it and start with a fresh import!

1. Select the Crispy asset group and delete it. If a confirmation prompt pops up to delete the assets, select *OK*.
1. Import Crispy from the [Installation steps](https://github.com/bfrymire/crispy/wiki/Quick-Start#installation).
1. Move any previous changes from your `__crispy_config_macros` script to the new script

You should now be running a fresh Crispy installation with your previous config settings.

## Getting Started

The most basic elements that Crispy needs to function are a [TestRunner()](TestRunner), [TestSuite()](TestSuite), and [TestCase()](TestCase).

1. Create new `TestRunner()`
1. Create new `TestSuite()`
1. Add `TestSuite()` to `TestRunner()`
1. Create new `TestCase()`
1. Add `TestCase()` to `TestSuite()`
1. Run `TestRunner()`

Create a new object that will be your test object to hold the Crispy tests.

In the Create Event, add the following code:

```gml
runner = new TestRunner("runner");

suite = new TestSuite("suite");
runner.addTestSuite(suite);

test_sum = new TestCase("test_sum", function() {
    var _sum = 2 + 3;
    assertEqual(_sum, 5);
});
suite.addTestCase(test_sum);

runner.run();
```

This will create and run the tests. You'll see the outcome of the test in the GameMaker Output Window. The test object can be destroyed after you're done with it as long as the tests have been cleaned up successfully during their `tearDown` method if needed. Crispy is safe to be [Garbage Collected](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Garbage_Collection/Garbage_Collection.htm).

## Example in Production

[Animation Flags](https://github.com/bfrymire/gml-animation-flags), a sister library, uses Crispy to build tests. The code for the tests are in a similar structure as above, but leverages the [Discoverable Tests](Discoverable-Tests) feature to find the test case functions that are organized in a separate script.

Here is the [test object](https://github.com/bfrymire/gml-animation-flags/blob/master/objects/obj_test/Create_0.gml) that sets up the runner, suites, and discovers the tests.

And the discoverable tests for [AnimationFlag](https://github.com/bfrymire/gml-animation-flags/blob/master/scripts/scr_animation_flag_tests/scr_animation_flag_tests.gml) and [AnimationManager](https://github.com/bfrymire/gml-animation-flags/blob/master/scripts/scr_animation_manager_tests/scr_animation_manager_tests.gml).
