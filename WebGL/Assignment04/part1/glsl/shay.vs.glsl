out vec3 vcsPosition;
out vec3 vcsNormal;
out vec2 texCoord;

void main() {
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
    texCoord.x = uv.x ;
    texCoord.y = 1.0 - uv.y ;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
 }