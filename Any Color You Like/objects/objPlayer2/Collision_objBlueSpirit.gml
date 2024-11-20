global.blue_collected = true;
audio_play_sound(sndBlueSpirit, 100, false);
instance_destroy(objBlueSpirit);
if (global.blue_collected = true && global.green_collected = true && global.red_collected = true) {
	audio_play_sound(sndDoorOpen, 100, false);
}