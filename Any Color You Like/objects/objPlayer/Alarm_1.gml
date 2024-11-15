// Alarm[0] Event - Revert Speed Boost

global.move_speed = global.original_move_speed; // Revert back to original speed
global.is_boosted = false; // Reset the boost flag

// Stop the sound effect
audio_stop_sound(sndBoost);

// Enable collision again
objPlayer.ghost = false; // Reset the ghost flag