in vec3 vcsNormal;
in vec3 vcsPosition;

uniform vec3 lightDirection;

uniform samplerCube skybox;

uniform mat4 matrixWorld;

void main( void ) {
  // vec3 direction = normalize(vec3(matrixWorld * vec4(vcsPosition,1.0));

  vec3 viewVect = normalize(vcsPosition - cameraPosition);
	vec3 skyDir = normalize(reflect(viewVect,vcsNormal));
// vec3 skyDir = normalize(reflect(viewVect, (matrixWorld * vec4(vcsNormal,1.0))));
  skyDir.x *= -1.0;
  // skyDir.z *= -1.0;
  vec3 colour = vec3( texture(skybox, skyDir) );
  // Qd : Calculate the vector that can be used to sample from the cubemap
  gl_FragColor = vec4(colour, 1.0);
}