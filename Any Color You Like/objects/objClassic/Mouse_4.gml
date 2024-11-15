// Mouse Left Pressed Event
if (hovering) {
	room_goto(rmLevel1);
	global.lives = 100;
	// Makes sure the enemy stays within the room/maze boundaries
	global.maze_left = 580;
	global.maze_right = 1330;
	global.maze_top = 100;
	global.maze_bottom = 930;
	global.mode = "Classic"; 
	global.Score = 0;
	audio_play_sound(sndDoor, 1, false);
	if (global.Score < 30000){
	audio_play_sound(sndLevel1, 100, true);
	}
	if (global.Score < 60000){
	audio_play_sound(sndLevel1, 100, true);
	}
	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
