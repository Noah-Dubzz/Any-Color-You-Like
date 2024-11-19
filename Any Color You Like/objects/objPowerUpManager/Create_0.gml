// Player collects Power-Ups
global.powerUpCollected = false;

// Call this at the start of the game, once
randomize();

// Create Event of objPowerUpManager

// Define possible positions for the power-ups
if (room = rmLevel1){

power_up_positions = [
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

power_up_positions = [
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

power_up_positions = [
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

power_up_positions = [
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

// Function to generate a power-up at a random position from the predefined locations
function generate_power_up(power_up_type) {
    var power_up_instance;
    var is_touching = true;

    while (is_touching) {
        // Pick a random position from the predefined locations
        var random_index = irandom(array_length(power_up_positions) - 1);
        var spawn_x = power_up_positions[random_index][0];
        var spawn_y = power_up_positions[random_index][1];

        // Create the power-up instance
        power_up_instance = instance_create_layer(spawn_x, spawn_y, "PowerUps", power_up_type);
        
        // Check if the power-up is touching any object
        is_touching = false;
        if (place_meeting(spawn_x, spawn_y, other)) {
            is_touching = true;
        } else {
            return power_up_instance;  // Return the created instance if not touching
        }
        
        // If touching, destroy the instance and try again
        instance_destroy(power_up_instance);
    }
}

// Generate either objSpeedPowerUp or objSlowPowerUp randomly
if (global.mode = "Classic"){
var random_power_up = choose(objSlowPowerUp, objSpeedPowerUp);
}
// Generate either objSpeedPowerUp or objSlowPowerUp randomly
if (global.mode = "Endless"){
var random_power_up = choose(objSlowPowerUp, objSpeedPowerUp);
}
if (global.mode = "TimeAttack"){
var random_power_up = choose(objSpeedPowerUp, objSpeedPowerUp);
}
var power_up_instance = generate_power_up(random_power_up);