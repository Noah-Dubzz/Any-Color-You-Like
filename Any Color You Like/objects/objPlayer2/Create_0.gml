if (global.mode = "TimeAttack"){
	global.p2boosted_move_speed = 20;
	global.p2move_speed = 14;
}
// Sets movement speed
global.p2move_speed = 7;

global.nochasing = false;
global.p2respawning = false; // Indicates whether we're waiting for the cooldown

// Initialize the speed boost duration
global.p2speed_boost_duration = 5; // Duration in frames (2 seconds at 60 FPS)
global.p2original_move_speed = 7; // Original move speed
global.p2boosted_move_speed = 12; // Boosted move speed
global.p2is_boosted = false; // Flag to check if the speed boost is active

global.nochasing = false;

trail_length = 10; // Length of the trail
trail = []; // Array to hold trail positions

// Initialize ghost variable
p2ghost = false; // This variable will control ghost mode

// Sets dash speed and duration
p2dash_speed = 20;
p2dash_duration = 7; // How many steps the dash is

// Sets dash cooldown
p2dash_cooldown = 3 * room_speed;
p2dash_timer = 0; // Keeps track of cooldown
p2dash_active = false; // Variable of if player is dashing

// Movement Directions
p2move_x = 0;
p2move_y = 0;

// Store previous position for collision junk
p2previous_x = x;
p2previous_y = y;

camera_target_x = x;
camera_target_y = y;
camera_smooth_speed = 0.1; // Adjust for smoother or faster following


