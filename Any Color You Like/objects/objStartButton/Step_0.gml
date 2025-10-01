// Step Event of objStartButton

// Initialize controller if connected
if (gamepad_is_connected(0)) {
    gamepad_set_axis_deadzone(0, 0.2);
}

// Initialize delta time for UI animations
if (!variable_global_exists("delta_multiplier")) {
    global.delta_multiplier = 1.0;
} else {
    var dt_seconds = delta_time / 1000000;
    var target_frame_time = 1.0 / 60.0;
    global.delta_multiplier = dt_seconds / target_frame_time;
    global.delta_multiplier = clamp(global.delta_multiplier, 0.1, 3.0);
}

// Fade in the button with delta time
if (alpha < 1) {
    alpha += fade_speed * global.delta_multiplier; // Delta time adjusted fade
    if (alpha > 1) {
        alpha = 1; // Clamp alpha to 1
    }
}

// Enhanced input: Controller + Keyboard support + Any key to start
if (gamepad_button_check_pressed(0, gp_face1) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_anykey)) {
	room_goto(rmModeSelect);
	audio_play_sound(sndDoor, 1, false);
}