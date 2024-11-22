audio_play_sound(sndBadTheme, 1, false);
if (global.cutscene == 0) {
    // Play the audio and store its sound ID to monitor
	if (global.currentcutscene == 0){
    var sound_id = audio_play_sound(sndLevel1D, 1, false);
	}
	if (global.currentcutscene == 1){
    sound_id = audio_play_sound(sndLevel2D, 1, false);
	}
	if (global.currentcutscene == 2){
    sound_id = audio_play_sound(sndLevel3D, 1, false);
	}
	if (global.currentcutscene == 3){
    sound_id = audio_play_sound(sndLevel4D, 1, false);
	}
	if (global.currentcutscene == 4){
    sound_id = audio_play_sound(sndLevel5D, 1, false);
	}
	if (global.currentcutscene == 5){
    sound_id = audio_play_sound(sndEnding, 1, false);
	}
    global.audio_to_monitor = sound_id; // Store the sound ID globally to track its status
    global.cutscene = 1;               // Mark that the cutscene has started
}