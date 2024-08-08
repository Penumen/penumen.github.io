
uniform float toptom;
uniform float bottom;
out float fresnel;
out vec3 colour;

void main() {
    vec4 worldPos = modelMatrix * vec4(position, 1.0);

    vec3 vertexNormal = vec3(normalize(modelMatrix * vec4(normal,0.0)));

    fresnel = 1.0 - abs(dot( normalize( vec3(modelMatrix * vec4(normal,0.0))), normalize(  vec3(worldPos) - cameraPosition)));

    vec3 fakeWorldPos = vec3(worldPos.x * bottom- toptom, worldPos.y * bottom + toptom, worldPos.z * toptom  );
    vec3 camToWorld = normalize(cameraPosition - fakeWorldPos);
    float fakeFresnel =  dot(normal, camToWorld);
    float vertexColour = dot(fakeWorldPos, vertexNormal);

    float r = (fakeFresnel * 0.3 - vertexColour * 0.2) * 0.3;
    float g = (fakeFresnel * 0.5 + vertexColour * 0.1) * 0.3;
    float b = fakeFresnel * 0.6;
    r*=r;
    g*=g;
    b*=b;

    colour = vec3(r,g,b);

    gl_Position = projectionMatrix * viewMatrix * worldPos;   
}