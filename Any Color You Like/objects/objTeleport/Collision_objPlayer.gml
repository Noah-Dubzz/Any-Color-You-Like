if (keyboard_check_pressed(vk_space)) {
	objPlayer.x = teleportx;
	objPlayer.y = teleporty;
	audio_play_sound(sndPacMan, 1, false);
}