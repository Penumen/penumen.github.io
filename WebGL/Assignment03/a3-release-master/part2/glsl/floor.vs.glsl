uniform float floorSize;
uniform float flrSz;        // half floor size (floor is always centered)
uniform vec3 spherePosition;
uniform sampler2D floorNormalTexture;
out vec2 texCoord;
out vec2 vertUV;
out vec3 vertexNormal;

out vec3 lightDirection;
// out float specular;
void main() {
    // HINT: pass texture coords to fragment shader
    vertUV = uv;
 
    texCoord = vec2(position.x + 25.0 ,position.y + 25.0) / 50.0; 
    // vec3 viewPosition = vec3(modelMatrix * vec4(position, 1.0));
 
    //WORKS 
    vertexNormal = vec3(modelViewMatrix * vec4(normal,0.0));
    lightDirection = normalize( spherePosition  - vec3(modelViewMatrix * vec4(position, 1.0)));
    
    vec3 mappedNormal = 2.0 * vec3(texture2D(floorNormalTexture,vertUV)) - vec3(1.0);

    vertexNormal = normalize(mappedNormal + vertexNormal);
    // float amount = dot(vertexNormal,normal);
    // vertexNormal = normalize(mappedNormal + vertexNormal * amount);

    // vec3 lightDirection = normalize(vec3(viewMatrix * vec4(spherePosition, 1.0)) - viewPosition);
    // specular = abs(dot(lightDirection,mappedNormal));
    // vec3 disp = vec3(texture2D(floorNormalTexture,texCoord)) + position;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}