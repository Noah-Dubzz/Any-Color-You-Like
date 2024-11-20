global.green_collected = true;
audio_play_sound(sndGreenSpirit, 100, false);
instance_destroy(objGreenSpirit);
if (global.blue_collected = true && global.green_collected = true && global.red_collected = true) {
	audio_play_sound(sndDoorOpen, 100, false);
}