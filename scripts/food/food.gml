/**
 * Food item
 * @constructor Food
 * @param {string} name - Name of food
 * @param {array} ingredients - Ingredients that make up the food
 */
function Food(_name, _ingredients) constructor {
	if !is_string(_name) {
		throw("Food name expected a string, got " + typeof(_name));
	}
	if !is_array(_ingredients) {
		throw("Food ingredients expected an array, got " + typeof(_ingredients));
	}
	for (var i = 0; i < array_length(_ingredients); i++) {
		var _type = instanceof(_ingredients[i]);
		if _type != "Ingredient" {
			throw("Food ingredients expected an Ingredient, got " + typeof(_ingredients));
		}
	}
	name = _name
	ingredients = _ingredients;
	is_gluten_free = function() {
		var _gf = true;
		for (var i = 0; i < array_length(ingredients); i++) {
			if !ingredients[i].is_gluten_free {
				return false;
			}
		}
		return true;
	}
	ingredient_number = function() {
		return array_length(ingredients);
	}
	has_ingredient = function(_name) {
		if !is_string(_name) {
			throw("Food ingredient name expected a string, got " + typeof(_name));
		}
		for (var i = 0; i < array_length(ingredients); i++) {
			if ingredients[i].name == _name {
				return true;
			}
		}
		return false;
	}
}

/**
 * Food ingredient
 * @constructor Ingredient
 * @param {string} name - Name of ingredient
 * @param [boolean=false] is_gluten_free - Ingredient is gluten free
 */
function Ingredient(_name, _gf=false) constructor {
	if !is_string(_name) {
		throw("Ingredient name expected a string, got " + typeof(_name));
	}
	if !is_real(_gf) && !is_bool(_gf) {
		throw("Ingredient is_gluten_free expected a boolean, got " + typeof(_gf));
	}
	name = _name;
	is_gluten_free = _gf;
}
