// Draw Event of objStartButton

// Draw the button with the current alpha value
draw_set_alpha(alpha); // Set the alpha for drawing
// Center the sprite by offsetting by half its size
var sprite_w = sprite_get_width(sprStartButton) * scale_factor / 2;
draw_sprite_ext(sprStartButton, image_index, x - sprite_w, y, scale_factor, scale_factor, 0, c_white, alpha);
draw_set_alpha(1); // Reset alpha for other draws