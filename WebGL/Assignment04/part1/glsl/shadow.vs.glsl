// uniform sampler2D map;
// out float uvValue;
// out float depth;

void main() {
    // uvValue = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
    // depth = gl_Position.z;
}