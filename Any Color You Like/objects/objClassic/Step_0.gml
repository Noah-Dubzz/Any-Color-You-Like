// Step Event
if (position_meeting(mouse_x, mouse_y, id) || (global.selected_obj = objClassic)) {
    if (!hovering) {  // Only play sound if it's not already hovering
		audio_stop_sound(sndClassicMode);
		audio_stop_sound(sndEndlessMode);
		audio_stop_sound(sndMultiPrismMode);
		audio_stop_sound(sndTimeAttackMode);
        hovering = true;
        audio_play_sound(sndClassicMode, 1, false);
    }
} else {
    hovering = false;  // Reset when the mouse is not over the object
}


// Smoothly shift the object to the left when hovering
if (hovering) {
    // Check if the object has not moved more than 40 pixels left
    if (original_x - x < 40) {
        x = lerp(x, x - 5, 0.1);  // Shift left by 5 pixels
    }
} else {
    // Return to original position smoothly
    x = lerp(x, original_x, 0.1);  // Move back to the original position
}