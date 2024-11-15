// Draw Event of objTitleScreen

// Draw the sprite with the current alpha value and scaling
draw_set_alpha(alpha); // Set the alpha for drawing
draw_sprite_ext(sprite_index, image_index, x, y, scale_factorx, scale_factory, 0, c_white, alpha); // Draw the sprite with scaling
draw_set_alpha(1); // Reset alpha for other draws
