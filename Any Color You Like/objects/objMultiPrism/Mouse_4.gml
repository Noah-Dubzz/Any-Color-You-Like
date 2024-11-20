// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmLevel1);
	global.mode = "MultiPrism"; 
	global.Score = 0;
	global.lives = 3;
	global.p2lives = 3;
	global.maze_left = 580;
	global.maze_right = 1330;
	global.maze_top = 100;
	global.maze_bottom = 930;
	audio_play_sound(sndDoor, 1, false);
	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
