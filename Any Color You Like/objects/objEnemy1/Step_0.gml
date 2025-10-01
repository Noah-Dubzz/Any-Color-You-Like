// Initialize delta time system for frame-rate independence (Enemy)
if (!variable_global_exists("delta_multiplier")) {
    global.delta_multiplier = 1.0;
    global.target_fps = 144;
}

if (global.mode == "TimeAttack") {
    instance_destroy(self);
}

// Optimized enemy AI - reduce expensive checks
var detection_range = 200;
var player_visible = false;
var target_player = noone;

// Initialize check timer for performance
if (!variable_instance_exists(id, "visibility_check_timer")) {
    visibility_check_timer = 0;
    cached_player_visible = false;
    cached_target = noone;
}

// Only do expensive visibility checks every 10 frames
if (visibility_check_timer <= 0) {
    visibility_check_timer = 10; // Reset timer
    
    function check_player_visibility_optimized(player_obj) {
        // Fast distance check first
        var dx = player_obj.x - x;
        var dy = player_obj.y - y;
        var dist_squared = dx * dx + dy * dy;
        var detection_squared = detection_range * detection_range;
        
        if (dist_squared < detection_squared) {
            // Only do expensive collision_line if distance check passes
            var hit = collision_line(x, y, player_obj.x, player_obj.y, objWall, true, true);
            if (!hit) {
                return {visible: true, distance: sqrt(dist_squared), target: player_obj};
            }
        }
        return {visible: false, distance: sqrt(dist_squared), target: player_obj};
    }
    
    // Cache results for performance
    var player1_status = check_player_visibility_optimized(objPlayer);
    cached_player_visible = player1_status.visible;
    cached_target = player1_status.target;
    
    if (global.mode == "MultiPrism") {
        var player2_status = check_player_visibility_optimized(objPlayer2);
        if (player2_status.visible) {
            if (!cached_player_visible || player2_status.distance < player1_status.distance) {
                cached_player_visible = true;
                cached_target = player2_status.target;
            }
        }
    }
} else {
    visibility_check_timer -= global.delta_multiplier;
}

// Use cached values
player_visible = cached_player_visible;
target_player = cached_target;

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
        speed = global.enemyspeed * global.delta_multiplier;
    }

    // Continues chasing for a limited time
    chase_timer -= global.delta_multiplier;
    if (chase_timer <= 0) {
        chasing = false;
        target_player = noone;
        chase_timer = 0;
    }
} else {
    // Random wandering behavior (optimized)
    if (!variable_instance_exists(id, "wander_timer")) {
        wander_timer = 0;
    }
    
    if (wander_timer <= 0) {
        direction = random(360); // Change direction every few frames
        wander_timer = 60 + random(60); // Random interval between 1-2 seconds
    } else {
        wander_timer -= global.delta_multiplier;
    }
    
    speed = (global.enemyspeed / 2) * global.delta_multiplier; // Slower when wandering
}

// Optimized boundary checking
x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);

// Bounce off walls (simple collision response)
if (place_meeting(x + lengthdir_x(speed + 1, direction), y + lengthdir_y(speed + 1, direction), objWall)) {
    direction = direction + 180 + random_range(-45, 45); // Bounce with some randomness
}