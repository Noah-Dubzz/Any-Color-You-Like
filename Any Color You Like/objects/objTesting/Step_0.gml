// Check if a specific key (e.g., "N" for Next level) is pressed
if (keyboard_check_pressed(ord("1"))) {
    // Change to the next level
    // Replace "room_next" with the name of your target room, or use room_goto_next() for sequential rooms.
    if (room_exists(rmLevel1)) {
		audio_stop_all();
        room_goto(rmLevel1);
    } else {
        show_debug_message("Next room does not exist.");
    }
}
// Check if a specific key (e.g., "N" for Next level) is pressed
if (keyboard_check_pressed(ord("2"))) {
    // Change to the next level
    // Replace "room_next" with the name of your target room, or use room_goto_next() for sequential rooms.
    if (room_exists(rmLevel2)) {
		audio_stop_all();
        room_goto(rmLevel2);
    } else {
        show_debug_message("Next room does not exist.");
    }
}
// Check if a specific key (e.g., "N" for Next level) is pressed
if (keyboard_check_pressed(ord("3"))) {
    // Change to the next level
    // Replace "room_next" with the name of your target room, or use room_goto_next() for sequential rooms.
    if (room_exists(rmLevel3)) {
		audio_stop_all();
        room_goto(rmLevel3);
    } else {
        show_debug_message("Next room does not exist.");
    }
}
// Check if a specific key (e.g., "N" for Next level) is pressed
if (keyboard_check_pressed(ord("4"))) {
    // Change to the next level
    // Replace "room_next" with the name of your target room, or use room_goto_next() for sequential rooms.
    if (room_exists(rmLevel4)) {
		audio_stop_all();
        room_goto(rmLevel4);
    } else {
        show_debug_message("Next room does not exist.");
    }
}
// Check if a specific key (e.g., "N" for Next level) is pressed
if (keyboard_check_pressed(ord("5"))) {
    // Change to the next level
    // Replace "room_next" with the name of your target room, or use room_goto_next() for sequential rooms.
    if (room_exists(rmLevel5)) {
        room_goto(rmLevel5);
    } else {
        show_debug_message("Next room does not exist.");
    }
}