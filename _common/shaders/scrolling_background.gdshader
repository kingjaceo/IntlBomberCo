shader_type canvas_item;

const float speed = 0.1;
uniform vec2 direction = vec2(1.0,1.0);

void fragment() {
	COLOR = texture(TEXTURE, UV + (direction * TIME * speed));
}
