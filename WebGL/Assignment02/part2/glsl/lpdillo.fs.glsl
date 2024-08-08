in float fresnel;
in vec3 radialShift;

void main() {
	// fresnel *= fresnel;
	float a = clamp((fresnel + fresnel *  (radialShift.x - radialShift.y - radialShift.z) ),0.0,1.0);
	float b = clamp((fresnel + fresnel *  (radialShift.y - radialShift.z - radialShift.x) ),0.0,1.0);
	float c = clamp((fresnel + fresnel *  (radialShift.z - radialShift.x - radialShift.y) ),0.0,1.0);

	gl_FragColor = vec4(a,b,c, 1.0);
}