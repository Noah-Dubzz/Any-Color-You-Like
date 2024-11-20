// Draw the trail
for (var i = 0; i < array_length(trail); i++) {
    var pos = trail[i];
    var alpha = 1 - (i / trail_length); // Fade effect
    draw_set_alpha(alpha);
    
    // Set rainbow colors based on index
    var color = make_color_hsv(i * (360 / trail_length), 255, 255);
    draw_set_color(color);

    // Draw the sprTrail sprite at the position with a specific size (adjust the size as needed)
    draw_sprite(sprTrail2, 0, pos[0], pos[1]); // Assuming 0 is the frame you want to use
}

// Reset alpha and draw the player
draw_set_alpha(1);
draw_set_color(c_white); // Set color for the player
draw_sprite(sprite_index, image_index, x, y); // Draw the player sprite