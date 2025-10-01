if (global.mode == "MultiPrism"){
if (!locked && global.p2respawning = false) {
    // Takes the player to the next level
	audio_resume_all();
	global.Score += 1000;
	
if (global.mode == "Classic") {
    if (room == rmLevel1) {
        room_goto(rmLevel1);
    }
    if (room == rmLevel2) {
        room_goto(rmLevel2);
    }
    if (room == rmLevel3) {
        room_goto(rmLevel3);
    }
}
if (global.mode == "MultiPrism") {
 // Choose a random room from rmLevel1, rmLevel2, and rmLevel3
    var selected_room = choose(rmLevel1, rmLevel2, rmLevel3);
    room_goto(selected_room);  // Go to the selected room
}
if (global.mode == "Endless") {
	room_goto(rmEndless);
}
if (global.mode == "TimeAttack") {
    // Choose a random room from rmLevel1, rmLevel2, and rmLevel3
    var selected_room = choose(rmLevel1, rmLevel2, rmLevel3);
    room_goto(selected_room);  // Go to the selected room
}
	if (global.Score = 8000 && global.mode = "Classic"){
		room_goto(rmLevel2);
		// Let Player 1 handle audio management
		global.p2move_speed = 7;
		global.p2is_boosted = false;
		global.p2nochasing = false;
	}
	if (global.Score = 17000 && global.mode = "Classic"){
		room_goto(rmLevel3);
		// Let Player 1 handle audio management
		global.p2move_speed = 7;
		global.p2is_boosted = false;
		global.p2nochasing = false;
	}
	audio_stop_sound(sndChasing);
	audio_stop_sound(sndBoost);
	audio_play_sound(sndDoor, 1, false);
}
}