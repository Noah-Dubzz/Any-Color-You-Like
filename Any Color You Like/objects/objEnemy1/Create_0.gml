// sets movement speed of the enemy (KEEP LOW)
global.enemyspeed = 2;

// Timer for chasing player
chase_duration = 5 * room_speed; // Chases player for 5 seconds
chase_timer = 5;

// Sets enemy to wandering state
chasing = false;

// Sets random movement
direction = random(360); // Initial random direction

depth = -10;