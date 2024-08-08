in vec3 modelPos;
in vec3 hue;
in float toward;

void main() {
	// The eye is facing +z so when it is initially positioned on the armadillo,
	// it should be facing backward.
	if (modelPos.z > 0.96) {
		// Pupil
  		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	} else if (modelPos.z > 0.8) {
		// Iris. Purple but feel free to make change this to your liking.
		// Just wanted to try to see if abs value of vector works... it does!
  		gl_FragColor = vec4(abs(hue), 1.0);
	} else {
		// Eye whites (the Armadillo is tired, so the eye whites are pinkish).
  		gl_FragColor = toward*(vec4(1.0, 0.9, 0.9, 1.0));
	}
}
