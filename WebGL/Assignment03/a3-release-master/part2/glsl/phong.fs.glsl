
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
    // return vec3(0.1);
}


vec3 calculateSpecular(vec3 normal, vec3 lightDirection){
    // HINT: Make sure to use the Jim Blinn's modification to the Phong Model (Blinn-Phong reflectance)
    // See textbook, Section 14.3
    // vec3 h = normalize(normal + lightDirection);
    // float spec = pow(max(0.0, dot(h, normal)),shininess);
    // return spec * specularColor * kSpecular;

    // vec3 spec = normalize(-lightDirection + vec3(2.0 * (dot(lightDirection,normal)) * normal ));
    // vec3 specular = kSpecular * specularColor * pow( max(vec3(0.0), spec), vec3(shininess) );
    // return specular;
    vec3 spec = normalize(lightDirection + normal);
    vec3 specular = kSpecular * specularColour * pow( max(0.0, dot(spec,normal)), shininess );
    return specular;

}






void main() {
    float falloff = 1.0 / (1.0 + dist *.01);
    // falloff = max(0.3,falloff);
    // falloff = min(falloff * 12.0 , 1.0);
    vec3 normal = normalize(mat3(transpose(inverse(modelMatrix))) * interpolatedNormal);

    vec3 lightDirection = normalize(spherePosition -  worldPosition);

    // HINT: Implement the following 3 functions
    vec3 out_Ambient = calculateAmbient();
    vec3 out_Diffuse = calculateDiffuse(normal, lightDirection, falloff);
        // vec3 out_Diffuse = calculateDiffuse(normal, lightDirection);
    vec3 out_Specular = calculateSpecular(normal, lightDirection);
    // vec3 bright = (out_Diffuse + out_Specular) * falloff;
    // vec3 out_Colour = out_Ambient + (out_Diffuse + out_Specular + bright)/2.0;

    vec3 out_Colour = out_Ambient + out_Diffuse + out_Specular;

    // if ( sin(length(spherePosition - worldPosition ) - ticks) <= 0.001 ) {
    //     out_Colour += vec3(0.02, 0.02, 0.001) * falloff;
    // }

    // if ( rando == vec3(gl_FragCoord) )  {
    //     out_Colour += vec3(0.78, 0.78, 0.51);
    // }  
    if (spark >=0.9) {
        if (spark >=0.99) {
        out_Colour -= vec3(0.03);
    }
        out_Colour += vec3(0.02,0.02,0.01);
    }


    gl_FragColor = vec4(clamp( out_Colour , 0.0, 1.0), 1.0);
}
