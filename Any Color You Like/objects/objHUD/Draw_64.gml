// Draw the global.score at the top-left corner
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white); // Set color for the text
if (global.mode == "Classic"){
    draw_text(10, 10, "Score: " + string(global.Score));
}
if (global.mode == "TimeAttack" && room != rmTimeAttack){
    draw_text(10, 10, "Levels Completed: " + string(global.levelscompleted));
}

// Draw the lives as sprPlayer sprites in the bottom-right corner
var lives_x = display_get_gui_width() - 40; // Start from the bottom-right
var lives_y = display_get_gui_height() - 1065; // Adjust vertical position
var player_sprite_width = sprite_get_width(sprPlayer); // Width of the player sprite

for (var i = 0; i < global.lives; i++) {
    draw_sprite(sprPlayer, 0, lives_x - i * (player_sprite_width + 5), lives_y); 
}

// Draw the timer (minutes:seconds) at the top-center of the screen
var total_seconds = global.timer;    // Total time in seconds (including fractional part for milliseconds)
var minutes = floor(total_seconds div 60);    // Get minutes (whole number)
var seconds = floor(total_seconds mod 60);    // Get remaining seconds

var time_display = string(minutes) + ":" + string(seconds);

// Get the width of the text to center it
var text_width = string_width(time_display);

// Calculate the X position to center the text
var x_position = (display_get_width() - text_width) / 2;

// Draw the time at the top center of the screen
draw_text(x_position, 10, time_display);

// If the current room is rmTimeAttack, display the congratulatory text
if (room == rmTimeAttack) {
    var congrats_text = "";
    var congrats_color = c_white;
    
    // Change the congratulatory message based on levels completed
    if (global.levelscompleted == 5) {
        congrats_text = "Good run!";
    } else if (global.levelscompleted <= 10) {
        congrats_text = "That was crazy!";
    } else if (global.levelscompleted <= 15) {
        congrats_text = "Jesus man, Chill!";
    } else {
        congrats_text = "Where did your life go?????";
    }
    
    // Display the congratulatory text at the top-center of the screen
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(congrats_color);  // Set color for the congratulatory text
    draw_text(display_get_width() / 2, 50, congrats_text);
    
    // Display the levels completed at the center of the screen in large, bold text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(font_bold_large);  // Make sure to use a bold large font here
    draw_set_color(c_white);  // Set color for the text
    draw_text(display_get_width() / 2, display_get_height() / 2, "Levels Completed: " + string(global.levelscompleted));
}