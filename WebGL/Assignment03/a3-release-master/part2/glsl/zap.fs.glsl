// Textures are passed in as uniforms
uniform int tocks;
uniform sampler2D zap1;
uniform sampler2D zap2;
uniform sampler2D zap3;
uniform sampler2D zap4;
uniform sampler2D zap5;
// in vec2 texCoord;
in vec2 vertUV;
in vec2 vertUVa;
in vec2 vertUVb;
in vec2 vertUVc;
in float h;
// in vec3 vertexNormal;
// in vec3 lightDirection;

// in float specular;
void main() {
    vec3 colour; 
    if (tocks == 0 ){
        colour = vec3(texture2D(zap5,vertUV));
        colour += vec3(texture2D(zap5,vertUVa));
        colour += vec3(texture2D(zap5,vertUVb));
        colour += vec3(texture2D(zap5,vertUVc));

    } 
    if (tocks == 1 ){
        colour = vec3(texture2D(zap1,vertUV));
        colour += vec3(texture2D(zap1,vertUVa));
        colour += vec3(texture2D(zap1,vertUVb));
        colour += vec3(texture2D(zap1,vertUVc));
    } 
    if (tocks == 2 ){
        colour = vec3(texture2D(zap2,vertUV));
        colour += vec3(texture2D(zap2,vertUVa));
        colour += vec3(texture2D(zap2,vertUVb));
        colour += vec3(texture2D(zap2,vertUVc));
    } 
    if (tocks == 3 ){
        colour = vec3(texture2D(zap3,vertUV));
        colour += vec3(texture2D(zap3,vertUVa));
        colour += vec3(texture2D(zap3,vertUVb));
        colour += vec3(texture2D(zap3,vertUVc));
    } 
    if (tocks == 4 ){
        colour = vec3(texture2D(zap4,vertUV));
        colour += vec3(texture2D(zap4,vertUVa));
        colour += vec3(texture2D(zap4,vertUVb));
        colour += vec3(texture2D(zap4,vertUVc));

    } 
    float level = 10.0;
    float mixer = 1.0;
    vec3 colour2 = vec3(0.47, 0.07, 0.07);
    if (h <= -level) {
        mixer = 1.0/(1.0 + pow(abs(level + h),1.2));
    }
    colour = clamp(colour,0.0,1.0); 
    colour2 *= (1.0 - mixer);
    colour = mix(colour2, colour, mixer);
    
    gl_FragColor = vec4(colour ,1.0);
}