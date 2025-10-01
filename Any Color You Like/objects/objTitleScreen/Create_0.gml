// Create Event of objTitleScreen

// Set the scale factor (fixed from excessive scaling)
scale_factorx = 2.0;
scale_factory = 2.0;

// Center the logo on screen (override room positioning)
x = room_width / 2;
y = room_height / 2 - 100; // Slightly above center

// Set the initial sprite to sprLogo
sprite_index = sprLogoAnimation;

// Set the initial frame to 1 (keeping it stuck on frame 1)
image_index = 1;

// Set the alpha for fading
alpha = 0;

// Playbook state
isAnimating = true; // Flag to control animation state

// Initialize essential global variables immediately
if (!variable_global_exists("is_mobile")) {
    global.is_mobile = (os_type == os_android || os_type == os_ios);
}
if (!variable_global_exists("trail_length_modifier")) {
    global.trail_length_modifier = global.is_mobile ? 0.5 : 1.0;
}
if (!variable_global_exists("enemy_update_frequency")) {
    global.enemy_update_frequency = global.is_mobile ? 20 : 10;
}

global.selected_obj = objClassic;
global.menu_selection = 0; // Index of selected menu item (0 = objClassic, 1 = objEndlessMode, etc.)
global.menu_items = [objClassic, objEndlessMode, objMultiPrism, objTimeAttack]; // Ordered list of menu objects\n\n// Platform Optimization System\nif (!variable_global_exists(\"platform_initialized\")) {\n    global.platform_initialized = true;\n    \n    // Platform detection\n    global.platform_type = \"desktop\";\n    global.is_mobile = false;\n    global.performance_level = 2; // 0=low, 1=medium, 2=high\n    \n    if (os_type == os_android || os_type == os_ios) {\n        global.platform_type = \"mobile\";\n        global.is_mobile = true;\n        global.performance_level = 0;\n    } else if (os_type == os_ps4 || os_type == os_xboxone || os_type == os_switch) {\n        global.platform_type = \"console\";\n        global.performance_level = 1;\n    }\n    \n    // Optimize based on platform\n    if (global.is_mobile) {\n        room_speed = 60; // 60 FPS for mobile (improved from 30)\n        global.trail_length_modifier = 0.5;\n        global.enemy_update_frequency = 20;\n    } else {\n        room_speed = 144; // 144 FPS for desktop/console - HIGH PERFORMANCE!\n        global.trail_length_modifier = 1.0;\n        global.enemy_update_frequency = 10;\n    }\n    \n    show_debug_message(\"Platform: \" + global.platform_type + \" | Performance: \" + string(global.performance_level));\n}
menu_initialized = true; // Prevent reinitialization