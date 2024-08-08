out float fresnel;
out vec3 radialShift;

void main() {
    vec4 worldPos = modelMatrix * vec4(position, 1.0);

    vec3 vertexNormal = vec3(normalize(modelMatrix * vec4(normal,0.0)));

    // vec3 camDirection = normalize(vec3(viewMatrix*(vec4(cameraPosition - worldPos.xyz, 0.0))));

    // float vertexColour = dot(camDirection, vertexNormal);
    // colour = vec3(vertexColour);
    
    // interpolatedNormal = normal;
    radialShift = normalize(cross(cameraPosition, vec3( vertexNormal) ));
    radialShift = normalize(abs(radialShift));

    fresnel = 1.0 - abs(dot( normalize( vec3(modelMatrix * vec4(normal,0.0))), normalize(  vec3(worldPos) - cameraPosition)));
    // fresnel = 1.0 - dot(normal,normalize(vec3(worldPos) - cameraPosition));

    gl_Position = projectionMatrix * viewMatrix * worldPos;   
}