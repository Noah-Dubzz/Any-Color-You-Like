/// Asset Preloader Draw Event
// Draw sprites off-screen to force GPU upload

// Only draw if we have a sprite to preload
if (current_preloading_sprite != -1 && sprite_exists(current_preloading_sprite)) {
    // Draw the sprite far off-screen with 0 alpha to force GPU upload
    // This forces GameMaker to load the texture into GPU memory
    var old_alpha = draw_get_alpha();
    draw_set_alpha(0); // Invisible
    
    // Draw multiple frames for animated sprites
    var frame_count = sprite_get_number(current_preloading_sprite);
    for (var i = 0; i < min(frame_count, 4); i++) { // Limit to 4 frames per step
        draw_sprite(current_preloading_sprite, i, -1000, -1000);
    }
    
    draw_set_alpha(old_alpha); // Restore alpha
    
    // Mark sprite as loaded after drawing
    show_debug_message("Asset Preloader: GPU uploaded " + sprite_get_name(current_preloading_sprite) + " (" + string(frame_count) + " frames)");
    current_preloading_sprite = -1; // Clear for next sprite
}