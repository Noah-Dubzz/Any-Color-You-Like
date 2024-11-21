// Check if the player has any remaining lives
if (global.mode = "Classic" || global.mode = "Endless" || global.mode = "MultiPrism"){
	if (global.p2lives > 0) {
		// Respawn logic is already handled in the collision code; no need to do anything else here.
	} else {
		// If no lives left, return to the title screen
		if (global.mode = "Classic"){
		audio_stop_all();
		audio_play_sound(sndDead, 100, false);
		room_goto(rmTitleScreen);
		}
		if (global.mode = "MultiPrism"){
		room_goto(rmMultiPrism);
		global.winner = 1;
		audio_stop_all();
		audio_play_sound(sndYouWin, 1, true);
		}
		if (global.mode = "TimeAttack" || global.mode = "Endless"){
		room_goto(rmTimeAttack);
		audio_stop_all();
		audio_play_sound(sndYouWin, 1, true);
		}
	}
}

if (!global.p2respawning) {
    // Start the respawn process
    global.p2respawning = true;

    // Make the player invisible
    visible = false;

    // Play the death sound
    audio_play_sound(sndDie, 100, false);
    // Prevent the player from moving during the respawn
    global.p2move_speed = 0;
	if (global.mode = "Classic" || global.mode = "Endless" || global.mode = "MultiPrism"){
    global.p2lives--;
	}
    // Set alarm[0] to trigger after the sound's duration (converted to frames)
    alarm[3] = ceil(audio_sound_length(sndDie) * room_speed);
}