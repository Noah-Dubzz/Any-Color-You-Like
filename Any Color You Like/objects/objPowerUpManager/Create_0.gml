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
var random_power_up = choose(objSlowPowerUp, objSpeedPowerUp);
var power_up_instance = generate_power_up(random_power_up);