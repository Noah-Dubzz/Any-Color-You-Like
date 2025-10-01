// Optimized floating animation with safety check
var skip_frames = false;
if (variable_global_exists("is_mobile") && global.is_mobile) {
    skip_frames = (current_time % 2 != 0); // Skip every other frame on mobile
}

if (!skip_frames) {
    y = initial_y + sin(currentshoe_time + float_offset) * float_amplitude;
    currentshoe_time += float_speed;
}


