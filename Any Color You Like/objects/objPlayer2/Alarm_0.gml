// Reset enemy speed to normal (example value: 2)
global.enemyspeed = 2;
global.nochasing = false;
audio_resume_all();
audio_stop_sound(sndFreeze);

// Stop controller rumble
if (gamepad_is_connected(1)) {
    gamepad_set_vibration(1, 0, 0);
}