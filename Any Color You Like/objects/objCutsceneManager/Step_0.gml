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
    if (!audio_is_playing(global.audio_to_monitor) || gamepad_button_check_pressed(0, gp_start) || keyboard_check(vk_enter)){
        // Audio has finished, move to the next room
	if (global.currentcutscene == 0){
		audio_stop_all();
        room_goto(rmLevel1);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 1){
		audio_stop_all();
        room_goto(rmLevel2);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 2){
		audio_stop_all();
        room_goto(rmLevel3);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 3){
		audio_stop_all();
        room_goto(rmLevel4);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 4){
		audio_stop_all();
        room_goto(rmLevel5);
		global.cutscene = 0;
    }
	if (global.currentcutscene == 5){
		audio_stop_all();
        room_goto(rmModeSelect);
		global.cutscene = 0;
    }
}
}