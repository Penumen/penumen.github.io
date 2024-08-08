in vec3 interpolatedNormal;
in vec3 fresnel;
void main() {
  	gl_FragColor = vec4( sin(interpolatedNormal + cos(fresnel) ), 1.0);
}
