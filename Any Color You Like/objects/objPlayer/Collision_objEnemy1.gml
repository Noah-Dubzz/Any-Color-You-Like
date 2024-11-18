// Check if the player has any remaining lives
if (global.mode = "Classic"){
	if (global.lives > 0) {
		// Respawn logic is already handled in the collision code; no need to do anything else here.
	} else {
		// If no lives left, return to the title screen
		audio_stop_all();
		audio_play_sound(sndDead, 100, false);
		room_goto(rmTitleScreen);
	}
}

if (!global.respawning) {
    // Start the respawn process
    global.respawning = true;

    // Make the player invisible
    visible = false;

    // Play the death sound
    audio_play_sound(sndDie, 100, false);
    // Prevent the player from moving during the respawn
    global.move_speed = 0;
	if (global.mode = "Classic"){
    global.lives--;
	}
    // Set alarm[0] to trigger after the sound's duration (converted to frames)
    alarm[3] = ceil(audio_sound_length(sndDie) * room_speed);
}