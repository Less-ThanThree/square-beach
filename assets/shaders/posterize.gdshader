shader_type canvas_item;

// Define a screen texture with specific hints for usage
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;

// Number of color levels
uniform float levels : hint_range(2.0, 256.0) = 4.0; 

void fragment() {
    // Retrieve color from the screen texture instead of the object's texture
    vec4 color = texture(SCREEN_TEXTURE, UV);
    color.rgb = floor(color.rgb * levels) / (levels - 1.0);
    COLOR = color;
}
