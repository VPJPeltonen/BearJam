shader_type canvas_item;
uniform sampler2D NOISE_PATTERN;

void fragment() {
	vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
	vec2 newuv = UV;
    newuv.x += TIME;
	if(c.g > 0.95){
		float noiseValue = texture(NOISE_PATTERN, UV).x;
   		c = vec3(noiseValue)/5.0;
		//c = vec3(0.0);
	}
	//c.r = 0.0;
	//c = vec3(1.0) - c;
	COLOR.rgb = c;
}

