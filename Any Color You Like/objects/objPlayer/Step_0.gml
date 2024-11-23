if (keyboard_check(vk_escape)) {
	room_goto(rmModeSelect);
	global.mode = "Choosing";
	var camera = view_camera[0];
	global.Score = 0;
	global.lives = 0;
}

if (global.timer < 0 && global.mode = "TimeAttack"){
	audio_stop_all();
	room_goto(rmTimeAttack);
}

if (global.mode = "TimeAttack"){
	global.boosted_move_speed = 20;
	global.move_speed = 14;
}

// Target the player's position
camera_target_x = lerp(camera_target_x, x, camera_smooth_speed);
camera_target_y = lerp(camera_target_y, y, camera_smooth_speed);

// Get the active camera
if (global.mode = "Classic" || global.mode = "Endless" || global.mode = "TimeAttack"){
view_visible[0] = true;
view_visible[1] = false;
view_visible[2] = false;
var camera = view_camera[0];
}
if (global.mode = "MultiPrism"){
view_visible[0] = false;
view_visible[1] = true;
view_visible[2] = true;
var camera = view_camera[1];
}

// Center the camera on the smoothed target
var cam_width = camera_get_view_width(camera);
var cam_height = camera_get_view_height(camera);
camera_set_view_pos(camera, camera_target_x - cam_width / 2, camera_target_y - cam_height / 2);
if(room = rmLevel1 && global.mode == "Classic"){
	if(!audio_is_playing(sndLevel1)){
		audio_play_sound(sndLevel1, 1, true);
	}
}
if(room = rmLevel2 && global.mode == "Classic"){
	if(!audio_is_playing(sndLevel2)){
		audio_play_sound(sndLevel2, 1, true);
	}
}
if(room = rmLevel3 && global.mode == "Classic"){
	if(!audio_is_playing(sndLevel3)){
		audio_play_sound(sndLevel3, 1, true);
	}
}
if(room = rmLevel4 && global.mode == "Classic"){
	if(!audio_is_playing(sndLevel4)){
		audio_play_sound(sndLevel4, 1, true);
	}
}
if(room = rmLevel5 && global.mode == "Classic"){
	if(!audio_is_playing(sndLevel5)){
		audio_play_sound(sndLevel5, 1, true);
	}
}
if(global.mode = "TimeAttack"){
	if(!audio_is_playing(sndTimeAttack)){
		audio_play_sound(sndTimeAttack, 1, true);
	}
}
if(global.mode = "MultiPrism"){
	if(!audio_is_playing(sndMultiPrism)){
		audio_play_sound(sndMultiPrism, 1, true);
	}
}
if(global.mode = "Endless"){
	if(!audio_is_playing(sndEndless)){
		audio_play_sound(sndEndless, 1, true);
	}
}

// Store previous position
previous_x = x;
previous_y = y;

// Resets movement direction
move_x = 0;
move_y = 0;

// Checks for input
if (keyboard_check(ord("A"))) {
    move_x = -1;
}
if (keyboard_check(ord("D"))) {
    move_x = 1;
}
if (keyboard_check(ord("W"))) {
    move_y = -1;
}
if (keyboard_check(ord("S"))) {
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
	if (room = rmLevel4){
	var locations = [
    [1500, 1115],
    [1150, 1210],
    [1850, 1455],
    [1850, 675],
    [1150, 865]
	];
	}
	if (room = rmLevel5){
	var locations = [
    [890, 755],
    [1040, 410],
    [890, 410],
    [1040, 755],
    [1265, 660],
    [655, 500]
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
