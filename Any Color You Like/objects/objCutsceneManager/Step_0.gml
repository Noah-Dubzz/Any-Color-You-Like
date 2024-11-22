if (keyboard_check(vk_escape)) {
	room_goto(rmModeSelect);
	global.mode = "Choosing";
	var camera = view_camera[0];
	global.Score = 0;
	global.lives = 0;
}

// Check if the cutscene is in progress
if (global.cutscene == 1) {
    // Wait for the audio to finish playing
    if (!audio_is_playing(global.audio_to_monitor)) {
        // Audio has finished, move to the next room
	if (global.currentcutscene == 0){
        room_goto(rmLevel1);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 1){
        room_goto(rmLevel2);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 2){
        room_goto(rmLevel3);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 3){
        room_goto(rmLevel4);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 4){
        room_goto(rmLevel5);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 5){
        room_goto(rmEnding);
		global.cutscene = 0;
    }
}
}