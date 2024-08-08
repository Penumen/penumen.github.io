// HINT: Don't forget to define the uniforms here after you pass them in in A3.js

uniform vec3 toonColour;
uniform vec3 toonColour2;
uniform vec3 outlineColour;

// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 viewPosition;
in float fresnel;

void main() {
    // HINT: Compute the light intensity the current fragment by determining
    // the cosine angle between the surface normal and the light vector
    float intensity = dot(lightDirection,interpolatedNormal);

    // HINT: Define ranges of light intensity values to shade. GLSL has a
    // built-in `ceil` function that you could use to determine the nearest
    // light intensity range.
    // float level2 = 
    float midpoint = 2.0;
    intensity = ceil(intensity*midpoint)/midpoint;
    // intensity = ceil(intensity);
    // HINT: You should use two tones of colors here; `toonColor` is a cyan
    // color for brighter areas and `toonColor2` is a blue for darker areas.
    // Use the light intensity to blend the two colors, there should be 3 distinct
    // colour regions 
    vec3 out_Toon = mix(toonColour, toonColour2, 1.0 - intensity);

    // HINT: To achieve the toon silhouette outline, set a dark fragment color
    // if the current fragment is located near the edge of the 3D model.
    // Use a reasonable value as the threshold for the silhouette thickness
    // (i.e. proximity to edge).
    if (fresnel > 0.75) {
        out_Toon = outlineColour;
    }

    gl_FragColor = vec4(out_Toon, 1.0);
}
