/**
 * Food item
 * @constructor
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
	var _len = array_length(_ingredients);
	var i = 0;
	repeat (_len) {
		var _type = instanceof(_ingredients[i]);
		if _type != "Ingredient" {
			throw("Food ingredients expected an Ingredient, got " + typeof(_ingredients));
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
			throw("Food ingredient name expected a string, got " + typeof(_name));
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
