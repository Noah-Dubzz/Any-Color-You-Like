/// Asset Preloader Alarm 0 - Progressive Asset Loading
// Preload sprites by forcing them into GPU memory

switch(preload_step) {
    case 0:
        // Preload Level 1 background (animated)
        if (sprite_exists(sprGameBackground)) {
            current_preloading_sprite = sprGameBackground;
            show_debug_message("Asset Preloader: Loading Level 1 background (sprGameBackground)");
        }
        break;
        
    case 1:
        // Preload Level 2 background
        if (sprite_exists(sprGameBackground2)) {
            current_preloading_sprite = sprGameBackground2;
            show_debug_message("Asset Preloader: Loading Level 2 background (sprGameBackground2)");
        }
        break;
        
    case 2:
        // Preload Level 3 background  
        if (sprite_exists(sprGameBackground5)) {
            current_preloading_sprite = sprGameBackground5;
            show_debug_message("Asset Preloader: Loading Level 3 background (sprGameBackground5)");
        }
        break;
        
    case 3:
        // Preload Level 4 background
        if (sprite_exists(sprGameBackground3)) {
            current_preloading_sprite = sprGameBackground3;
            show_debug_message("Asset Preloader: Loading Level 4 background (sprGameBackground3)");
        }
        break;
        
    case 4:
        // Preload Level 5 background
        if (sprite_exists(sprGameBackground4)) {
            current_preloading_sprite = sprGameBackground4;
            show_debug_message("Asset Preloader: Loading Level 5 background (sprGameBackground4)");
        }
        break;
        
    case 5:
        // Preload Endless background (CRITICAL - 80 frames)
        if (sprite_exists(sprEndlessBackground)) {
            current_preloading_sprite = sprEndlessBackground;
            show_debug_message("Asset Preloader: Loading Endless background (sprEndlessBackground) - 80 frames!");
        }
        break;
        
    case 6:
        // Preload player sprites
        if (sprite_exists(sprPlayer)) {
            current_preloading_sprite = sprPlayer;
            show_debug_message("Asset Preloader: Loading Player 1 sprite");
        }
        break;
        
    case 7:
        // Preload player 2 sprites
        if (sprite_exists(sprPlayer2)) {
            current_preloading_sprite = sprPlayer2;
            show_debug_message("Asset Preloader: Loading Player 2 sprite");
        }
        break;
        
    case 8:
        // Preload enemy sprites
        if (sprite_exists(sprEnemy1)) {
            current_preloading_sprite = sprEnemy1;
            show_debug_message("Asset Preloader: Loading Enemy sprite");
        }
        break;
        
    case 9:
        // Preload spirit sprites
        if (sprite_exists(sprBlueSpirit)) {
            current_preloading_sprite = sprBlueSpirit;
            show_debug_message("Asset Preloader: Loading Blue Spirit sprite");
        }
        break;
        
    case 10:
        // Preload more spirit sprites
        if (sprite_exists(sprGreenSpirit)) {
            current_preloading_sprite = sprGreenSpirit;
            show_debug_message("Asset Preloader: Loading Green Spirit sprite");
        }
        break;
        
    case 11:
        // Final sprite preload
        if (sprite_exists(sprRedSpirit)) {
            current_preloading_sprite = sprRedSpirit;
            show_debug_message("Asset Preloader: Loading Red Spirit sprite");
        }
        
        // Mark preloading as complete
        global.assets_preloaded = true;
        current_preloading_sprite = -1; // No more sprites to load
        show_debug_message("Asset Preloader: ALL ASSETS PRELOADED! Game performance optimized.");
        break;
}

// Move to next preload step
preload_step++;

// Continue preloading if not finished
if (preload_step < total_preload_steps) {
    alarm[0] = 2; // Wait 2 frames between loads to prevent stuttering
}