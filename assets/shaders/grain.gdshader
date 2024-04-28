shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;

uniform float grain_intensity : hint_range(0.0, 1.0) = 0.5;
uniform float grain_scale : hint_range(1.0, 100.0) = 20.0;
uniform float pixel_size : hint_range(0.1, 100.0) = 10.0;  // Control the pixelization scale

// A simple hash function for pseudo-random noise
float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    // Adjust UV to create a pixelized effect by snapping to a grid
    vec2 pixel_uv = floor(SCREEN_UV * grain_scale / pixel_size) * pixel_size / grain_scale;
    
    // Generate noise based on adjusted UV
    float noise = rand(pixel_uv + vec2(TIME));
    noise = mix(-grain_intensity, grain_intensity, noise);

    // Apply the noise as grain on top of the texture
    COLOR = texture(SCREEN_TEXTURE, UV) + vec4(vec3(noise), 0.0);
}
