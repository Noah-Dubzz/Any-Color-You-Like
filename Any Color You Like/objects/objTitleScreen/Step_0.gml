// Step Event of objTitleScreen

// Fade in the logo
if (alpha < 1) {
    alpha += 0.01; // Increase alpha for fade-in effect, adjust value for speed
    if (alpha > 1) {
        alpha = 1; // Clamp alpha to 1
    }
}

// Only start the animation if the logo is fully visible
if (alpha >= isAnimating) {
    // Play the animation of sprLogo once
    if (image_index < 50) {
        image_index += 1; // Move to the next frame
    } 
        // Change to the still sprite after the animation
        sprite_index = sprLogoAnimationStill; // Switch to the static logo sprite
}
