shader_type canvas_item;

uniform float whiteness = 0.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.xyz = mix(color.xyz, vec3(1.0),whiteness);
	
	COLOR = color;
}
