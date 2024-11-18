
if (!locked && global.respawning = false) {
    // Takes the player to the next level
	audio_resume_all();
	global.Score += 1000;

    if (room = rmLevel1){
		room_goto(rmLevel1)
	}
	if (room = rmLevel2){
		room_goto(rmLevel2)
	}
	if (room = rmLevel3){
		room_goto(rmLevel3)
	}
	if (global.Score = 8000){
		room_goto(rmLevel2);
		audio_stop_all();
		global.move_speed = 7;
		global.is_boosted = false;
		global.nochasing = false;
	}
	if (global.Score = 17000){
		room_goto(rmLevel3);
		audio_stop_all();
		global.move_speed = 7;
		global.is_boosted = false;
		global.nochasing = false;
	}
	audio_stop_sound(sndChasing);
	audio_stop_sound(sndBoost);
	audio_play_sound(sndDoor, 1, false);
}

