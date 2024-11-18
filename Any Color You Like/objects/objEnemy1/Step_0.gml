if (global.mode = "TimeAttack"){
	instance_destroy(self);
}

// Checks for player nearby
var detection_range = 200; // Range that the enemy can see the player
var player_visible = false;

// Calculates the direction and distance to player
var dir_to_player = point_direction(x, y, objPlayer.x, objPlayer.y);
var dist_to_player = point_distance(x, y, objPlayer.x, objPlayer.y);

// Checks if the player is in detection range and visible to the enemy
if (dist_to_player < detection_range) {
    // This is what checks if the player is in the enemy's line of sight
    var hit = collision_line(x, y, objPlayer.x, objPlayer.y, objWall, true, true);
    if (!hit) {
        player_visible = true;
    }
}



if (player_visible && global.nochasing == false) {
    // Start chasing the player if it's not already chasing them
    if (!chasing) {
        chasing = true;
        chase_timer = chase_duration; // Resets the chase timer
    }
}

if (chasing && global.nochasing == false) {
    // Moves towards the player once detected
    direction = dir_to_player;
    
    if (!audio_is_playing(sndChasing)) { // Check if sndChasing is not currently playing
        audio_play_sound(sndChasing, 100, true); // Play the sound
    }
    
    global.enemyspeed = 4; // Faster speed while chasing the player

    // Calculates movement for enemy
    var move_x = lengthdir_x(global.enemyspeed, direction);
    var move_y = lengthdir_y(global.enemyspeed, direction);
    
    // Moves the enemy and controls its collisions
    if (!place_meeting(x + move_x, y, objWall) && !place_meeting(x, y + move_y, objWall)) {
        x += move_x;
        y += move_y;
    } else {
        // Stops chasing if it bumps into a wall
        chasing = false;
        global.enemyspeed = 2; // Resets speed after the end of the chase
    }

    // Stop chasing sound if no longer chasing
    if (chasing == false) {
        audio_stop_sound(sndChasing);
    }
    
    // Decrements chase timer
    chase_timer -= 1;
    if (chase_timer <= 0) {
        chasing = false;
        global.enemyspeed = 2; // Resets speed after chase
    }
} else {
    // Moves straight line until wall or object
    var move_x = lengthdir_x(global.enemyspeed, direction);
    var move_y = lengthdir_y(global.enemyspeed, direction);
    
    // Checks for collisions
    if (place_meeting(x + move_x, y, objWall) || place_meeting(x, y + move_y, objWall)) {
        // Changes direction if a wall is encountered
        direction = random(360); // Changes direction when it hits a wall
    } else {
        // Continues moving in the current direction
        x += move_x;
        y += move_y;
    }
}

x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
