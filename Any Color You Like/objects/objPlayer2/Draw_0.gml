// Optimized Player 2 trail rendering
var p2_trail_draw_limit = min(array_length(trail), 15); // Limit trail length for performance
var p2_trail_skip = max(1, floor(array_length(trail) / p2_trail_draw_limit));

for (var i = 0; i < p2_trail_draw_limit; i++) {
    var trail_index = i * p2_trail_skip;
    if (trail_index >= array_length(trail)) break;
    
    var pos = trail[trail_index];
    var alpha = 1 - (i / p2_trail_draw_limit); // Fade effect
    
    // Skip very transparent trail segments
    if (alpha < 0.1) continue;
    
    // Clamp Player 2 trail drawing position to maze bounds (ensures no out-of-bounds trail rendering)
    var p2_draw_x = clamp(pos[0], global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
    var p2_draw_y = clamp(pos[1], global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
    
    draw_set_alpha(alpha);
    
    // Optimized color calculation for Player 2
    var hue = (i * (360 / p2_trail_draw_limit)) % 360;
    var color = make_color_hsv(hue, 255, 255);
    draw_set_color(color);

    // Draw Player 2 trail segment at clamped position
    draw_sprite(sprTrail2, 0, p2_draw_x, p2_draw_y);
}

// Reset alpha and draw the player
draw_set_alpha(1);
draw_set_color(c_white); // Set color for the player
draw_sprite(sprite_index, image_index, x, y); // Draw the player sprite