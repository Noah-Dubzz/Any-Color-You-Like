if (keyboard_check_pressed(vk_space) && dash_timer == 0) {
	objPlayer2.x = teleportx;
	objPlayer2.y = teleporty;
	audio_play_sound(sndPacMan, 1, false);
}