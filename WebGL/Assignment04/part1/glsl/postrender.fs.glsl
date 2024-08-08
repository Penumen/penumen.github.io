in vec2 v_UV;
in vec4 lightSpaceCoords;
// uniform float lightDisance;
uniform sampler2D map;
uniform sampler2D tDiffuse;
uniform sampler2D tDepth;

void main() {
    float depth = 0.0;
    // float depth = texture(map,v_UV).y;
    vec3 tex = vec3(texture(map,v_UV));
    // float debugR = tex.r / 4.0;
    // float debugG = tex.g / 10.0;
    // float debugB = tex.r / 30.0;
    gl_FragColor = vec4( vec3(tex.x*2.0 - 1.0), 1.0);
    // gl_FragColor = vec4( vec3(depth), 1.0);
    // gl_FragColor = vec4( vec3(debugR, debugG, debugB), 1.0);
}