// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmCutscene);
	global.lives = 3;
	// Makes sure the enemy stays within the room/maze boundaries
	global.maze_left = 580;
	global.maze_right = 1330;
	global.maze_top = 100;
	global.maze_bottom = 930;
	global.cutscene = 0;
	global.currentcutscene = 0;
	global.mode = "Classic"; 
	global.Score = 0;
	audio_play_sound(sndDoor, 1, false);
	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
