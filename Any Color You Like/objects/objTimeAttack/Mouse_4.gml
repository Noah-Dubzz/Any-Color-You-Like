// Mouse Left Pressed Event
if (hovering) {
	global.maze_left = 580;
	global.maze_right = 1330;
	global.maze_top = 100;
	global.maze_bottom = 930;
	global.lives = -1;
 // Choose a random room from rmLevel1, rmLevel2, and rmLevel3
    var selected_room = choose(rmLevel1, rmLevel2, rmLevel3, rmLevel4, rmLevel5);
    room_goto(selected_room);  // Go to the selected room
	global.mode = "TimeAttack"; 
	global.Score = 0;
	global.timer_initialized = true;
	audio_play_sound(sndDoor, 1, false);
	audio_stop_sound(sndBackgroundMusic);
	audio_stop_sound(sndDead);
}
