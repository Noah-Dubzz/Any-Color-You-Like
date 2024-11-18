x = clamp(x, global.maze_left + sprite_width / 2, global.maze_right - sprite_width / 2);
y = clamp(y, global.maze_top + sprite_height / 2, global.maze_bottom - sprite_height / 2);
 if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        // If collision is detected, move the player back
        x = previous_x;
    }
if (place_meeting(x, y, objWall) || place_meeting(x, y, objWallEnd)) {
        // If collision is detected, move the player back
        y = previous_y;
    }