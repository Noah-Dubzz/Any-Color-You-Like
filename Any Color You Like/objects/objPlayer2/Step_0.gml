if (global.timer < 0 && global.mode == "TimeAttack") {
    audio_stop_all();
    room_goto(rmTimeAttack);
}

if (global.mode == "TimeAttack") {
    global.p2boosted_move_speed = 20;
    global.p2move_speed = 14;
}

// Target the player's position
camera_target_x = lerp(camera_target_x, x, camera_smooth_speed);
camera_target_y = lerp(camera_target_y, y, camera_smooth_speed);

// Get the active camera
if (global.mode == "Classic" || global.mode == "Endless" || global.mode == "TimeAttack") {
    var camera = view_camera[0];
}
if (global.mode == "MultiPrism") {
    var camera = view_camera[2];
}

// Center the camera on the smoothed target
var cam_width = camera_get_view_width(camera);
var cam_height = camera_get_view_height(camera);
camera_set_view_pos(camera, camera_target_x - cam_width / 2, camera_target_y - cam_height / 2);

// Store previous position
p2previous_x = x;
p2previous_y = y;

// Resets movement direction
p2move_x = 0;
p2move_y = 0;

// Checks for input
if (keyboard_check(vk_left)) {
    p2move_x = -1;
}
if (keyboard_check(vk_right)) {
    p2move_x = 1;
}
if (keyboard_check(vk_up)) {
    p2move_y = -1;
}
if (keyboard_check(vk_down)) {
    p2move_y = 1;
}

// Bug fix: Normalize diagonal movement
if (p2move_x != 0 && p2move_y != 0) {
    p2move_x *= 0.7071; // 1 / sqrt(2)
    p2move_y *= 0.7071;
}

// Checks for dash input and if dash is available
if (keyboard_check_pressed(vk_enter) && p2dash_timer == 0) {
    p2dash_active = true;
    p2dash_timer = p2dash_cooldown; // Starts cooldown timer
    p2dash_steps = p2dash_duration; // Sets the dash duration
    audio_play_sound(sndDash, 1, false);
} else if (keyboard_check_pressed(vk_enter) && p2dash_timer > 1) {
    audio_play_sound(sndCoolDown, 1, false);
}

// Dash handling
var p2move_x_speed, p2move_y_speed;
if (p2dash_active) {
    p2move_x_speed = p2dash_speed * p2move_x;
    p2move_y_speed = p2dash_speed * p2move_y;
    p2dash_steps -= 1;
    if (p2dash_steps <= 0) {
        p2dash_active = false; // End the dash after a few steps
    }
} else {
    p2move_x_speed = global.p2move_speed * p2move_x;
    p2move_y_speed = global.p2move_speed * p2move_y;
}

// Save the previous position for collision handling
p2previous_x = x;
p2previous_y = y;

// Handle movement and collision
if (!p2ghost) {
    // Moves player horizontally and handles collision
    x += p2move_x_speed;
    if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        // If collision is detected, move the player back
        x = p2previous_x;
    }

    // Moves player vertically and handles collisions
    y += p2move_y_speed;
    if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        // If collision is detected, move the player back
        y = p2previous_y;
    }


	if (room = rmLevel1){
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
	}
	if (room = rmLevel2){
	var locations = [
	[435, 250],
    [1380, 250],
    [1475, 845],
    [545, 845],
    [905, 335],
	[1025, 335],
	[860, 845],
	[1175, 845],
    [1660, 905],
	[265, 905],
	[1660, 195],
	[265, 195],
	[1270, 535],
	[655, 535]
	];
	}
	if (room = rmLevel3){
	var locations = [
	[1765, 1065],
    [1245, 1065],
    [1345, 765],
    [1665, 765],
    [1510, 405],
	[1245, 295],
	[1765, 295],
	[1345, 1400],
    [1665, 1400],
	[1710, 1690],
	[1295, 1690],
	[1415, 1690],
	[1595, 1690],
	[1500, 920]
	];
	}
	if (room = rmEndless){
	var locations = [
	[65, 80],
    [50, 470],
    [50, 750],
    [50, 1025],
    [560, 935],
	[385, 795],
	[380, 380],
	[475, 170],
    [670, 170],
	[740, 485],
	[1220, 485],
	[1220, 740],
	[740, 740],
	[1305, 220],
	[1575, 365],
	[1855, 80],
	[1855, 1025],
	[1575, 860],
	[1305, 1000],
	[1375, 610],
	[560, 610],
	[985, 55]
	];
	}
	
// Handle wall collision after ghost mode
    var closest_distance = -1;
    var closest_location = [x, y]; // Default to current position

    if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        for (var i = 0; i < array_length_1d(locations); i++) {
            var loc_x = locations[i][0];
            var loc_y = locations[i][1];
            
            var distance = point_distance(x, y, loc_x, loc_y);
            
            if (closest_distance == -1 || distance < closest_distance) {
                closest_distance = distance;
                closest_location = [loc_x, loc_y];
            }
        }

        x = closest_location[0];
        y = closest_location[1];
    }
} else {
    // Ghost mode: move freely without collision detection
    x += p2move_x_speed;
    y += p2move_y_speed;
}

// Cooldown timer
if (p2dash_timer > 0) {
    p2dash_timer -= 1;
}

// Step Event of objPlayer: Update trail
if (array_length(trail) >= trail_length) {
    array_delete(trail, 0, 1); // Remove the oldest position
}
array_push(trail, [x, y]); // Add current position

if (global.p2lives <= 0){
	room_goto(rmMultiPrism);
	global.winner = 1;
	audio_stop_all();
}
// Clamp the player's position within the maze bounds
x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);