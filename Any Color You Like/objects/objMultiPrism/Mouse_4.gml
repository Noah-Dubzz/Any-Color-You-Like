// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmLevel1);
	global.mode = "Classic"; 
	global.Score = 0;
	audio_play_sound(sndDoor, 1, false);

	if (global.Score < 5000){
		audio_play_sound(sndLevel1, 100, true);
	}

	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
