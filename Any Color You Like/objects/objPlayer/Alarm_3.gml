// When the alarm triggers, the respawn delay is over
global.respawning = false;

// Make the player visible again
visible = true;

// Allow the player to move again (reset speed to normal)
global.move_speed = 7;
// Move the player to the spawn point (based on the current room)
    if (room == rmLevel1) {
        room_goto(rmLevel1);
		audio_stop_sound(sndChasing);
    } else if (room == rmLevel2) {
        room_goto(rmLevel2);
		audio_stop_sound(sndChasing);
    } else if (room == rmLevel3) {
        room_goto(rmLevel3);
		audio_stop_sound(sndChasing);
    }
