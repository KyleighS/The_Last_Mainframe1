shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
uniform float crt_brightness: hint_range(0.0, 1.0) = 1.0;        // Default value = 1.0
uniform float crt_ghost: hint_range(0.0, 10.0) = 1.3;            // Default value = 1.3
uniform float crt_grid: hint_range(0.0, 1.0) = 0.4;              // Default value = 0.4
uniform float crt_white_noise: hint_range(0.0, 1.0) = 0.05;      // Default value = 0.05
uniform float crt_curve: hint_range(0.0, 1.0) = 0.02;            // Default value = 0.02

float random(vec2 uv) {
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	float time = TIME;
	vec2 crt_curve_shift = (vec2(1.0) - sin(UV.yx * PI)) * crt_curve;
	vec2 crt_curve_scale = vec2(1.0) + crt_curve_shift * 2.0;
	vec2 screen_uv = SCREEN_UV * crt_curve_scale - crt_curve_shift;
	vec2 uv = UV * crt_curve_scale - crt_curve_shift;

	//float crt_mask = float(uv.x >= 0.0 && uv.x <= 1.0 && uv.y >= 0.0 && uv.y <= 1.0);
	vec2 dist_from_center = abs(uv - vec2(0.5)) * 2.0;
	float crt_mask = smoothstep(1.2, 0.9, max(dist_from_center.x, dist_from_center.y));

	vec3 color = texture(SCREEN_TEXTURE, screen_uv).rgb * (1.0 - crt_brightness * 0.5);

	color += texture(SCREEN_TEXTURE, screen_uv - vec2(SCREEN_PIXEL_SIZE.x * crt_ghost, 0.0)).rgb;
	color += texture(SCREEN_TEXTURE, screen_uv + vec2(SCREEN_PIXEL_SIZE.x * crt_ghost, 0.0)).rgb;
	color *= crt_brightness * 0.5 * crt_mask;

	vec2 noise_pixel = vec2(floor((screen_uv.x / SCREEN_PIXEL_SIZE.x) / 3.0) * 3.0, screen_uv.y) - sin(UV.yx * PI);
	float white_noise = random(noise_pixel + vec2(sin(time * PI / 4.0), cos(time * PI / 8.0))) * crt_mask;

	color = mix(color, vec3(white_noise), crt_white_noise);

	float crt_grid_uv = mod(SCREEN_UV.x / SCREEN_PIXEL_SIZE.x, 3.0);
	vec3 crt_grid_color;
	crt_grid_color.r = clamp(1.0 - crt_grid_uv, 0.0, 1.0) + clamp(crt_grid_uv - 2.0, 0.0, 1.0);
	crt_grid_color.g = clamp(1.0 - abs(1.0 - crt_grid_uv), 0.0, 1.0);
	crt_grid_color.b = 1.0 - crt_grid_color.r - crt_grid_color.g;
	color *= clamp(normalize(clamp(crt_grid_color, crt_grid, 1.0)), vec3(0.0), vec3(1.0));

	vec2 vignette_uv = (UV - vec2(0.5)) * 2.0;
	float vignette_radius = length(vignette_uv);

	float edge_start = 0.85;  // where darkening starts (closer to 1 = further out)
	float edge_end   = 1.6;  // where it becomes fully dark
	float vignette = 1.0 - smoothstep(edge_start, edge_end, vignette_radius);

	color *= vignette;
	COLOR = vec4(color, 1.0);
}