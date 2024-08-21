shader_type canvas_item;

uniform sample2D noise: repeat_enable;
const float speed = 0.5;


void fragment() {
	vec2 new_uv = vec2(UV.x * TIME * speed, UV.y * TIME * speed);
	COLOR = texture(noise, new_uv);
}
