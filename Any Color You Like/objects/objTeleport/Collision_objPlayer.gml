if (keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1)) {
	objPlayer.x = teleportx;
	objPlayer.y = teleporty;
	audio_play_sound(sndPacMan, 1, false);
}