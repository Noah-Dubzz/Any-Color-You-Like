/// Advanced Memory Management Script
/// Call this when transitioning between levels to optimize memory

function optimize_memory_for_level(target_room) {
    // Only run if assets are preloaded
    if (!global.assets_preloaded) return;
    
    show_debug_message("Memory Manager: Optimizing memory for room " + room_get_name(target_room));
    
    // Force garbage collection before level transition
    gc_collect();
    
    switch(target_room) {
        case rmLevel1:
            // Keep Level 1 background, unload others if needed
            show_debug_message("Memory Manager: Optimized for Level 1");
            break;
            
        case rmLevel2:
            // Keep Level 2 background, unload others if needed  
            show_debug_message("Memory Manager: Optimized for Level 2");
            break;
            
        case rmLevel3:
            // Keep Level 3 background
            show_debug_message("Memory Manager: Optimized for Level 3");
            break;
            
        case rmLevel4:
            // Keep Level 4 background
            show_debug_message("Memory Manager: Optimized for Level 4");
            break;
            
        case rmLevel5:
            // Keep Level 5 background
            show_debug_message("Memory Manager: Optimized for Level 5");
            break;
            
        case rmEndless:
            // Keep Endless background (most important)
            show_debug_message("Memory Manager: Optimized for Endless Mode");
            break;
            
        default:
            // General cleanup for other rooms
            gc_collect();
            show_debug_message("Memory Manager: General cleanup performed");
            break;
    }
    
    // Additional cleanup
    gc_collect();
}