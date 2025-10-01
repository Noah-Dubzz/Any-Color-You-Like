// Initialize delta time system for frame-rate independence (Player 2)
if (!variable_global_exists("delta_multiplier")) {
    global.delta_multiplier = 1.0;
    global.target_fps = 144;
}

if (global.timer < 0 && global.mode == "TimeAttack") {
    // Let Player 1 handle audio management
    room_goto(rmTimeAttack);
}

if (global.mode == "TimeAttack") {
    global.p2boosted_move_speed = 20;
    global.p2move_speed = 14;
}

// Simple, stable camera smoothing for Player 2 at 144 FPS
if (!variable_instance_exists(id, "p2_camera_target_x")) {
    p2_camera_target_x = x;
    p2_camera_target_y = y;
}

// Simple frame-rate independent smoothing (matching Player 1)
var p2_smooth_speed = 0.1; // Base smoothing speed
var p2_frame_adjusted_smooth = p2_smooth_speed * global.delta_multiplier;
p2_frame_adjusted_smooth = clamp(p2_frame_adjusted_smooth, 0.02, 0.3); // Keep it reasonable

p2_camera_target_x = lerp(p2_camera_target_x, x, p2_frame_adjusted_smooth);
p2_camera_target_y = lerp(p2_camera_target_y, y, p2_frame_adjusted_smooth);

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
camera_set_view_pos(camera, p2_camera_target_x - cam_width / 2, p2_camera_target_y - cam_height / 2);

// Store previous position
p2previous_x = x;
p2previous_y = y;

// Reset movement direction
p2move_x = 0;
p2move_y = 0;

// Keyboard input for movement
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

// Check for controller connection for Player 2
if (!gamepad_is_connected(1)) {
    // Try to find a second controller or use controller 0
    for (var i = 0; i < 12; i++) {
        if (gamepad_is_connected(i) && i != 0) {
            gamepad_set_axis_deadzone(i, 0.2);
            break;
        }
    }
}

// Joystick input for movement (Player 2 uses controller 1)
var joy_x = gamepad_axis_value(1, gp_axislh); // Left stick horizontal axis
var joy_y = gamepad_axis_value(1, gp_axislv); // Left stick vertical axis

// D-pad support for Player 2
if (gamepad_button_check(1, gp_padl)) {
    joy_x = -1;
}
if (gamepad_button_check(1, gp_padr)) {
    joy_x = 1;
}
if (gamepad_button_check(1, gp_padu)) {
    joy_y = -1;
}
if (gamepad_button_check(1, gp_padd)) {
    joy_y = 1;
}

if (abs(joy_x) > 0.2) { // Deadzone check for X-axis
    p2move_x = joy_x;
}
if (abs(joy_y) > 0.2) { // Deadzone check for Y-axis
    p2move_y = joy_y;
}

// Normalize diagonal movement to maintain consistent speed
if (p2move_x != 0 && p2move_y != 0) {
    var normalize_factor = 0.7071; // 1 / sqrt(2)
    p2move_x *= normalize_factor;
    p2move_y *= normalize_factor;
}

// Check for dash input (keyboard or joystick) - Player 2 uses controller 1
if ((keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("M")) || gamepad_button_check_pressed(1, gp_face1)) && p2dash_timer == 0) {
    p2dash_active = true;
    p2dash_timer = p2dash_cooldown; // Starts cooldown timer
    p2dash_steps = p2dash_duration; // Sets the dash duration
    audio_play_sound(sndDash, 1, false);
    // Add rumble feedback for dash
    if (gamepad_is_connected(1)) {
        gamepad_set_vibration(1, 0.3, 0.3);
        alarm[0] = max(1, 10 / global.delta_multiplier); // Stop rumble after 10 frames (delta adjusted)
    }
} else if ((keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("M")) || gamepad_button_check_pressed(1, gp_face1)) && p2dash_timer > 1) {
    audio_play_sound(sndCoolDown, 1, false);
}

// Fixed delta time calculation for Player 2 - maintain 60 FPS equivalent speeds
var dt_seconds = delta_time / 1000000;
var target_frame_time = 1.0 / 60.0; // 60 FPS baseline to maintain original game speed

// Smooth delta time for Player 2
if (!variable_instance_exists(id, "p2_delta_history")) {
    p2_delta_history = [dt_seconds, dt_seconds, dt_seconds];
    p2_smooth_delta = dt_seconds;
}

array_delete(p2_delta_history, 0, 1);
array_push(p2_delta_history, dt_seconds);
p2_smooth_delta = (p2_delta_history[0] + p2_delta_history[1] + p2_delta_history[2]) / 3;

global.delta_multiplier = p2_smooth_delta / target_frame_time;
global.delta_multiplier = clamp(global.delta_multiplier, 0.5, 2.0);

// Dash handling - Now with delta time support
var p2move_x_speed, p2move_y_speed;
if (p2dash_active) {
    p2move_x_speed = (p2dash_speed * global.delta_multiplier) * p2move_x;
    p2move_y_speed = (p2dash_speed * global.delta_multiplier) * p2move_y;
    p2dash_steps -= global.delta_multiplier;
    if (p2dash_steps <= 0) {
        p2dash_active = false; // End the dash after a few steps
    }
} else {
    p2move_x_speed = (global.p2move_speed * global.delta_multiplier) * p2move_x;
    p2move_y_speed = (global.p2move_speed * global.delta_multiplier) * p2move_y;
}

// Save the previous position for collision handling
p2previous_x = x;
p2previous_y = y;

// Enhanced Player 2 movement with smoothing
if (!variable_instance_exists(id, "p2_precise_x")) {
    p2_precise_x = x;
    p2_precise_y = y;
    p2_velocity_x = 0;
    p2_velocity_y = 0;
}

// Smooth velocity interpolation for Player 2
var p2_target_vel_x = p2move_x_speed;
var p2_target_vel_y = p2move_y_speed;
var p2_smoothing_factor = 0.25; // Fixed smoothing factor, not delta dependent

p2_velocity_x = lerp(p2_velocity_x, p2_target_vel_x, p2_smoothing_factor);
p2_velocity_y = lerp(p2_velocity_y, p2_target_vel_y, p2_smoothing_factor);

p2_precise_x += p2_velocity_x;
p2_precise_y += p2_velocity_y;

// Handle movement and collision
if (!p2ghost) {
    // Enhanced collision detection with wall sliding for Player 2
    var p2_test_x = p2_precise_x;
    var p2_test_y = p2_precise_y;
    var p2_slide_threshold = 3; // Pixels to try sliding when blocked
    
    // Try full movement first
    if (!place_meeting(p2_test_x, p2_test_y, objWall) && !place_meeting(p2_test_x, p2_test_y, objWallEnd)) {
        x = p2_test_x;
        y = p2_test_y;
    } else {
        // If blocked, try horizontal movement only (slide along vertical walls)
        if (!place_meeting(p2_test_x, y, objWall) && !place_meeting(p2_test_x, y, objWallEnd)) {
            x = p2_test_x;
            p2_precise_y = y; // Reset vertical position
            p2_velocity_y *= 0.5; // Reduce but don't stop vertical velocity for smoother feel
        }
        // Try vertical movement only (slide along horizontal walls)  
        else if (!place_meeting(x, p2_test_y, objWall) && !place_meeting(x, p2_test_y, objWallEnd)) {
            y = p2_test_y;
            p2_precise_x = x; // Reset horizontal position
            p2_velocity_x *= 0.5; // Reduce but don't stop horizontal velocity for smoother feel
        }
        // If completely blocked, try micro-sliding to escape tiny collision pieces
        else {
            var p2_found_slide = false;
            
            // Try sliding horizontally with small offsets
            for (var p2_slide_x = 1; p2_slide_x <= p2_slide_threshold && !p2_found_slide; p2_slide_x++) {
                if (!place_meeting(x + p2_slide_x, p2_test_y, objWall) && !place_meeting(x + p2_slide_x, p2_test_y, objWallEnd)) {
                    x += p2_slide_x;
                    y = p2_test_y;
                    p2_found_slide = true;
                } else if (!place_meeting(x - p2_slide_x, p2_test_y, objWall) && !place_meeting(x - p2_slide_x, p2_test_y, objWallEnd)) {
                    x -= p2_slide_x;
                    y = p2_test_y;
                    p2_found_slide = true;
                }
            }
            
            // Try sliding vertically with small offsets
            if (!p2_found_slide) {
                for (var p2_slide_y = 1; p2_slide_y <= p2_slide_threshold && !p2_found_slide; p2_slide_y++) {
                    if (!place_meeting(p2_test_x, y + p2_slide_y, objWall) && !place_meeting(p2_test_x, y + p2_slide_y, objWallEnd)) {
                        x = p2_test_x;
                        y += p2_slide_y;
                        p2_found_slide = true;
                    } else if (!place_meeting(p2_test_x, y - p2_slide_y, objWall) && !place_meeting(p2_test_x, y - p2_slide_y, objWallEnd)) {
                        x = p2_test_x;
                        y -= p2_slide_y;
                        p2_found_slide = true;
                    }
                }
            }
            
            // If no sliding worked, stop movement but keep some velocity for next frame
            if (!p2_found_slide) {
                p2_precise_x = x;
                p2_precise_y = y;
                p2_velocity_x *= 0.3; // Keep some momentum instead of full stop
                p2_velocity_y *= 0.3;
            }
        }
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
	
// Handle wall collision after ghost mode - only when not in ghost mode
    var closest_distance = -1;
    var closest_location = [x, y]; // Default to current position

    if (!p2ghost && (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd))) {
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
    // Ghost mode: move freely with smooth interpolation
    x = p2_precise_x;
    y = p2_precise_y;
}

// Cooldown timer
if (p2dash_timer > 0) {
    p2dash_timer -= global.delta_multiplier;
    if (p2dash_timer < 0) p2dash_timer = 0; // Prevent negative values
}

// Optimized trail system using circular array with safety checks
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

// Trail update moved to end of step event (after all movement and collision logic)

if (global.p2lives <= 0){
	room_goto(rmMultiPrism);
	global.winner = 1;
	// Let Player 1 handle audio management
}
// Clamp the player's position within the maze bounds
x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);

// Update trail only when Player 2 position actually changes (fixes out-of-bounds trail issue)
if (!variable_instance_exists(id, "p2_last_trail_x")) {
    p2_last_trail_x = x;
    p2_last_trail_y = y;
}

// Only update trail if Player 2 moved significantly  
var p2_move_distance = point_distance(x, y, p2_last_trail_x, p2_last_trail_y);
if (p2_move_distance > 1) { // Only update if moved more than 1 pixel
    // Ensure trail position is also clamped (prevents any out-of-bounds trail segments)
    var p2_clamped_trail_x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
    var p2_clamped_trail_y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
    
    trail[trail_index] = [p2_clamped_trail_x, p2_clamped_trail_y];
    trail_index = (trail_index + 1) % trail_length;
    p2_last_trail_x = p2_clamped_trail_x;
    p2_last_trail_y = p2_clamped_trail_y;
} else {
    // When Player 2 isn't moving, gradually update trail to current position (removes stationary trail tail)
    var p2_clamped_current_x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
    var p2_clamped_current_y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
    
    // Update one trail segment per frame to current position for smooth fade-in effect
    trail[trail_index] = [p2_clamped_current_x, p2_clamped_current_y]; 
    trail_index = (trail_index + 1) % trail_length;
}