if ((keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(1, gp_face1)) && objPlayer2.p2dash_timer == 0) {
	objPlayer2.x = teleportx;
	objPlayer2.y = teleporty;
	audio_play_sound(sndPacMan, 1, false);
}