// Create Event of objTitleScreen

// Set the scale factor
scale_factorx = 11.555;
scale_factory = 7.89;

// Set the initial sprite to sprLogo
sprite_index = sprLogoAnimation;

// Set the initial frame to 1 (keeping it stuck on frame 1)
image_index = 1;

// Set the alpha for fading
alpha = 0;

// Playback state
isAnimating = true; // Flag to control animation state

global.selected_obj = objClassic;
 global.menu_selection = 0; // Index of selected menu item (0 = objClassic, 1 = objEndlessMode, etc.)
 global.menu_items = [objClassic, objEndlessMode, objMultiPrism, objTimeAttack]; // Ordered list of menu objects
 menu_initialized = true; // Prevent reinitialization

