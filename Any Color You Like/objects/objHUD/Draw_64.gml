// Draw the global.score at the top-left corner
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white); // Set color for the text
draw_set_font(font_bold_large); // Consistent font usage
if (global.mode == "Classic" || global.mode == "Endless" || global.mode == "MultiPrism"){
    draw_text(10, 10, "Score: " + string(global.Score));
}
if (global.mode == "TimeAttack" && room != rmTimeAttack){
	draw_set_font(font_bold_large);  // Make sure to use a bold large font here
    draw_text(10, 10, "Levels Completed: " + string(global.levelscompleted));
}

// Optimized HUD drawing - cache expensive calculations
if (!variable_instance_exists(id, "hud_cache_frame") || hud_cache_frame != get_timer()) {
    hud_cache_frame = get_timer();
    cached_gui_width = display_get_gui_width();
    cached_gui_height = display_get_gui_height();
    cached_player_width = sprite_get_width(sprPlayer);
    cached_player2_width = sprite_get_width(sprPlayer2);
}

// Draw Player 1's lives using cached values
var lives_x = cached_gui_width - 40;
var lives_y = cached_gui_height - 80;

for (var i = 0; i < global.lives; i++) {
    draw_sprite(sprPlayer, 0, lives_x - i * (cached_player_width + 5), lives_y); 
}

if (global.mode == "MultiPrism"){
    // Draw Player 2's lives using cached values
    var p2lives_x = cached_gui_width - 40;
    var p2lives_y = lives_y + sprite_get_height(sprPlayer) + 10;
    
    for (var i = 0; i < global.p2lives; i++) {
        draw_sprite(sprPlayer2, 0, p2lives_x - i * (cached_player2_width + 5), p2lives_y); 
    }
}

// Draw the timer (minutes:seconds) at the top-center of the screen
var total_seconds = global.timer;    // Total time in seconds (including fractional part for milliseconds)
var minutes = floor(total_seconds div 60);    // Get minutes (whole number)
var seconds = floor(total_seconds mod 60);    // Get remaining seconds

var time_display = string(minutes) + ":" + string(seconds);

// Get the width of the text to center it
var text_width = string_width(time_display);

// Use cached GUI width for better performance
var x_position = (cached_gui_width - text_width) / 2;

// Draw the time at the top center of the screen
if (global.mode == "TimeAttack"){
draw_set_font(font_bold_large);  // Make sure to use a bold large font here
draw_text(x_position, 10, time_display);
}

// If the current room is rmTimeAttack, display the congratulatory text
if (room == rmTimeAttack){
	if (global.mode == "TimeAttack" || global.mode == "Endless") {
    var congrats_text = "";
    var congrats_color = c_white;
	}
    
    // Change the congratulatory message based on levels completed
    if (global.levelscompleted <= 5) {
        congrats_text = "Good run!";
    } else if (global.levelscompleted <= 10 && global.levelscompleted > 5) {
        congrats_text = "Try to collect Power-Ups!";
    } else if (global.levelscompleted <= 15 && global.levelscompleted > 10) {
        congrats_text = "Stay Focused, That's your best chance!";
    } else if (global.levelscompleted <= 20 && global.levelscompleted > 15) {
        congrats_text = "You're getting the hang of this!";
    } else if (global.levelscompleted <= 25 && global.levelscompleted > 20) {
        congrats_text = "Nice run! Keep up the good work!";
    } else if (global.levelscompleted <= 30 && global.levelscompleted > 25) {
        congrats_text = "Now that was cool!";
    } else if (global.levelscompleted <= 35 && global.levelscompleted > 30) {
        congrats_text = "Try Captured Echoes!";
    } else if (global.levelscompleted <= 40 && global.levelscompleted > 35) {
        congrats_text = "Nice job my friend! Well Done!";
    } else if (global.levelscompleted <= 45 && global.levelscompleted > 40) {
        congrats_text = "You're getting close to my record!";
    } else if (global.levelscompleted <= 50 && global.levelscompleted > 45) {
        congrats_text = "You beat my record! That's insane!";
    } else if (global.levelscompleted <= 60 && global.levelscompleted > 50) {
        congrats_text = "Oh my goodness you're good at this!";
    } else if (global.levelscompleted <= 80 && global.levelscompleted > 60) {
        congrats_text = "That was freaking amazing!";
    } else if (global.levelscompleted <= 100 && global.levelscompleted > 80) {
        congrats_text = "There's no way you just did that, Here's my Discord! noah_dubzz";
    } else if (global.levelscompleted <= 150 && global.levelscompleted > 100) {
        congrats_text = "Congratulations! You broke hhh_awesome's record of 115!";
    }
	    // Display the congratulatory text at the top-center of the screen
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(congrats_color);  // Set color for the congratulatory text
    draw_text(display_get_width() / 2, 50, congrats_text);
    
    // Display the levels completed at the center of the screen in large, bold text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(Grand_Total);  // Make sure to use a bold large font here
    draw_set_color(c_white);  // Set color for the text
    draw_text(display_get_width() / 2, display_get_height() / 2, "Levels Completed: " + string(global.levelscompleted));
	
} else if (room == rmMultiPrism) {
    var congrats_text = "";
    var congrats_color = c_white;
    
    // Change the congratulatory message based on levels completed
    if (global.winner == 1) {
        congrats_text = "Player 1 is the Winner!";
    } else if (global.winner == 2) {
        congrats_text = "Player 2 is the Winner!";
    }

    
    // Display the congratulatory text at the top-center of the screen
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(congrats_color);  // Set color for the congratulatory text
    draw_text(display_get_width() / 2, 50, congrats_text);
    
    // Display the levels completed at the center of the screen in large, bold text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
	draw_set_font(Grand_Total);  // Make sure to use a bold large font here
    draw_set_color(c_white);  // Set color for the text
    draw_text(display_get_width() / 2, display_get_height() / 2, "Levels Completed: " + string(global.levelscompleted));
}