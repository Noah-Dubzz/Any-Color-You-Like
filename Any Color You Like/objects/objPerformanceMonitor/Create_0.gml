// Performance Monitor Object - Create Event
// Add this to a persistent object or controller

// Performance monitoring variables
fps_history = [];
frame_time_history = [];
memory_usage_history = [];
performance_warning_threshold = 45; // FPS threshold for warnings

// Performance stats
current_fps = 0;
average_fps = 60;
frame_time_ms = 0;
memory_usage_mb = 0;

// Monitoring flags
performance_monitoring_enabled = true;
show_performance_overlay = false;
auto_optimize_enabled = true;

// Performance counters
frame_counter = 0;
check_interval = 60; // Check performance every 60 frames

// Dynamic quality settings
dynamic_trail_quality = 1.0;
dynamic_enemy_frequency = variable_global_exists("enemy_update_frequency") ? global.enemy_update_frequency : 60;
dynamic_audio_quality = 1.0;

// Initialize global performance variables if they don't exist
if (!variable_global_exists("performance_warning_shown")) {
    global.performance_warning_shown = false;
}
if (!variable_global_exists("is_mobile")) {
    global.is_mobile = false;
}