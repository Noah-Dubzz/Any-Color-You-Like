/// @description Insert description here
// You can write your code in this editor
// Performance Monitor Object - Step Event

if (!performance_monitoring_enabled) exit;

frame_counter++;

// Check performance every check_interval frames
if (frame_counter >= check_interval) {
    frame_counter = 0;
    
    // Get current performance metrics
    current_fps = fps;
    frame_time_ms = delta_time / 1000; // Use delta_time for accurate frame timing
    
    // Ensure arrays are initialized
    if (!is_array(fps_history)) fps_history = [];
    
    // Store in history (keep last 10 samples)
    array_push(fps_history, current_fps);
    if (array_length(fps_history) > 10) {
        array_delete(fps_history, 0, 1);
    }
    
    // Calculate average FPS
    var fps_total = 0;
    var history_length = array_length(fps_history);
    if (history_length > 0) {
        for (var i = 0; i < history_length; i++) {
            fps_total += fps_history[i];
        }
        average_fps = fps_total / history_length;
    } else {
        average_fps = current_fps;
    }
    
    // Auto-optimization system
    if (auto_optimize_enabled) {
        if (average_fps < performance_warning_threshold) {
            // Performance is poor - reduce quality
            if (dynamic_trail_quality > 0.5) {
                dynamic_trail_quality = max(0.5, dynamic_trail_quality - 0.1);
                show_debug_message("Performance: Reducing trail quality to " + string(dynamic_trail_quality));
            }
            
            if (dynamic_enemy_frequency < 30) {
                dynamic_enemy_frequency = min(30, dynamic_enemy_frequency + 5);
                show_debug_message("Performance: Reducing enemy update frequency to " + string(dynamic_enemy_frequency));
            }
            
            // Reduce audio quality on mobile
            if (global.is_mobile && dynamic_audio_quality > 0.5) {
                dynamic_audio_quality = max(0.5, dynamic_audio_quality - 0.1);
                audio_master_gain(dynamic_audio_quality);
            }
        } else if (average_fps > 55) {
            // Performance is good - can increase quality
            if (dynamic_trail_quality < 1.0) {
                dynamic_trail_quality = min(1.0, dynamic_trail_quality + 0.05);
            }
            
            if (variable_global_exists("enemy_update_frequency") && dynamic_enemy_frequency > global.enemy_update_frequency) {
                dynamic_enemy_frequency = max(global.enemy_update_frequency, dynamic_enemy_frequency - 1);
            }
            
            if (dynamic_audio_quality < 1.0) {
                dynamic_audio_quality = min(1.0, dynamic_audio_quality + 0.05);
                audio_master_gain(dynamic_audio_quality);
            }
        }
    }
    
    // Performance warning
    if (!variable_global_exists("performance_warning_shown")) global.performance_warning_shown = false;
    if (average_fps < 25 && !global.performance_warning_shown) {
        global.performance_warning_shown = true;
        show_debug_message("Warning: Low performance detected. Average FPS: " + string(average_fps));
    }
}

// Debug key to toggle performance overlay (F3)
if (keyboard_check_pressed(vk_f3)) {
    show_performance_overlay = !show_performance_overlay;
}