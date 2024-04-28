shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix;

// Добавление переменных для управления параметрами облаков
uniform float cloud_scale : hint_range(0.1, 30.0) = 1.0;
uniform float cloud_speed : hint_range(0.0, 1.0) = 0.1;
uniform float cloud_density : hint_range(0.0, 1.0) = 0.8;
uniform float cloud_height : hint_range(0.0, 1.0) = 0.5;
uniform float cloud_opacity : hint_range(0.0, 1.0) = 0.5; // Добавлена переменная для прозрачности облаков

// Функции для генерации шума
float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

float noise(vec3 p) {
    vec3 i = floor(p);
    vec3 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    float res = mix(mix(mix(hash(dot(i + vec3(0,0,0), vec3(1,57,113))), 
                            hash(dot(i + vec3(1,0,0), vec3(1,57,113))), f.x),
                        mix(hash(dot(i + vec3(0,1,0), vec3(1,57,113))), 
                            hash(dot(i + vec3(1,1,0), vec3(1,57,113))), f.x), f.y),
                   mix(mix(hash(dot(i + vec3(0,0,1), vec3(1,57,113))), 
                            hash(dot(i + vec3(1,0,1), vec3(1,57,113))), f.x),
                        mix(hash(dot(i + vec3(0,1,1), vec3(1,57,113))), 
                            hash(dot(i + vec3(1,1,1), vec3(1,57,113))), f.x), f.y), f.z);
    return res;
}

// Генерация многослойного шума
float fbm(vec3 x) {
    float v = 0.0;
    float a = 0.5;
    vec3 shift = vec3(100);
    for (int i = 0; i < 4; ++i) {
        v += a * noise(x);
        x = x * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void fragment() {
    // Анимация позиции облаков
    vec3 pos = vec3(UV * cloud_scale, 0.0) + vec3(0.0, 0.0, TIME * cloud_speed);

    // Вычисление значения шума для облаков
    float n = fbm(pos * cloud_density);

    // Контроль высоты и плотности облаков
    float cloud_cover = smoothstep(cloud_height - 0.2, cloud_height + 0.2, n);

    // Установка прозрачности и цвета облаков
    ALBEDO = vec3(1.0);
    ALPHA = cloud_cover * cloud_opacity; // Умножение покрытия облаков на переменную прозрачности
}
