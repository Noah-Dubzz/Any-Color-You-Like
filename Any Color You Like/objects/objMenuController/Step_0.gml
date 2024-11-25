// Initialize the menu items (if not already set)
    global.menu_items = [objClassic, objEndlessMode, objMultiPrism, objTimeAttack];

// Joystick vertical axis input
var joy_y = gamepad_axis_value(0, gp_axislv);

// Deadzone check to prevent accidental input
if (abs(joy_y) > 0.5) {
    if (joy_y > 0) {
        // Scroll down
        if (!scrolling) {
            global.menu_selection = (global.menu_selection + 1) mod array_length(global.menu_items);
            global.selected_obj = global.menu_items[global.menu_selection];
            scrolling = true; // Prevent repeated inputs in one direction
        }
    } else {
        // Scroll up
        if (!scrolling) {
            global.menu_selection = (global.menu_selection - 1 + array_length(global.menu_items)) mod array_length(global.menu_items);
            global.selected_obj = global.menu_items[global.menu_selection];
            scrolling = true; // Prevent repeated inputs in one direction
        }
    }
} else {
    scrolling = false; // Reset scrolling state when joystick is neutral
}

// Confirm selection with the A button (gp_face1)
if (gamepad_button_check_pressed(0, gp_face1)) {
    // Execute the action tied to the selected menu item
    global.selected_obj = global.menu_items[global.menu_selection];

    if (global.selected_obj == objClassic) {
        room_goto(rmCutscene);
        global.lives = 3;
        global.maze_left = 580;
        global.maze_right = 1330;
        global.maze_top = 100;
        global.maze_bottom = 930;
        global.cutscene = 0;
        global.currentcutscene = 0;
        global.mode = "Classic"; 
        global.Score = 0;
        audio_play_sound(sndDoor, 1, false);
        audio_stop_sound(sndBackgroundMusic);
        audio_stop_sound(sndDead);
    } else if (global.selected_obj == objEndlessMode) {
        room_goto(rmEndless);
        global.lives = 5;
        global.maze_left = 15;
        global.maze_right = 1904;
        global.maze_top = 15;
        global.maze_bottom = 1064;
        global.mode = "Endless"; 
        global.Score = 0;
        audio_play_sound(sndDoor, 1, false);
        audio_stop_sound(sndBackgroundMusic);
        audio_stop_sound(sndDead);
    } else if (global.selected_obj == objMultiPrism) {
        var selected_room = choose(rmLevel1, rmLevel2, rmLevel3, rmLevel4, rmLevel5);
        room_goto(selected_room);  
        global.mode = "MultiPrism"; 
        global.Score = 0;
        global.lives = 3;
        global.p2lives = 3;
        global.maze_left = 580;
        global.maze_right = 1330;
        global.maze_top = 100;
        global.maze_bottom = 930;
        audio_play_sound(sndDoor, 1, false);
        audio_stop_sound(sndBackgroundMusic);
        audio_stop_sound(sndDead);
    } else if (global.selected_obj == objTimeAttack) {
        global.maze_left = 580;
        global.maze_right = 1330;
        global.maze_top = 100;
        global.maze_bottom = 930;
        global.lives = -1;
        var selected_room = choose(rmLevel1, rmLevel2, rmLevel3, rmLevel4, rmLevel5);
        room_goto(selected_room);  
        global.mode = "TimeAttack"; 
        global.Score = 0;
        global.timer_initialized = true;
        audio_play_sound(sndDoor, 1, false);
        audio_stop_sound(sndBackgroundMusic);
        audio_stop_sound(sndDead);
    }
}

