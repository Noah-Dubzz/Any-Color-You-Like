// Randomize the random number generator (if not already done)
randomize();

// Set a low initial speed
global.ballspeed = 2;

// Give a random direction
direction = random(360);

// Set a random starting velocity (dx and dy) based on the direction
hsp = lengthdir_x(global.ballspeed, direction); // Horizontal speed component
vsp = lengthdir_y(global.ballspeed, direction); // Vertical speed component