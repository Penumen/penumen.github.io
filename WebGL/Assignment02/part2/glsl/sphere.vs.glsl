
uniform float time;
uniform bool tok;
// uniform mat4 pulse = [sin(time),0,0,0,
//                       0,sin(time),0,0,
//                       0,0,sin(time),0,
//                       0,0,0,1.0];


out vec3 interpolatedNormal;
out vec3 fresnel;

void main() {

    interpolatedNormal = normal;

    // TODO Q4 transform the vertex position to create deformations
    // Make sure to change the size of the orb sinusoidally with time.
    // The deformation must be a function on the vertice's position on the sphere.
    vec3 modifiedPos = 0.5 * (sin(time) * interpolatedNormal) + position; ///* TODO Q4 */
    float cubeSize = 0.8;
    float cubeMin = 0.4;
    if (tok) {
        modifiedPos.x = max(min(cubeSize,modifiedPos.x),-cubeSize);
        modifiedPos.y = max(min(cubeSize,modifiedPos.y),-cubeSize);
        modifiedPos.z = max(min(cubeSize,modifiedPos.z),-cubeSize);
    } 
    
    // else {
    //     modifiedPos.x = max(min(cubeMin,modifiedPos.x),-cubeMin);
    //     modifiedPos.y = max(min(cubeMin,modifiedPos.y),-cubeMin);
    //     modifiedPos.z = max(min(cubeMin,modifiedPos.z),-cubeMin);
    // }
    vec3 worldPos = vec3(modelMatrix * vec4(position, 1.0));
    vec3 direction = worldPos - cameraPosition;
    fresnel = normalize( cross(normal,direction) );

    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position.
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(modifiedPos, 1.0);
}
