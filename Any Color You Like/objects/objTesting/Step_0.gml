// Function to check if the required keys are pressed
function are_required_keys_held() {
    return keyboard_check(ord("N")) &&
           keyboard_check(ord("O")) &&
           keyboard_check(ord("A")) &&
           keyboard_check(ord("H"));
}

// Check if the required keys are held and specific numeric key is pressed
if (are_required_keys_held() && keyboard_check_pressed(ord("1"))) {
    if (room_exists(rmLevel1)) {
        audio_stop_all();
        room_goto(rmLevel1);
    } else {
        show_debug_message("Next room does not exist.");
    }
}

if (are_required_keys_held() && keyboard_check_pressed(ord("2"))) {
    if (room_exists(rmLevel2)) {
        global.Score = 8000;
        audio_stop_all();
        room_goto(rmLevel2);
    } else {
        show_debug_message("Next room does not exist.");
    }
}

if (are_required_keys_held() && keyboard_check_pressed(ord("3"))) {
    if (room_exists(rmLevel3)) {
        global.Score = 17000;
        audio_stop_all();
        room_goto(rmLevel3);
    } else {
        show_debug_message("Next room does not exist.");
    }
}

if (are_required_keys_held() && keyboard_check_pressed(ord("4"))) {
    if (room_exists(rmLevel4)) {
        global.Score = 26000;
        audio_stop_all();
        room_goto(rmLevel4);
    } else {
        show_debug_message("Next room does not exist.");
    }
}

if (are_required_keys_held() && keyboard_check_pressed(ord("5"))) {
    if (room_exists(rmLevel5)) {
        global.Score = 32000;
        audio_stop_all();
        room_goto(rmLevel5);
    } else {
        show_debug_message("Next room does not exist.");
    }
}
