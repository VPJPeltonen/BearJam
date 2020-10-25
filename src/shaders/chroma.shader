shader_type canvas_item;

uniform float brightness = 0.8;
uniform float contrast = 1.5;
uniform float saturation = 1.8;

void fragment() {
	vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
	if(c.g > 0.95){
		c = vec3(0.0);
	}
	//c.r = 0.0;
	//c = vec3(1.0) - c;
	COLOR.rgb = c;
}

