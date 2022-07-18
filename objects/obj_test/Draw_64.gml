var padding = 10;

// Draw results GUI box background
results_box.draw(colors.background, false);
// Draw test results
var _h_total = 0;
var _len = ds_list_size(results);
if _len {
	draw_set_color(colors.foreground);
	var i = 0;
	repeat (_len) {
		var _text = results[| i];
		var _h = (i + 1) * text_height;
		draw_text(results_box.x1 + padding, results_box.y2 - padding - scroll_position - _h, _text);
		++i;
	}
}
// Draw results GUI box outline
results_box.draw(colors.foreground, true);

// Draw Crispy version and instructions
info_box.draw(colors.background, false);
info_box.draw(colors.foreground, true);
draw_set_color(colors.purple);
draw_text(padding, padding, info_text);
draw_set_color(c_black);
