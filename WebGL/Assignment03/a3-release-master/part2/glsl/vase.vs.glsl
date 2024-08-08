uniform vec3 spherePosition;

out vec3 viewPosition;

out vec3 worldPosition;

out vec3 interpolatedNormal;

out vec2 vertUV;
out float dist;
in float ticks; // MAKe IT IT SPARKlE?

void main() {
    
    viewPosition = vec3( inverse(projectionMatrix * modelViewMatrix) * vec4(0.0, 0.0, 0.0, 1.0));
    // viewPosition = vec3(inverse(viewMatrix) * modelMatrix * vec4(0.0, 0.0, 0.0, 1.0));
    vec3 center = vec3(0.0, 4.0, 0.0) - position;
    // float lati = atan(center.x, center.z) / (2.0 * 3.14159265) + 0.5;
    // float longi = center.y * 0.5 + 0.5;
    dist = distance(spherePosition, vec3(modelMatrix * vec4(position, 1.0)));
    // vertUV = vec2(lati,longi);
    vertUV = uv;
    // vec3 modelPosition = vec3(modelMatrix * vec4(position, 1.0));

    worldPosition = vec3(modelMatrix * vec4(position, 1.0));
    
    interpolatedNormal = normal;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
