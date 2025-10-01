/// Asset Preloader Step Event
// Monitor preloading progress and optimize memory usage

// Force garbage collection periodically to keep memory clean
if (preload_step > 0 && preload_step % 4 == 0) {
    gc_collect(); // Clean up unused memory during preloading
}

// Optional: Display preload progress (for debugging)
if (!global.assets_preloaded) {
    var progress_percent = (preload_step / total_preload_steps) * 100;
    // Could display loading bar here if needed
} else {
    // After preloading is complete, monitor performance
    // Run additional optimizations if needed
    if (global.assets_preloaded && instance_number(objAssetPreloader) > 0) {
        // Persistent performance monitoring could go here
        // For now, just ensure garbage collection happens regularly
        if (current_time % 10000 < 16) { // Every ~10 seconds
            gc_collect();
        }
    }
}