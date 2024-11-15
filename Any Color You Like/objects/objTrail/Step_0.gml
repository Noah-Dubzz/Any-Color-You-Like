// Makes sure the enemy stays within the room/maze boundaries
var maze_left = 580;
var maze_right = 1330;
var maze_top = 100;
var maze_bottom = 930;

x = clamp(x, maze_left + sprite_width / 2, maze_right - sprite_width / 2);
y = clamp(y, maze_top + sprite_height / 2, maze_bottom - sprite_height / 2);