// Draw Event of objTitleScreen

// Draw the sprite with the current alpha value and scaling
draw_set_alpha(alpha); // Set the alpha for drawing
// Center the sprite by offsetting by half its scaled size
var sprite_w = sprite_get_width(sprite_index) * scale_factorx / 2;
var sprite_h = sprite_get_height(sprite_index) * scale_factory / 2;
draw_sprite_ext(sprite_index, image_index, x - sprite_w, y - sprite_h, scale_factorx, scale_factory, 0, c_white, alpha);
draw_set_alpha(1); // Reset alpha for other draws