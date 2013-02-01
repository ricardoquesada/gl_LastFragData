
#extension GL_EXT_shader_framebuffer_fetch : require

void main(void)
{
	// @Birkemose grey values
//	mediump float lum = dot(gl_LastFragData[0], vec4(0.212,0.715,0.072,0.0));
	
	// Apples' values
	mediump float lum = dot(gl_LastFragData[0], vec4(0.30,0.59,0.11,0.0));

	gl_FragColor = vec4(lum, lum, lum, 1.0);
}
