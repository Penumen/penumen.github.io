uniform mat4 lightProjMatrix;
uniform mat4 lightViewMatrix;


out vec3 vcsPosition;
out vec3 vcsNormal;
out vec4 lightSpaceCoords;
out vec2 texCoord;

void main() {
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
    texCoord = uv;
	lightSpaceCoords = lightProjMatrix * lightViewMatrix * modelMatrix * vec4(position,1.0);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    // modelMatrix * vec4(position, 1.0);
 }