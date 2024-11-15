// Destroy the power-up
instance_destroy(objSlowPowerUp);

// Set enemy speed to 0
global.enemyspeed = 0;
global.nochasing = true;
audio_pause_all();
audio_play_sound(sndFreeze, 1, false);

// Set an alarm to restore enemy speed after 5 seconds
alarm[0] = room_speed * 7.57; // room_speed * 5 is 5 seconds