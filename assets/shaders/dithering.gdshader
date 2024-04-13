shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest; // Экранная текстура
uniform float scale : hint_range(1.0, 64.0) = 8.0; // Масштабирование узора дизеринга
uniform float dither_opacity : hint_range(0.0, 1.0) = 1.0; // Прозрачность эффекта дизеринга

// Функция для генерации матрицы Байера 4x4
float bayerMatrix(vec2 pos) {
    int x = int(mod(pos.x, 4.0));
    int y = int(mod(pos.y, 4.0));
    int index = x + y * 4;

    float[16] bayerPattern = float[](
        0.0625, 0.5625, 0.1875, 0.6875,
        0.8125, 0.3125, 0.9375, 0.4375,
        0.2500, 0.7500, 0.1250, 0.6250,
        1.0000, 0.5000, 0.8750, 0.3750
    );

    return bayerPattern[index];
}

void fragment() {
    vec4 original_color = texture(SCREEN_TEXTURE, UV); // Исходный цвет из текстуры
    vec2 scaledUV = FRAGCOORD.xy / scale;
    float dither = bayerMatrix(scaledUV);

    // Применяем дизеринг к каждому цветовому каналу
    vec4 dithered_color = original_color;
    dithered_color.r = floor(original_color.r * 16.0 + dither) / 16.0;
    dithered_color.g = floor(original_color.g * 16.0 + dither) / 16.0;
    dithered_color.b = floor(original_color.b * 16.0 + dither) / 16.0;

    // Интерполяция между исходным и дизеринговым цветом с учётом прозрачности эффекта
    COLOR = mix(original_color, dithered_color, dither_opacity);
}