if (global.mode == "TimeAttack") {
    instance_destroy(self);
}

// Checks for players nearby
var detection_range = 200; // Range that the enemy can see the players
var player_visible = false;
var target_player = noone; // Track the closest visible player

// Function to check visibility and proximity for a player
function check_player_visibility(player_obj) {
    var is_visible = false;

    // Calculates the direction and distance to the player
    var dir_to_player = point_direction(x, y, player_obj.x, player_obj.y);
    var dist_to_player = point_distance(x, y, player_obj.x, player_obj.y);

    // Checks if the player is in detection range and visible to the enemy
    if (dist_to_player < detection_range) {
        var hit = collision_line(x, y, player_obj.x, player_obj.y, objWall, true, true);
        if (!hit) {
            is_visible = true;
        }
    }

    return {visible: is_visible, direction: dir_to_player, distance: dist_to_player};
}

// Check visibility for objPlayer
var player1_status = check_player_visibility(objPlayer);
if (player1_status.visible) {
    player_visible = true;
    target_player = objPlayer;
}

// Check visibility for objPlayer2
if (global.mode = "MultiPrism"){
var player2_status = check_player_visibility(objPlayer2);
if (player2_status.visible) {
    // If both players are visible, target the closest one
    if (!player_visible || player2_status.distance < player1_status.distance) {
        player_visible = true;
        target_player = objPlayer2;
    }
}
}

if (player_visible && global.nochasing == false) {
    // Start chasing the target player if not already chasing
    if (!chasing) {
        chasing = true;
        chase_timer = chase_duration; // Resets the chase timer
    }
}

if (chasing && global.nochasing == false) {
    if (target_player != noone) {
        // Moves towards the closest visible player
        var dir_to_target = point_direction(x, y, target_player.x, target_player.y);
        direction = dir_to_target;
    }
    
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

// Clamp position within maze boundaries
x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);

