/**
 * Used to draw a box to the screen
 * @constructor GuiBox
 * @param {Real} _x1
 * @param {Real} _y1
 * @param {Real} _x2
 * @param {Real} _y2
 */
function GuiBox(_x1, _y1, _x2, _y2) constructor {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;


    /**
     * Draw rectangle using the coordinates of the box
     * @function draw
     * @param {Real} _color - Color to draw rectangle
     * @param {Bool} _outline - Whether the rectangle is drawn filled or outlined
     */
    static draw = function(_color, _outline) {
        var _c = draw_get_color();
        draw_set_color(_color);
        draw_rectangle(x1, y1, x2, y2, _outline);
        draw_set_color(_c);
    }

    /**
     * Get width of box
     * @function get_width
     * @returns {Real}
     */
    static get_width = function() {
        return abs(x1 - x2);
    }

    /**
     * Get height of box
     * @function get_height
     * @returns {Real}
     */
    static get_height = function() {
        return abs(y1 - y2);
    }

    /**
     * Get x-position of top-left corner of box
     * @function get_x1
     * @returns {Real} x1
     */
    static get_x1 = function() {
        return x1;
    }

    /**
     * Get y-position of top-left corner of box
     * @function get_y1
     * @returns {Real} y1
     */
    static get_y1 = function() {
        return y1;
    }

    /**
     * Get x-position of bottom-right corner of box
     * @function get_x2
     * @returns {Real} x2
     */
    static get_x2 = function() {
        return x2;
    }

    /**
     * Get y-position of bottom-right corner of box
     * @function get_y2
     * @returns {Real} y2
     */
    static get_y2 = function() {
        return y2;
    }

    /**
     * Set x-position of top-left corner of box
     * @function set_x1
     * @param {Real} _x1
     * @returns {Struct} Self
     */
    static set_x1 = function(_x1) {
        if !is_real(_x1) {
            throw(instanceof(self) + ".set_x1() \"x1\" expected a real number, received " + typeof(_x1) + ".");
        }
        x1 = _x1;
        return self;
    }

    /**
     * Set y-position of top-left corner of box
     * @function set_y1
     * @param {Real} _y1
     * @returns {Struct} Self
     */
    static set_y1 = function(_y1) {
        if !is_real(_y1) {
            throw(instanceof(self) + ".set_y1() \"y1\" expected a real number, received " + typeof(_y1) + ".");
        }
        y1 = _y1;
        return self;
    }

    /**
     * Set x-position of bottom-right corner of box
     * @function set_x2
     * @param {Real} _x2
     * @returns {Struct} Self
     */
    static set_x2 = function(_x2) {
        if !is_real(_x2) {
            throw(instanceof(self) + ".set_x2() \"x2\" expected a real number, received " + typeof(_x2) + ".");
        }
        x2 = _x2;
        return self;
    }

    /**
     * Set y-position of bottom-right corner of box
     * @function set_y2
     * @param {Real} _y2
     * @returns {Struct} Self
     */
    static set_y2 = function(_y2) {
        if !is_real(_y2) {
            throw(instanceof(self) + ".set_y2() \"y2\" expected a real number, received " + typeof(_y2) + ".");
        }
        y2 = _y2;
        return self;
    }

}
