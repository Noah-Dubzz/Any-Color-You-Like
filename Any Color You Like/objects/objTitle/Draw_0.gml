// Draw Event of objTitle

// Draw the title with the current alpha value
draw_set_alpha(alpha); // Set the alpha for drawing
draw_sprite(sprTitle, 0, x, y); // Draw the title sprite (adjust sprite index as needed)
draw_set_alpha(1); // Reset alpha for other draws

// Set the current color and draw the title sprite
draw_set_color(current_color); // Set the drawing color
draw_sprite(sprTitle, 0, x, y); // Draw the title sprite (adjust sprite index as needed)