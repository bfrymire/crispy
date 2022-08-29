function gui_box(_x1, _y1, _x2, _y2) constructor {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;


    /**
     * Draw rectangle using the coordinates of the box
     * @function
     * @param {real} _color - Color to draw rectangle
     * @param {bool} _outline - Whether the rectangle is drawn filled or outlined
     */
    draw = function(_color, _outline) {
        var _c = draw_get_color();
        draw_set_color(_color);
        draw_rectangle(x1, y1, x2, y2, _outline);
        draw_set_color(_c);
    }

    /**
     * Get width of box
     * @function
     * @returns {real}
     */
    get_width = function() {
        return abs(x1 - x2);
    }

    /**
     * Get height of box
     * @function
     * @returns {real}
     */
    get_height = function() {
        return abs(y1 - y2);
    }

    /**
     * Get x-position of top-left corner of box
     * @function
     * @return {real} x1
     */
    get_x1 = function() {
        return x1;
    }

    /**
     * Get y-position of top-left corner of box
     * @function
     * @return {real} y1
     */
    get_y1 = function() {
        return y1;
    }

    /**
     * Get x-position of bottom-right corner of box
     * @function
     * @returns {real} x2
     */
    get_x2 = function() {
        return x2;
    }

    /**
     * Get y-position of bottom-right corner of box
     * @function
     * @returns {real} y2
     */
    get_y2 = function() {
        return y2;
    }

    /**
     * Set x-position of top-left corner of box
     * @function
     * @param {real} _x1
     * @returns {struct} Self
     */
    set_x1 = function(_x1) {
        if !is_real(_x1) {
		    throw(instanceof(self) + ".set_x1() \"x1\" expected a real number, received " + typeof(_x1) + ".");
        }
        x1 = _x1;
        return self;
    }

    /**
     * Set y-position of top-left corner of box
     * @function
     * @param {real} _y1
     * @returns {struct} Self
     */
    set_y1 = function(_y1) {
        if !is_real(_y1) {
		    throw(instanceof(self) + ".set_y1() \"y1\" expected a real number, received " + typeof(_y1) + ".");
        }
        y1 = _y1;
        return self;
    }

    /**
     * Set x-position of bottom-right corner of box
     * @function
     * @param {real} _x2
     * @returns {struct} Self
     */
    set_x2 = function(_x2) {
        if !is_real(_x2) {
		    throw(instanceof(self) + ".set_x2() \"x2\" expected a real number, received " + typeof(_x2) + ".");
        }
        x2 = _x2;
        return self;
    }

    /**
     * Set y-position of bottom-right corner of box
     * @function
     * @param {real} _y2
     * @returns {struct} Self
     */
    set_y2 = function(_y2) {
        if !is_real(_y2) {
		    throw(instanceof(self) + ".set_y2() \"y2\" expected a real number, received " + typeof(_y2) + ".");
        }
        y2 = _y2;
        return self;
    }

}
