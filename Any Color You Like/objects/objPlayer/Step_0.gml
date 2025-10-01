// Initialize delta time system for frame-rate independence
if (!variable_global_exists("delta_multiplier")) {
    global.delta_multiplier = 1.0;
    global.target_fps = 144;
}

// Check for controller connection
if (!gamepad_is_connected(0)) {
    // Try to detect any connected gamepad
    for (var i = 0; i < 12; i++) {
        if (gamepad_is_connected(i)) {
            // Set deadzone for better control
            gamepad_set_axis_deadzone(i, 0.2);
            break;
        }
    }
}
// Initialize optimized trail system using circular array
if (!variable_instance_exists(id, "trail_index")) {
    trail_index = 0;
    // Apply platform-based trail length adjustment safely
    if (variable_global_exists("trail_length_modifier")) {
        trail_length = max(5, floor(trail_length * global.trail_length_modifier));
    }
    // Pre-allocate trail array for better performance
    for (var i = 0; i < trail_length; i++) {
        trail[i] = [x, y];
    }
}

// Trail will be updated after movement - moved to prevent out-of-bounds trail

if (keyboard_check(vk_escape) || gamepad_button_check_pressed(0, gp_start)) {
	room_goto(rmModeSelect);
	global.mode = "Choosing";
	var camera = view_camera[0];
	global.Score = 0;
	global.lives = 0;
}

if (global.timer < 0 && global.mode == "TimeAttack"){
	audio_stop_all();
	room_goto(rmTimeAttack);
}

if (global.mode == "TimeAttack"){
	global.boosted_move_speed = 20;
	global.move_speed = 14;
}

// Target the player's position
// Enhanced camera smoothing with prediction and interpolation
if (!variable_instance_exists(id, "camera_velocity_x")) {
    camera_velocity_x = 0;
    camera_velocity_y = 0;
    last_player_x = x;
    last_player_y = y;
}

// Simple, stable camera smoothing for 144 FPS
if (!variable_instance_exists(id, "camera_target_x")) {
    camera_target_x = x;
    camera_target_y = y;
}

// Simple frame-rate independent smoothing
var smooth_speed = 0.1; // Base smoothing speed
var frame_adjusted_smooth = smooth_speed * global.delta_multiplier;
frame_adjusted_smooth = clamp(frame_adjusted_smooth, 0.02, 0.3); // Keep it reasonable

camera_target_x = lerp(camera_target_x, x, frame_adjusted_smooth);
camera_target_y = lerp(camera_target_y, y, frame_adjusted_smooth);

// Update last position for next frame
last_player_x = x;
last_player_y = y;

// Get the active camera
if (global.mode == "Classic" || global.mode == "Endless" || global.mode == "TimeAttack"){
view_visible[0] = true;
view_visible[1] = false;
view_visible[2] = false;
var camera = view_camera[0];
}
if (global.mode == "MultiPrism"){
view_visible[0] = false;
view_visible[1] = true;
view_visible[2] = true;
var camera = view_camera[1];
}

// Center the camera on the smoothed target
var cam_width = camera_get_view_width(camera);
var cam_height = camera_get_view_height(camera);
camera_set_view_pos(camera, camera_target_x - cam_width / 2, camera_target_y - cam_height / 2);
// Smart audio management - only change music when the song needs to change
if (!variable_global_exists("current_audio_track")) {
    global.current_audio_track = "";
    global.debug_step = 0; // Debug counter
}

// Determine what music should be playing
var target_music = "";
if (global.mode == "Classic") {
    switch(room) {
        case rmLevel1: target_music = "sndLevel1"; break;
        case rmLevel2: target_music = "sndLevel2"; break;
        case rmLevel3: target_music = "sndLevel3"; break;
        case rmLevel4: target_music = "sndLevel4"; break;
        case rmLevel5: target_music = "sndLevel5"; break;
    }
} else if (global.mode == "TimeAttack") {
    target_music = "sndTimeAttack";
} else if (global.mode == "MultiPrism") {
    target_music = "sndMultiPrism";
} else if (global.mode == "Endless") {
    target_music = "sndEndless";
}

// Debug: Show current state (only show occasionally to avoid spam)
if (global.debug_step++ % 60 == 0) { // Show once per second
    show_debug_message("Mode: " + string(global.mode) + ", Room: " + string(room_get_name(room)) + ", Target: " + string(target_music) + ", Current: " + string(global.current_audio_track));
}

// Only change music if we need a different track
if (target_music != global.current_audio_track) {
    // Debug: Show when music changes
    show_debug_message("Music changing from '" + string(global.current_audio_track) + "' to '" + string(target_music) + "' in room " + string(room_get_name(room)));
    
    // Stop current music and switch to new track
    audio_stop_all();
    global.current_audio_track = target_music;
    
    // Play the new track
    switch(target_music) {
        case "sndLevel1": audio_play_sound(sndLevel1, 1, true); break;
        case "sndLevel2": audio_play_sound(sndLevel2, 1, true); break;
        case "sndLevel3": audio_play_sound(sndLevel3, 1, true); break;
        case "sndLevel4": audio_play_sound(sndLevel4, 1, true); break;
        case "sndLevel5": audio_play_sound(sndLevel5, 1, true); break;
        case "sndTimeAttack": audio_play_sound(sndTimeAttack, 1, true); break;
        case "sndMultiPrism": audio_play_sound(sndMultiPrism, 1, true); break;
        case "sndEndless": audio_play_sound(sndEndless, 1, true); break;
    }
}

// Store previous position
previous_x = x;
previous_y = y;

// Reset movement direction
move_x = 0;
move_y = 0;

// Keyboard input for movement
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

// Joystick input for movement (assumes joystick 0)
var joy_x = gamepad_axis_value(0, gp_axislh); // Left stick horizontal axis
var joy_y = gamepad_axis_value(0, gp_axislv); // Left stick vertical axis

// D-pad support
if (gamepad_button_check(0, gp_padl)) {
    joy_x = -1;
}
if (gamepad_button_check(0, gp_padr)) {
    joy_x = 1;
}
if (gamepad_button_check(0, gp_padu)) {
    joy_y = -1;
}
if (gamepad_button_check(0, gp_padd)) {
    joy_y = 1;
}

if (abs(joy_x) > 0.2) { // Deadzone check for X-axis
    move_x = joy_x;
}
if (abs(joy_y) > 0.2) { // Deadzone check for Y-axis
    move_y = joy_y;
}

// Normalize diagonal movement to maintain consistent speed
if (move_x != 0 && move_y != 0) {
    var normalize_factor = 0.7071; // 1 / sqrt(2)
    move_x *= normalize_factor;
    move_y *= normalize_factor;
}

// Check for dash input (keyboard or joystick)
if ((keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1)) && dash_timer == 0) {
    dash_active = true;
    dash_timer = dash_cooldown; // Starts cooldown timer
    dash_steps = dash_duration; // Sets the dash duration
    audio_play_sound(sndDash, 1, false);
    // Add rumble feedback for dash
    if (gamepad_is_connected(0)) {
        gamepad_set_vibration(0, 0.3, 0.3);
        alarm[0] = max(1, 10 / global.delta_multiplier); // Stop rumble after 10 frames (delta adjusted)
    }
} else if ((keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1)) && dash_timer > 1) {
    audio_play_sound(sndCoolDown, 1, false);
}

// Fixed delta time calculation - maintain 60 FPS equivalent speeds
var dt_seconds = delta_time / 1000000;
var target_frame_time = 1.0 / 60.0; // 60 FPS baseline to maintain original game speed

// Smooth delta time to reduce micro-stutters  
if (!variable_instance_exists(id, "delta_history")) {
    delta_history = [dt_seconds, dt_seconds, dt_seconds];
    smooth_delta = dt_seconds;
}

// Update delta history for smoothing
array_delete(delta_history, 0, 1);
array_push(delta_history, dt_seconds);

// Calculate smoothed delta time (average of last 3 frames)
smooth_delta = (delta_history[0] + delta_history[1] + delta_history[2]) / 3;

// Calculate multiplier using smoothed delta - keeps original 60 FPS speeds
global.delta_multiplier = smooth_delta / target_frame_time;
global.delta_multiplier = clamp(global.delta_multiplier, 0.5, 2.0); // Tighter clamp for stability

// Dash Junk - Now with delta time support
var move_x_speed, move_y_speed;
if (dash_active) {
    move_x_speed = (dash_speed * global.delta_multiplier) * move_x;
    move_y_speed = (dash_speed * global.delta_multiplier) * move_y;
    dash_steps -= global.delta_multiplier;
    if (dash_steps <= 0) {
        dash_active = false; // End the dash after a few steps (can't let player be OP)
    }
} else {
    move_x_speed = (global.move_speed * global.delta_multiplier) * move_x;
    move_y_speed = (global.move_speed * global.delta_multiplier) * move_y;
}

// Save the previous position for collision handling
previous_x = x;
previous_y = y;

	
// Enhanced movement with sub-pixel precision and smoothing
if (!variable_instance_exists(id, "precise_x")) {
    precise_x = x;
    precise_y = y;
    velocity_x = 0;
    velocity_y = 0;
}

// Smooth velocity interpolation for fluid movement
var target_vel_x = move_x_speed;
var target_vel_y = move_y_speed;
var smoothing_factor = 0.25; // Fixed smoothing factor, not delta dependent

velocity_x = lerp(velocity_x, target_vel_x, smoothing_factor);
velocity_y = lerp(velocity_y, target_vel_y, smoothing_factor);

// Update precise position
precise_x += velocity_x;
precise_y += velocity_y;

if (!ghost) {
    // Enhanced collision detection with wall sliding to prevent getting stuck
    var test_x = precise_x;
    var test_y = precise_y;
    var slide_threshold = 3; // Pixels to try sliding when blocked
    
    // Try full movement first
    if (!place_meeting(test_x, test_y, objWall) && !place_meeting(test_x, test_y, objWallEnd)) {
        x = test_x;
        y = test_y;
    } else {
        // If blocked, try horizontal movement only (slide along vertical walls)
        if (!place_meeting(test_x, y, objWall) && !place_meeting(test_x, y, objWallEnd)) {
            x = test_x;
            precise_y = y; // Reset vertical position
            velocity_y *= 0.5; // Reduce but don't stop vertical velocity for smoother feel
        }
        // Try vertical movement only (slide along horizontal walls)  
        else if (!place_meeting(x, test_y, objWall) && !place_meeting(x, test_y, objWallEnd)) {
            y = test_y;
            precise_x = x; // Reset horizontal position
            velocity_x *= 0.5; // Reduce but don't stop horizontal velocity for smoother feel
        }
        // If completely blocked, try micro-sliding to escape tiny collision pieces
        else {
            var found_slide = false;
            
            // Try sliding horizontally with small offsets
            for (var slide_x = 1; slide_x <= slide_threshold && !found_slide; slide_x++) {
                if (!place_meeting(x + slide_x, test_y, objWall) && !place_meeting(x + slide_x, test_y, objWallEnd)) {
                    x += slide_x;
                    y = test_y;
                    found_slide = true;
                } else if (!place_meeting(x - slide_x, test_y, objWall) && !place_meeting(x - slide_x, test_y, objWallEnd)) {
                    x -= slide_x;
                    y = test_y;
                    found_slide = true;
                }
            }
            
            // Try sliding vertically with small offsets
            if (!found_slide) {
                for (var slide_y = 1; slide_y <= slide_threshold && !found_slide; slide_y++) {
                    if (!place_meeting(test_x, y + slide_y, objWall) && !place_meeting(test_x, y + slide_y, objWallEnd)) {
                        x = test_x;
                        y += slide_y;
                        found_slide = true;
                    } else if (!place_meeting(test_x, y - slide_y, objWall) && !place_meeting(test_x, y - slide_y, objWallEnd)) {
                        x = test_x;
                        y -= slide_y;
                        found_slide = true;
                    }
                }
            }
            
            // If no sliding worked, stop movement but keep some velocity for next frame
            if (!found_slide) {
                precise_x = x;
                precise_y = y;
                velocity_x *= 0.3; // Keep some momentum instead of full stop
                velocity_y *= 0.3;
            }
        }
    }
} else {
    // Ghost mode: move freely with smooth interpolation
    x = precise_x;
    y = precise_y;
}

// Teleportation system - only runs when player is stuck in walls AND not in ghost mode
// This prevents teleporting during power-ups and only rescues players stuck after power-ups expire
if (!ghost && (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd))) {
    var locations = [];
    
    if (room == rmLevel1){
        locations = [
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
    if (room == rmLevel2){
        locations = [
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
    if (room == rmLevel3){
        locations = [
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
    if (room == rmLevel4){
        locations = [
    [1500, 1115],
    [1150, 1210],
    [1850, 1455],
    [1850, 675],
    [1150, 865]
        ];
    }
    if (room == rmLevel5){
        locations = [
    [890, 755],
    [1040, 410],
    [890, 410],
    [1040, 755],
    [1265, 660],
    [655, 500]
        ];
    }
    if (room == rmEndless){
        locations = [
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

// Update trail only when player position actually changes (fixes out-of-bounds trail issue)
if (!variable_instance_exists(id, "last_trail_x")) {
    last_trail_x = x;
    last_trail_y = y;
}

// Trail update moved to after position clamping to prevent out-of-bounds trail

// Cooldown timer
if (dash_timer > 0) {
    dash_timer -= global.delta_multiplier;
    if (dash_timer < 0) dash_timer = 0; // Prevent negative values
}

// Optimized trail system using circular array
// Initialize trail_index in Create event if not exists
if (!variable_instance_exists(id, "trail_index")) {
    trail_index = 0;
}

// Clamp player position within maze bounds FIRST
x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);

// Update trail only after position clamping with clamped trail positions
var player_move_distance = point_distance(x, y, last_trail_x, last_trail_y);
if (player_move_distance > 1) { // Only update if moved more than 1 pixel
    // Ensure trail position is also clamped (prevents any out-of-bounds trail segments)
    var clamped_trail_x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
    var clamped_trail_y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
    
    trail[trail_index] = [clamped_trail_x, clamped_trail_y];
    trail_index = (trail_index + 1) % trail_length;
    last_trail_x = clamped_trail_x;
    last_trail_y = clamped_trail_y;
} else {
    // When player isn't moving, gradually update trail to current position (removes stationary trail tail)
    var clamped_current_x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
    var clamped_current_y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
    
    // Update one trail segment per frame to current position for smooth fade-in effect
    trail[trail_index] = [clamped_current_x, clamped_current_y]; 
    trail_index = (trail_index + 1) % trail_length;
}