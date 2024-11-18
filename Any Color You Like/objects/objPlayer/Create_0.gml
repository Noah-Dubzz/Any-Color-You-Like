if (global.mode = "TimeAttack"){
	global.boosted_move_speed = 20;
	global.move_speed = 14;
}
// Sets movement speed
global.move_speed = 7;

global.nochasing = false;
global.respawning = false; // Indicates whether we're waiting for the cooldown

// Initialize the speed boost duration
global.speed_boost_duration = 5; // Duration in frames (2 seconds at 60 FPS)
global.original_move_speed = 7; // Original move speed
global.boosted_move_speed = 12; // Boosted move speed
global.is_boosted = false; // Flag to check if the speed boost is active

global.nochasing = false;

trail_length = 10; // Length of the trail
trail = []; // Array to hold trail positions

// Initialize ghost variable
ghost = false; // This variable will control ghost mode

// Sets dash speed and duration
dash_speed = 20;
dash_duration = 7; // How many steps the dash is

// Sets dash cooldown
dash_cooldown = 3 * room_speed;
dash_timer = 0; // Keeps track of cooldown
dash_active = false; // Variable of if player is dashing

// Movement Directions
move_x = 0;
move_y = 0;

// Store previous position for collision junk
previous_x = x;
previous_y = y;

camera_target_x = x;
camera_target_y = y;
camera_smooth_speed = 0.1; // Adjust for smoother or faster following


