uniform vec3 spherePosition;
uniform float ticks;
out vec3 viewPosition;

out float spark;
out vec3 worldPosition;
out float dist;
out vec3 interpolatedNormal;

void main() {
    vec3 worldPos = vec3(modelMatrix * vec4(position, 1.0));
    viewPosition = vec3(inverse(viewMatrix) * vec4(0.0, 0.0, 0.0, 1.0));
    spark = 0.0;
    if ( cos( length(worldPos) - ticks) <= 0.0001 ) {
        spark = 1.0;
    }
    // vec3 modelPosition = vec3(modelMatrix * vec4(position, 1.0));
    dist = distance(spherePosition, vec3(modelViewMatrix * vec4(position, 1.0)));
    worldPosition = vec3(modelMatrix * vec4(position, 1.0));
    
    interpolatedNormal = normal;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
