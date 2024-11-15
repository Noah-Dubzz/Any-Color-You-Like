// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmLevel2);
	global.lives = 3;
	global.maze_left = 177;
	global.maze_right = 1732;
	global.maze_top = 112;
	global.maze_bottom = 965;
	global.mode = "Classic"; 
	global.Score = 0;
	audio_play_sound(sndDoor, 1, false);

	if (global.Score < 5000){
		audio_play_sound(sndLevel1, 100, true);
	}

	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
