if (global.lives > 0){
	if (room = rmLevel1){
	x = 950;
	y = 285;
	}
	if (room = rmLevel2){
	x = 950;
	y = 230;
	}
	global.lives--;
}
if (global.lives <= 0){
audio_stop_all();
audio_play_sound(sndDead, 100, false);
room_goto(rmTitleScreen);
}