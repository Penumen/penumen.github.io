uniform int tocks;
uniform float ticks;
uniform vec3 spherePosition;

out vec2 vertUV;
out vec2 vertUVa;
out vec2 vertUVb;
out vec2 vertUVc;
out float h;
// out vec3 vertexNormal;

// out vec3 lightDirection;
// out float specular;
void main() {
    // vertUV = uv;
    vec3 wPos = vec3(modelMatrix * vec4(position, 1.0)) - spherePosition;
    float offx = cos(ticks)*0.2 + 0.2;
    float offy = sin(ticks)*0.2 + 0.2;
    // vertUV = uv + vec2(offx,offy);
    
    vertUV = vec2(wPos.x + 25.0 ,wPos.z + 25.0) / 50.0 ; 
    vertUVa = vec2(offx + sin(position.x) ,cos(position.y) + offy); 
    vertUVb = vec2(offx + sin(position.z) ,cos(position.x) + offy); 
    vertUVc = vec2(offx + sin(position.y) ,cos(position.z) + offy); 
    // vertexNormal = vec3(modelViewMatrix * vec4(normal,0.0));
    // lightDirection = normalize( spherePosition  - vec3(modelViewMatrix * vec4(position, 1.0)));
    
    h = wPos.y;
    // vec3 mappedNormal = 2.0 * vec3(texture2D(floorNormalTexture,vertUV)) - vec3(1.0);

    // vertexNormal = normalize(mappedNormal + vertexNormal);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}