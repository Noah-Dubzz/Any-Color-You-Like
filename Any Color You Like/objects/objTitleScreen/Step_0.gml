// Step Event of objTitleScreen

// Enhanced frame pacing for ultra-smooth 144 FPS gameplay
if (!variable_global_exists("frame_pacing_initialized")) {
    global.frame_pacing_initialized = true;
    global.target_fps = 144;
    global.last_frame_time = get_timer();
    global.frame_delta_history = [16667, 16667, 16667, 16667, 16667]; // ~60 FPS baseline in microseconds
    show_debug_message("Frame Pacing System: Initialized for ultra-smooth gameplay");
}

// Calculate smoothed frame timing
var current_timer = get_timer();
var frame_delta = current_timer - global.last_frame_time;
global.last_frame_time = current_timer;

// Update and smooth frame delta history
array_delete(global.frame_delta_history, 0, 1);
array_push(global.frame_delta_history, frame_delta);

var smooth_frame_delta = 0;
for (var i = 0; i < 5; i++) {
    smooth_frame_delta += global.frame_delta_history[i];
}
smooth_frame_delta /= 5;

// Update global delta multiplier for all objects - maintain 60 FPS equivalent speeds
global.delta_multiplier = smooth_frame_delta / (1000000 / 60); // 60 FPS baseline for consistent speeds
global.delta_multiplier = clamp(global.delta_multiplier, 0.1, 2.5);

// Delta time adjusted fade in the logo
if (alpha < 1) {
    alpha += 0.01 * global.delta_multiplier; // Delta time adjusted fade
    if (alpha > 1) {
        alpha = 1; // Clamp alpha to 1
    }
}

// Only start the animation if the logo is fully visible
if (alpha >= isAnimating) {
    // Play the animation of sprLogo once
    if (image_index < 50) {
        image_index += 1; // Move to the next frame
    } 
        // Change to the still sprite after the animation
        sprite_index = sprLogoAnimationStill; // Switch to the static logo sprite
}

