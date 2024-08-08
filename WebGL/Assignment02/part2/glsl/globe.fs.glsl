in vec3 radialShift;
in float fresnel;
void main() {
	// float flatten = fresnel.x + fresnel.y + fresnel.z;
	// float f = dot(fresnel,fresnel);
	//fresnel.x,fresnel.y,fresnel.z

	float a = fresnel + fresnel * (radialShift.x - radialShift.y);
	float b = fresnel + fresnel * (radialShift.y - radialShift.z);
	float c = fresnel + fresnel * (radialShift.z - radialShift.x);
  	
	  
	  gl_FragColor = vec4(a,b,c, 1.0);
	// gl_FragColor = vec4(fresnel,fresnel,fresnel, 1.0);
}