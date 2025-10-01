// Initialize controller support
if (gamepad_is_connected(0)) {
    gamepad_set_axis_deadzone(0, 0.2);
}

// Initialize menu selection variables
if (!variable_global_exists("menu_selection")) {
    global.menu_selection = 0;
}
if (!variable_global_exists("selected_obj")) {
    global.selected_obj = objClassic;
}

scrolling = false; // Reset scrolling state when joystick is neutral