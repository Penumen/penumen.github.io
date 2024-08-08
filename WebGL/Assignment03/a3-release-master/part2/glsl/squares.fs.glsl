// HINT: Don't forget to define the uniforms here after you pass them in in A3.js
uniform float ticks;
// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 vertexPosition;



void main() {
    float band = 0.2;
    float spread = 23.0;
    // float spread = 16.0 + 4.0 * sin(ticks);
    // float band = max(0.05,0.5*(1.0 - abs(sin(ticks*.25))));


    // HINT: Compute the light intensity the current fragment by determining
    // the cosine angle between the surface normal and the light vector.
    float intensity = dot(interpolatedNormal,lightDirection);
    vec3 colour1 = vec3(0.22, 0.06, 0.29);
    vec3 colour2 = vec3(0.82, 0.88, 0.4);

    // HINT: Pick any two colors and blend them based on light intensity
    // to give the 3D model some color and depth.
    vec3 out_Stripe = mix(colour1, colour2, intensity);
    float vanishX = sin(spread * vertexPosition.x - ticks);
    float vanishZ = sin(spread * vertexPosition.z );
    if (vanishX < band && vanishX > -band || vanishZ < band && vanishZ > -band ) {
        discard;
    }


    // HINT: Set final rendered colour
    gl_FragColor = vec4(out_Stripe, 1.0);
}