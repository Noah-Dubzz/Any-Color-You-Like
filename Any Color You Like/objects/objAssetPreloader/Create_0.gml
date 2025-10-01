/// Asset Preloader Create Event
// Pre-load all critical game assets for maximum performance

show_debug_message("Asset Preloader: Starting asset pre-loading...");

// Initialize preloading variables
global.assets_preloaded = false;
preload_step = 0;
total_preload_steps = 12; // Number of assets to preload
current_preloading_sprite = -1; // Currently loading sprite

// Background sprites to preload (these are the heaviest assets)
background_sprites = [
    sprGameBackground,    // Level 1
    sprGameBackground2,   // Level 2  
    sprGameBackground3,   // Level 4
    sprGameBackground4,   // Level 5
    sprGameBackground5,   // Level 3
    sprEndlessBackground  // Endless mode (80 frames!)
];

// Other heavy sprites to preload
heavy_sprites = [
    sprPlayer,
    sprPlayer2,
    sprEnemy1,
    sprBlueSpirit,
    sprGreenSpirit,
    sprRedSpirit
];

// Start preloading immediately
alarm[0] = 1; // Trigger first preload step

show_debug_message("Asset Preloader: Initialized, will preload " + string(total_preload_steps) + " assets");