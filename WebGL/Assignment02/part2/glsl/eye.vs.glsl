out vec3 modelPos;
out vec3 hue; 
out float toward;
void main() {
    // Pass on the model position so we can color the pupil.
    modelPos = position;
    hue = normalize( vec3(modelMatrix * vec4(position, 1.0)) );
    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position.
    // // vec3 worldCamDir = normalize( vec3(modelMatrix * vec4(position,1.0)) - cameraPosition );
    // // vec3 adjustedNormal = normalize(vec3(modelMatrix) * normal);
    // toward = clamp(,0.0,1.0);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
