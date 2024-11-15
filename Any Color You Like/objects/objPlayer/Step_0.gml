if(!audio_is_playing(sndLevel1)){
	audio_play_sound(sndLevel1, 1, true);
}

// Store previous position
previous_x = x;
previous_y = y;

// Resets movement direction
move_x = 0;
move_y = 0;

// Checks for input
if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    move_x = -1;
}
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    move_x = 1;
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    move_y = -1;
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    move_y = 1;
}

// Bug fix ignore this
if (move_x != 0 && move_y != 0) {
    move_x *= 0.7071; // 1 / sqrt(2)
    move_y *= 0.7071;
}

// Checks for dash input and if dash is available
if (keyboard_check_pressed(vk_space) && dash_timer == 0) {
    dash_active = true;
    dash_timer = dash_cooldown; // Starts cooldown timer
    dash_steps = dash_duration; // Sets the dash duration
    audio_play_sound(sndDash, 1, false);
} else if (keyboard_check_pressed(vk_space) && dash_timer > 1) {
    audio_play_sound(sndCoolDown, 1, false);
}

// Dash Junk
var move_x_speed, move_y_speed;
if (dash_active) {
    move_x_speed = dash_speed * move_x;
    move_y_speed = dash_speed * move_y;
    dash_steps -= 1;
    if (dash_steps <= 0) {
        dash_active = false; // End the dash after a few steps (can't let player be OP)
    }
} else {
    move_x_speed = global.move_speed * move_x;
    move_y_speed = global.move_speed * move_y;
}

// Save the previous position for collision handling
previous_x = x;
previous_y = y;

	
if (!ghost) {
    // Moves player horizontally and handles collision
    x += move_x_speed;
    if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        // If collision is detected, move the player back
        x = previous_x;
    }

    // Moves player vertically and handles collisions
    y += move_y_speed;
    if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        // If collision is detected, move the player back
        y = previous_y;
    }

	var locations = [
		[700, 450],
		[1315, 145],
		[970, 820],
		[1250, 630],
		[630, 920],
		[630, 150],
		[1250, 450],
		[700, 630],
		[1320, 920]
	];

// Initialize variables to find the closest location
var closest_distance = -1;
var closest_location = [x, y]; // Default to current position

// Check if the player is stuck in a wall after exiting ghost mode
if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
    // Loop through each predefined location
    for (var i = 0; i < array_length_1d(locations); i++) {
        var loc_x = locations[i][0];
        var loc_y = locations[i][1];
        
        // Calculate distance to the current location
        var distance = point_distance(x, y, loc_x, loc_y);
        
        // Check if this location is closer than the previously found closest location
        if (closest_distance == -1 || distance < closest_distance) {
            closest_distance = distance;
            closest_location = [loc_x, loc_y];
        }
    }
    
    // Move the player to the closest location
    x = closest_location[0];
    y = closest_location[1];
}
} else {
    // Ghost mode: move freely without collision detection
    x += move_x_speed;
    y += move_y_speed;
}

// Cooldown timer
if (dash_timer > 0) {
    dash_timer -= 1;
}

// Step Event of objPlayer
// Add the current position to the trail
if (array_length(trail) >= trail_length) {
    array_delete(trail, 0, 1); // Remove the oldest position (1 element at index 0)
}
array_push(trail, [x, y]); // Add current position

x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
