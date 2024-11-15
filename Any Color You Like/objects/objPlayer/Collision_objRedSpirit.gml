global.red_collected = true;
audio_play_sound(sndRedSpirit, 100, false);
instance_destroy(objRedSpirit);
if (global.blue_collected = true && global.green_collected = true && global.red_collected = true) {
	audio_play_sound(sndDoorOpen, 100, false);
}