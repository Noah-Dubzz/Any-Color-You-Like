// Step Event of objTitle

// Fade in the title
if (alpha < 1) {
    alpha += fade_speed; // Increase alpha for fade-in effect
    if (alpha > 1) {
        alpha = 1; // Clamp alpha to 1
    }
}

// Update the color offset to create a flowing effect
color_offset += color_speed;

// Calculate the RGB components using sine function for smooth color flow
var red = (sin(color_offset) + 1) / 2;   // Range from 0 to 1
var green = (sin(color_offset + 2) + 1) / 2; // Offset for green
var blue = (sin(color_offset + 4) + 1) / 2; // Offset for blue

// Combine RGB components into a single color
current_color = make_color_rgb(red * 255, green * 255, blue * 255);