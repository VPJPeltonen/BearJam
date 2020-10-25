shader_type canvas_item;

uniform float brightness = 0.8;
uniform float contrast = 1.5;
uniform float saturation = 1.8;

void fragment() {
	vec4 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgba;
	
	if(c.r == 1.0){
		c.a = 0.0;
	}
		
	//c.rgb = mix(vec3(0.0), c.rgb, brightness);
	//c.rgb = mix(vec3(0.5), c.rgb, contrast);
	//c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.33333), c.rgb, saturation);
	
	COLOR.rgba = c;
}
