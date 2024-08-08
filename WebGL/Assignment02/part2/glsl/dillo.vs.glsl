
uniform vec3 lightPosition;
uniform float time;
uniform float toptom;
uniform float bottom;
out vec3 colour;
// out float fresnel;
// out float top;
// out float bottom;

void main() {
    vec4 worldPos = modelMatrix * vec4(position, 1.0);

    vec3 vertexNormal = normalize(normalMatrix*normal);

    // vec3 lightDirection = normalize(vec3(viewMatrix*(vec4(lightPosition - worldPos.xyz, 0.0))));
   
    
	// float top = clamp( sin(time),0.0,1.0);
	// float bottom = clamp( cos(time),0.0,1.0);
  
    // Here I basically wobble around the actual position and give false location that orbits around the actual position based on time
    vec3 fakeWorldPos = vec3(worldPos.x * bottom- toptom, worldPos.y * bottom + toptom, worldPos.z * toptom  );
    vec3 camToWorld = normalize(cameraPosition - fakeWorldPos);
    // vec3 camToWorld = cameraPosition - vec3(worldPos);
    // camToWorld.x += top;
    // camToWorld.y += bottom;
    
    // 1.0 - to invert get higher value when orth to camera vector ?? 
    //  fresnel = - pow( (normalize( dot(normal, camToWorld) )), 1.0 ) ;
    // fresnel =  dot(normal, cameraPosition) * 0.5;
    float fakeFresnel =  dot(normal, camToWorld);

    float vertexColour = dot(fakeWorldPos, vertexNormal);

    // float r = (vertexColour - fresnel) * 0.2;
    // float g = (vertexColour + fresnel) * 0.1;
    // float b = (fresnel) * 0.5;

    float r = (fakeFresnel * 0.3 - vertexColour * 0.2) * 0.3;
    float g = (fakeFresnel * 0.5 + vertexColour * 0.1) * 0.3;
    float b = fakeFresnel * 0.6;

    // Here I make the effect more extreme
    r*=r;
    g*=g;
    b*=b;

    colour = vec3(r,g,b);


    // float vertexColour = dot(lightDirection, vertexNormal);
    // colour = vec3(vertexColour);

    gl_Position = projectionMatrix * viewMatrix * worldPos;   
}