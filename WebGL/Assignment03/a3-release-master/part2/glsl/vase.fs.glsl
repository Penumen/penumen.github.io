
uniform vec3 ambientColour;
uniform float kAmbient;

uniform vec3 diffuseColour;
uniform float kDiffuse;

uniform vec3 specularColour;
uniform float kSpecular;
uniform float shininess;

uniform mat4 modelMatrix;
in vec2 vertUV;
uniform vec3 spherePosition;

uniform sampler2D colourMap1;
uniform sampler2D colourMap2;
// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 viewPosition;
in vec3 worldPosition;
in float dist;

// uniform samplerCube uTextUnit();

vec3 calculateAmbient(){
    return kAmbient * ambientColour;
}

vec3 calcThreadDir(vec3 normal, vec3 threadDirection){
    return normalize(threadDirection + abs(dot(-threadDirection,normal)*normal));
}

vec3 calcProjVect(vec3 thread, vec3 lightDirection){
    return normalize(lightDirection + dot(-lightDirection,thread) * thread);
}

vec3 calcReflectRay(vec3 thread, vec3 proj){
    return normalize(-thread + 2.0* dot(thread,proj)*proj);
}


vec3 reflect(vec3 w, vec3 n) {
    return n * (dot(w,n)*2.0) - w;
}

void main() {
    float falloff = 1.0 / (1.0 + dist *.05);
    vec3 normal = normalize(mat3(transpose(inverse(modelMatrix))) * interpolatedNormal);
    vec3 lightDirection = normalize(spherePosition - worldPosition);

    // vec3 threadDirection = normalize(vec3(0.0,1.0,0.0));
    normal = normalize(vec3(texture2D(colourMap2,vertUV)) + normal);
    vec3 adjustN = vec3(0.5);
    vec3 threadDirection = -normalize(vec3(texture2D(colourMap2,vertUV)) - adjustN);
    vec3 diffColour = vec3(texture2D(colourMap2,vertUV));
    vec3 specColour = vec3(texture2D(colourMap1,vertUV)) / 1.2;
    // vec3 specColour = vec3(0.0,1.0,0.0);
    // diffColour.r += 0.5;
    // diffColour.g -= 0.5;
    // diffColour.b -= 0.5;


    vec3 thread = calcThreadDir(normal,threadDirection);
    vec3 proj = calcProjVect(thread,lightDirection);
    vec3 reflect = calcReflectRay(lightDirection,proj);

/// 
    // vec3 reflected = reflect(normalize(vec3(viewPosition)), normal);
    // vec3 skyColour = vec3(samplerCube(uTextUnit(),reflected));

    vec3 out_Ambient = calculateAmbient();
    vec3 out_Diffuse = diffColour * clamp(  max(0.0,dot(lightDirection,proj)) ,0.0,1.0) * falloff;
    vec3 out_Specular = specColour * clamp( pow( max(0.0,abs(dot(normalize(reflect),normalize(viewPosition)))), shininess) ,0.0,1.0);

    vec3 out_Colour = out_Ambient + kDiffuse * out_Diffuse + kSpecular * out_Specular;

    gl_FragColor = vec4(clamp(  out_Colour  , 0.0, 1.0), 1.0);
    //  gl_FragColor = vec4(vertUV,0.0, 1.0);
}
