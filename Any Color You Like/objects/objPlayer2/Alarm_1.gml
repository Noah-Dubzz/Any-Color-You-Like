// Alarm[0] Event - Revert Speed Boost

global.p2move_speed = global.p2original_move_speed; // Revert back to original speed
global.p2is_boosted = false; // Reset the boost flag

// Stop the sound effect
audio_stop_sound(sndBoost);

// Enable collision again
p2ghost = false; // Reset the ghost flag