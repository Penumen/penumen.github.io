uniform float time;
out vec3 radialShift;
out float fresnel;

void main() {

    vec3 worldPos = vec3( modelMatrix * vec4(position, 1.0) );
    vec3 modifiedPos = 0.5 * (sin(time) * normal) + position; 
    // vec3 worldN = vec3(projectionMatrix * (normal,1.0));
    radialShift = normalize(cross((worldPos - cameraPosition), vec3(  normal) ));
    radialShift = normalize(abs(radialShift));
    // vec3 cam = vec3(cameraPosition.x,cameraPosition.y,cameraPosition.z);
    fresnel = 1.0 - abs(dot( normalize( vec3(modelMatrix * vec4(normal,0.0))), normalize(  worldPos - cameraPosition)));
// // is this because of - c.z??
//     fresnel *= fresnel;
    
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(modifiedPos, 1.0);
    // fresnel = 1.0 - abs(dot(  normal ,normalize(vec3(gl_Position) - cameraPosition)));
}
