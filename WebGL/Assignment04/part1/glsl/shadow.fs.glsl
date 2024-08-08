// uniform sampler2D map;
// in float uvValue;
// in float depth;

void main() {
    // vec3 colour = texture(map,uvValue);
    // gl_FragColor = vec4(depth,1.0);
    // gl_FragColor = vec4(colour, 1.0);
    gl_FragColor = vec4(1.0, 1.0, 0.0, 1.0);
    // gl_FragColor = vec4(vec3(gl_FragCoord.z/200.0), 1.0);
}