out vec3 vcsNormal;
out vec3 vcsPosition;


void main() {


	// Qe pass varying variables to fs in view coordinate system
	// world pos
	vcsPosition = vec3(modelMatrix * vec4(position, 1.0));
	// normal
	// vcsNormal = normalize(normalMatrix * normal);
	vcsNormal= normal;
	
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}