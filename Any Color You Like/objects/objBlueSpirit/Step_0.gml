// Get the object's half-width and half-height to calculate edge positions
var half_width = sprite_width / 2;
var half_height = sprite_height / 2;

// Predict the object's next position based on velocity
var next_x = x + hsp;
var next_y = y + vsp;

// Check if the object will hit the left or right edge of the maze (before moving)
if (next_x - half_width <= global.maze_left || next_x + half_width >= global.maze_right) {
    // Assign a new random direction between 0 and 360 degrees
    direction = random(360);
    
    // Update horizontal and vertical speed based on the new random direction
    hsp = lengthdir_x(global.ballspeed, direction);
    vsp = lengthdir_y(global.ballspeed, direction);

    // Correct position to prevent it from going out of bounds
    if (next_x - half_width <= global.maze_left) {
        x = global.maze_left + half_width;
    } else if (next_x + half_width >= global.maze_right) {
        x = global.maze_right - half_width;
    }
}

// Check if the object will hit the top or bottom edge of the maze (before moving)
if (next_y - half_height <= global.maze_top || next_y + half_height >= global.maze_bottom) {
    // Assign a new random direction between 0 and 360 degrees
    direction = random(360);
    
    // Update horizontal and vertical speed based on the new random direction
    hsp = lengthdir_x(global.ballspeed, direction);
    vsp = lengthdir_y(global.ballspeed, direction);

    // Correct position to prevent it from going out of bounds
    if (next_y - half_height <= global.maze_top) {
        y = global.maze_top + half_height;
    } else if (next_y + half_height >= global.maze_bottom) {
        y = global.maze_bottom - half_height;
    }
}

// Now update position based on adjusted velocity
x += hsp;
y += vsp;
