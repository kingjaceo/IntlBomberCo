shader_type canvas_item;
uniform vec4 color : source_color = vec4(1.0);
uniform float diameter = 1.0; // Circle Diameter
uniform float thickness = 0.05; // Outline thickness
uniform float frequency = 10.0; // Controls the number of dots
uniform float phase = 0.0; // Controls the rotation of the circle
uniform float pulse_speed = 1.0; // Controls speed of pulse
uniform float rotation_speed = 1.0; // Controls rotation speed

void fragment() {
  vec2 pos = UV - vec2(0.5);
  float pulse_offset = sin(pulse_speed*TIME) * (1.0 - diameter);
  float outer_radius = (diameter + pulse_offset) / 2.0;
  float inner_radius = outer_radius - thickness;
  float outer_circle = step(length(pos), outer_radius);
  float inner_circle = step(length(pos), inner_radius);

  float angle = atan(pos.y, pos.x);
  if (angle < 0.0) {
    angle += 2.0 * PI;
  }

  float wave = 0.5 * sin(frequency * angle + phase + rotation_speed*TIME) + 0.5;


  float ring = outer_circle - inner_circle;
  ring *= step(0.5, wave);

  COLOR = vec4(color.rgb, ring * color.a);
}