/**
 * Food item
 * @constructor
 * @param {string} _name - Name of food
 * @param {array} _ingredients - Ingredients that make up the food
 */
function Food(_name, _ingredients) constructor {
	if !is_string(_name) {
		throw(instanceof(self) + " \"name\" expected a string, received " + typeof(_name) + ".");
	}
	if !is_array(_ingredients) {
		throw(instanceof(self) + " \"ingredients\" expected an array, received " + typeof(_ingredients) + ".");
	}
	var _len = array_length(_ingredients);
	var i = 0;
	repeat (_len) {
		var _item = _ingredients[i];
		if instanceof(_item) != "Ingredient" {
			var _type = !is_undefined(instanceof(_item)) ? instanceof(_item) : typeof(_item);
			throw(instanceof(self) + " \"ingredients\" expected an instance of Ingredient, received " + _type + ".");
		}
		++i;
	}
	name = _name
	ingredients = _ingredients;
	is_gluten_free = function() {
		var _gf = true;
		var _len = array_length(ingredients);
		var i = 0;
		repeat (_len) {
			if !ingredients[i].is_gluten_free {
				return false;
			}
			++i;
		}
		return true;
	}
	ingredient_number = function() {
		return array_length(ingredients);
	}
	has_ingredient = function(_name) {
		if !is_string(_name) {
			throw(instanceof(self) + ".has_ingredient() \"name\" expected a string, received " + typeof(_name) + ".");
		}
		var _len = array_length(ingredients);
		var i = 0;
		repeat (_len) {
			if ingredients[i].name == _name {
				return true;
			}
			++i;
		}
		return false;
	}
}

/**
 * Food ingredient
 * @constructor
 * @param {string} _name - Name of ingredient
 * @param {boolean} [_is_gluten_free=false]  - Ingredient is gluten free
 */
function Ingredient(_name, _is_gluten_free=false) constructor {
	if !is_string(_name) {
		throw(instanceof(self) + " \"name\" expected a string, received " + typeof(_name));
	}
	if !is_real(_is_gluten_free) && !is_bool(_is_gluten_free) {
		throw(instanceof(self) + " \"is_gluten_free\" expected a boolean, received " + typeof(_is_gluten_free));
	}
	name = _name;
	is_gluten_free = _is_gluten_free;
}
