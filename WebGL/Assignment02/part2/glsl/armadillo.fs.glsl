in float fresnel;
in vec3 colour;

void main() {
	// fresnel *= fresnel;
	float a = clamp((fresnel + colour.x ),0.0,1.0);
	float b = clamp((fresnel + colour.y ),0.0,1.0);
	float c = clamp((fresnel + colour.z ),0.0,1.0);

	a*=a; 
	b*=b;
	c*=c;

	gl_FragColor = vec4(a,b,c, 1.0);
}