shader_type canvas_item;

uniform float hover_active : hint_range(0.0, 1.0) = 0.0;
uniform vec4 glow_color : source_color = vec4(1.0, 0.9, 0.5, 1.0);
uniform float glow_intensity : hint_range(0.0, 2.0) = 0.8;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    vec3 glow = glow_color.rgb * glow_intensity;
    tex.rgb += glow * hover_active;
    COLOR = tex;
}