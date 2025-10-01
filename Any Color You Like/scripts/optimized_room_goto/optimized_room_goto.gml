/// Optimized Room Transition Function
/// Use this instead of room_goto for better performance

function optimized_room_goto(target_room) {
    // Pre-optimize memory for target room
    optimize_memory_for_level(target_room);
    
    // Add small delay to let optimization complete
    show_debug_message("Transitioning to " + room_get_name(target_room) + " with memory optimization");
    
    // Perform the actual room transition
    room_goto(target_room);
}

// Legacy wrapper for existing code
function goto_room_optimized(target_room) {
    optimized_room_goto(target_room);
}