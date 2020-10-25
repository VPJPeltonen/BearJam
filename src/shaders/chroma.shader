shader_type canvas_item;
uniform sampler2D NOISE_PATTERN;
uniform sampler2D NOISE_PATTERN_2;

void fragment() {
	vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 7.0).rgb;
	vec2 newuv = UV;
    newuv.x += TIME;
	if(c.g > 0.95){
		float noiseValue = texture(NOISE_PATTERN, UV).x+sin(TIME/4.0);
		float noiseValue2 = texture(NOISE_PATTERN_2, UV).x+cos(TIME/7.0);
   		c = vec3(noiseValue)/7.0+vec3(noiseValue2)/8.0;
		c = vec3(floor(30.0*c.r)/30.0,floor(30.0*c.g)/30.0,floor(30.0*c.b)/30.0)/0.80;//
	}
	//c.r = 0.0;
	//c = vec3(1.0) - c;
	COLOR.rgb = c;
}

