// Draw the global.score at the top-left corner
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white); // Set color for the text
draw_text(10, 10, "Score: " + string(global.Score));

// Draw the lives as sprPlayer sprites in the bottom-right corner
var lives_x = display_get_gui_width() - 40; // Start from the bottom-right
var lives_y = display_get_gui_height() - 1075; // Adjust vertical position
var player_sprite_width = sprite_get_width(sprPlayer); // Width of the player sprite

for (var i = 0; i < global.lives; i++) {
    draw_sprite(sprPlayer, 0, lives_x - i * (player_sprite_width + 5), lives_y); 
}