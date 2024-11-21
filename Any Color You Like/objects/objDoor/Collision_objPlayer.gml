
if (!locked && global.respawning = false) {
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
	if (room == rmLevel4) {
        room_goto(rmLevel4);
    }
	 if (room == rmLevel5) {
        room_goto(rmLevel5);
    }
}
if (global.mode == "MultiPrism") {
 // Choose a random room from rmLevel1, rmLevel2, and rmLevel3
    var selected_room = choose(rmLevel1, rmLevel2, rmLevel3, rmLevel4);
    room_goto(selected_room);  // Go to the selected room
}
if (global.mode == "Endless") {
	room_goto(rmEndless);
}
if (global.mode == "TimeAttack") {
    // Choose a random room from rmLevel1, rmLevel2, and rmLevel3
    var selected_room = choose(rmLevel1, rmLevel2, rmLevel3, rmLevel4);
    room_goto(selected_room);  // Go to the selected room
}
	if (global.Score = 8000 && global.mode = "Classic"){
		room_goto(rmLevel2);
		audio_stop_all();
		global.move_speed = 7;
		global.is_boosted = false;
		global.nochasing = false;
	}
	if (global.Score = 17000 && global.mode = "Classic"){
		room_goto(rmLevel3);
		audio_stop_all();
		global.move_speed = 7;
		global.is_boosted = false;
		global.nochasing = false;
	}
	if (global.Score = 26000 && global.mode = "Classic"){
		room_goto(rmLevel4);
		audio_stop_all();
		global.move_speed = 7;
		global.is_boosted = false;
		global.nochasing = false;
	}
	if (global.Score = 32000 && global.mode = "Classic"){
		room_goto(rmLevel5);
		audio_stop_all();
		global.move_speed = 7;
		global.is_boosted = false;
		global.nochasing = false;
	}
	audio_stop_sound(sndChasing);
	audio_stop_sound(sndBoost);
	audio_play_sound(sndDoor, 1, false);
}

