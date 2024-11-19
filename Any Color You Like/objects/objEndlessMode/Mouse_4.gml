// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmEndless);
	global.lives = 5;
	global.maze_left = 15;
	global.maze_right = 1904;
	global.maze_top = 15;
	global.maze_bottom = 1064;
	global.mode = "Endless"; 
	global.Score = 0;
	audio_play_sound(sndDoor, 1, false);
	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
