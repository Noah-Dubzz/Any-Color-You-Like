if (global.Score = 30000){
	room_goto(rmLevel2);
}

if (!locked) {
    // Takes the player to the next level
	audio_resume_all();
	global.Score += 1000;
    if (room = rmLevel1){
		room_goto(rmLevel1)
	}
	if (room = rmLevel2){
		room_goto(rmLevel2)
	}
	audio_stop_sound(sndChasing);
	audio_stop_sound(sndBoost);
	audio_play_sound(sndDoor, 1, false);
}

