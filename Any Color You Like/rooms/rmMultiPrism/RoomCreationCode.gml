		audio_stop_all();
		audio_play_sound(sndYouWin, 1, true);
		if (global.winner = 2){
			audio_play_sound(sndP2Wins, 1, false);
		}
		if (global.winner = 1){
			audio_play_sound(sndP1Wins, 1, false);
		}