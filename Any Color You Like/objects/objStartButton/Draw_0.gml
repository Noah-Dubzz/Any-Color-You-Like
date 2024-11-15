// Draw Event of objStartButton

// Draw the button with the current alpha value
draw_set_alpha(alpha); // Set the alpha for drawing
draw_sprite_ext(sprStartButton, image_index, x, y, scale_factor, scale_factor, 0, c_white, alpha); // Draw the sprite with scaling
draw_set_alpha(1); // Reset alpha for other draws
