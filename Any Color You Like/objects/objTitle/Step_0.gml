// Step Event of objTitle

// Initialize delta time for UI animations
if (!variable_global_exists("delta_multiplier")) {
    global.delta_multiplier = 1.0;
} else {
    var dt_seconds = delta_time / 1000000;
    var target_frame_time = 1.0 / 60.0;
    global.delta_multiplier = dt_seconds / target_frame_time;
    global.delta_multiplier = clamp(global.delta_multiplier, 0.1, 3.0);
}

// Fade in the title with delta time
if (alpha < 1) {
    alpha += fade_speed * global.delta_multiplier; // Delta time adjusted fade
    if (alpha > 1) {
        alpha = 1; // Clamp alpha to 1
    }
}

// Update the color offset to create a flowing effect with delta time
color_offset += color_speed * global.delta_multiplier;

// Calculate the RGB components using sine function for smooth color flow
var red = (sin(color_offset) + 1) / 2;   // Range from 0 to 1
var green = (sin(color_offset + 2) + 1) / 2; // Offset for green
var blue = (sin(color_offset + 4) + 1) / 2; // Offset for blue

// Combine RGB components into a single color
current_color = make_color_rgb(red * 255, green * 255, blue * 255);