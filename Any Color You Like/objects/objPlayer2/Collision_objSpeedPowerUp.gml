    // Increase the player's move speed
    global.p2move_speed = global.p2boosted_move_speed;
    
    // Set the boost flag to true
    global.p2is_boosted = true;

    // Start a countdown to revert the speed after the duration
    alarm[1] = room_speed * global.p2speed_boost_duration; // Duration in frames

    // Disable collision with other objects except room boundaries
    p2ghost = true; // Set a ghost flag to disable collision
		
    // Sound effect for speed boost
    audio_play_sound(sndBoost, 1, true); // Ensure this sound is set correctly

    // Destroy this power-up instance
    instance_destroy(objSpeedPowerUp);