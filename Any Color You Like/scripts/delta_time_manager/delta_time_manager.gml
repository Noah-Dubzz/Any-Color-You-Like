/// Delta Time Management Script
/// Provides frame-rate independent timing for 144 FPS gameplay

// Initialize delta time globals if they don't exist
if (!variable_global_exists("delta_multiplier")) {
    global.delta_multiplier = 1.0;
    global.target_fps = 144; // New target FPS
    global.delta_time_factor = 1.0;
}

// Calculate delta time multiplier for consistent gameplay at any framerate
// This ensures movement speeds remain consistent whether at 60, 144, or any other FPS
function calculate_delta_multiplier() {
    // Use delta_time to calculate frame-rate independent multiplier
    // delta_time is in microseconds, so we convert to seconds
    var dt_seconds = delta_time / 1000000;
    
    // Target: 60 FPS baseline (16.67ms per frame)
    var target_frame_time = 1.0 / 60.0;
    
    // Calculate multiplier
    global.delta_multiplier = dt_seconds / target_frame_time;
    
    // Clamp to prevent extreme values during frame drops
    global.delta_multiplier = clamp(global.delta_multiplier, 0.1, 3.0);
    
    return global.delta_multiplier;
}

// Apply delta time to movement values
function apply_delta_to_movement(base_speed) {
    return base_speed * global.delta_multiplier;
}

// Apply delta time to timer values (for alarms and cooldowns)
function apply_delta_to_timer(base_time) {
    // For timers, we need to scale differently since they count down
    return base_time / global.delta_multiplier;
}