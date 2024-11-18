// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmLevel3);
	global.mode = "Multiprism"; 
	global.Score = 0;
	global.lives = 3;
global.maze_left = 1195;
global.maze_right = 1795;
global.maze_top = 245;
global.maze_bottom = 1800;
	audio_play_sound(sndDoor, 1, false);

	if (global.Score < 5000){
		audio_play_sound(sndLevel1, 100, true);
	}

	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
