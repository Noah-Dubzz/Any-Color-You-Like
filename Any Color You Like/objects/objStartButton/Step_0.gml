// Step Event of objStartButton

// Fade in the button
if (alpha < 1) {
    alpha += fade_speed; // Increase alpha for fade-in effect
    if (alpha > 1) {
        alpha = 1; // Clamp alpha to 1
    }
}

if (gamepad_button_check_pressed(0, gp_face1)) {
	room_goto(rmModeSelect);
}