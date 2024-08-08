
uniform vec3 ambientColour;
uniform float kAmbient;
uniform float ticks;
uniform vec3 diffuseColour;
uniform float kDiffuse;
uniform vec3 rando;
uniform vec3 specularColour;
uniform float kSpecular;
uniform float shininess;

uniform mat4 modelMatrix;

uniform vec3 spherePosition;
in float dist;
// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 viewPosition;
in vec3 worldPosition;
in float spark;

vec3 calculateAmbient(){
    return kAmbient * ambientColour;
}

vec3 calculateDiffuse(vec3 normal, vec3 lightDirection, float falloff){
    return kDiffuse * diffuseColour * (max(0.0, dot(normal,lightDirection)) + falloff )/2.0;
}


vec3 calculateSpecular(vec3 normal, vec3 lightDirection){
    vec3 spec = normalize(lightDirection + normal);
    vec3 specular = kSpecular * specularColour * pow( max(0.0, dot(spec,normal)), shininess );
    return specular;

}

// CODE NOT FROM ME JUST USES A Vec2 TO GENERATE RANDOM NUMBER
// Input: It uses texture coords as the random number seed.
// Output: Random number: [0,1), that is between 0.0 and 0.999999... inclusive.
// Author: Michael Pohoreski
// Copyright: Copyleft 2012 :-)
// NOTE: This has been upgraded to version 3 !!
float random( vec2 p ) {
  // We need irrationals for pseudo randomness.
  // Most (all?) known transcendental numbers will (generally) work.
  const vec2 r = vec2(
    23.1406926327792690,  // e^pi (Gelfond's constant)
     2.6651441426902251); // 2^sqrt(2) (Gelfond–Schneider constant)
  return fract( cos( mod( 123456789., 1e-7 + 256. * dot(p,r) ) ) );  
}
///////////////////////// end cited code

void main() {
    float falloff = 1.0 / (1.0 + dist *.01);
    vec3 normal = normalize(mat3(transpose(inverse(modelMatrix))) * interpolatedNormal);
    vec3 lightDirection = normalize(spherePosition -  worldPosition);

    // HINT: Implement the following 3 functions
    vec3 out_Ambient = calculateAmbient();
    vec3 out_Diffuse = calculateDiffuse(normal, lightDirection, falloff);
    vec3 out_Specular = calculateSpecular(normal, lightDirection);
    vec3 out_Colour = out_Ambient + out_Diffuse + out_Specular;
    float dist = 4.0/ (1.0+ length(spherePosition - worldPosition )) ;
    if ( sin(length(spherePosition - worldPosition ) - ticks) <= 0.001 ) {
        float r = random(vec2(length(worldPosition),sin(ticks)));
        if ( r <= 0.00000001 ) {
            out_Colour += vec3(0.78, 0.74, 0.51);
        } 
        if ( r >= 0.9999 ) {
            out_Colour -= vec3(1, 0.95, 0.24);
        } 
        
        out_Colour += abs(sin(ticks) * dist * vec3(0.18, 0.0, 1.0));
        // if (cos(length(spherePosition + worldPosition ) - ticks) <= 0.001) {
        //     out_Colour -= abs(sin(ticks) * dist * vec3(0.1, 0.4, 0.4));
        // }
        
    }

    gl_FragColor = vec4(clamp( out_Colour , 0.0, 1.0), 1.0);
}
