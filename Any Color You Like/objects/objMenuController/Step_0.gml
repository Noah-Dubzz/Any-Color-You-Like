// Check for controller connection and initialize if needed
if (!gamepad_is_connected(0)) {
    for (var i = 0; i < 12; i++) {
        if (gamepad_is_connected(i)) {
            gamepad_set_axis_deadzone(i, 0.2);
            break;
        }
    }
}

// Initialize the menu items (if not already set)
    global.menu_items = [objClassic, objEndlessMode, objMultiPrism, objTimeAttack];

// Enhanced input system: Controller + Keyboard + Mouse + Number Keys
var input_up = gamepad_axis_value(0, gp_axislv) < -0.5 || keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var input_down = gamepad_axis_value(0, gp_axislv) > 0.5 || keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var input_select = gamepad_button_check_pressed(0, gp_face1) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

// Quick access number keys (1-4 for menu items)
if (keyboard_check_pressed(ord("1"))) {
    global.menu_selection = 0;
    global.selected_obj = global.menu_items[0];
    input_select = true; // Auto-select
}
if (keyboard_check_pressed(ord("2"))) {
    global.menu_selection = 1;
    global.selected_obj = global.menu_items[1];
    input_select = true; // Auto-select
}
if (keyboard_check_pressed(ord("3"))) {
    global.menu_selection = 2;
    global.selected_obj = global.menu_items[2];
    input_select = true; // Auto-select
}
if (keyboard_check_pressed(ord("4"))) {
    global.menu_selection = 3;
    global.selected_obj = global.menu_items[3];
    input_select = true; // Auto-select
}

// Handle menu navigation
if (input_up && !scrolling) {
    global.menu_selection = (global.menu_selection - 1 + array_length(global.menu_items)) mod array_length(global.menu_items);
    global.selected_obj = global.menu_items[global.menu_selection];
    audio_play_sound(sndButton, 1, false); // Add menu navigation sound
    scrolling = true;
} else if (input_down && !scrolling) {
    global.menu_selection = (global.menu_selection + 1) mod array_length(global.menu_items);
    global.selected_obj = global.menu_items[global.menu_selection];
    audio_play_sound(sndButton, 1, false); // Add menu navigation sound
    scrolling = true;
}

// Reset scrolling when no input
if (!input_up && !input_down) {
    scrolling = false;
}

// Confirm selection with controller, keyboard, or mouse
if (input_select) {
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

