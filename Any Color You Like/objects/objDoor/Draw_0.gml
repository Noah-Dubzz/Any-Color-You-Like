// Draw the global score in the top left corner of the screen
draw_self();
var text = "Score: " + string(global.Score);
draw_text_transformed(10, 10, text, 3, 3, 0);