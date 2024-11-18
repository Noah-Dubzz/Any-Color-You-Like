// Player collects Color Spirits
global.red_collected = false;
global.green_collected = false;
global.blue_collected = false;

// Call this at the start of the game, once
randomize();

// Create a global variable for DoorColor with a random RGB color
global.DoorColor = make_color_rgb(irandom_range(0, 255), irandom_range(0, 255), irandom_range(0, 255));


// Extract the RGB values from the DoorColor
global.RedVal = color_get_red(global.DoorColor);
global.GreenVal = color_get_green(global.DoorColor);
global.BlueVal = color_get_blue(global.DoorColor);

// Create Event of objSpiritManager

// Function to generate a spirit at a random position
function generate_spirit(spirit_type) {
    var spirit_instance;
    var is_touching = true;

    while (is_touching) {
        // Call this once, at the start of your game or in the object's Create event
randomize();

// Generate a random position within the room
var spawn_x = random(room_width);
var spawn_y = random(room_height);

// Clamp the position to ensure it stays within the maze boundaries
spawn_x = clamp(spawn_x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
spawn_y = clamp(spawn_y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);


        // Create the spirit instance
        spirit_instance = instance_create_layer(spawn_x, spawn_y, "ColorSpirits", spirit_type);
        
        // Check if the spirit is touching any object
        is_touching = false;
        if (place_meeting(spawn_x, spawn_y, other)) {
            is_touching = true;
        } else {
            return spirit_instance;  // Return the created instance if not touching
        }
        
        // If touching, destroy the instance and try again
        instance_destroy(spirit_instance);
    }
}

// Generate one instance of each spirit
var red_spirit = generate_spirit(objRedSpirit);
var blue_spirit = generate_spirit(objBlueSpirit);
var green_spirit = generate_spirit(objGreenSpirit);
