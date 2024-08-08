in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 texCoord;
in vec4 lightSpaceCoords;

uniform vec3 lightColor;
uniform vec3 ambientColor;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform vec3 cameraPos;
uniform vec3 lightPosition;
uniform vec3 lightDirection;

// Textures are passed in as uniforms
uniform sampler2D colorMap;
uniform sampler2D normalMap;

// Added ShadowMap
uniform sampler2D shadowMap;
uniform float textureSize;
uniform int mapSizeX;
uniform int mapSizeY;
uniform bool shadowOn;

// FOR PCF: Returns a value in [0, 1] range, 1 indicating all sample points are occluded
// HINT: define a "stepAmount", so texels you sample from the texture are some "stepAmount" number of texels apart 
// float stepAmount = 0.0;
// HINT: the number of texels you sample from the texture
// float sampleSize = 0.0;
// HINT: the number of samples determind to be in shadow
// float count = 0.0;
	 
float calculateShadow(vec2 projectedUV) {
	float shadow = 0.0;
	float texelSize = 0.0009;
	float end = 1.5;
	float start = -end;
	float increment = 0.25;
	float div = (end - start)/increment;
	for (float x = start; x <= end; x += increment) {
		for (float y = start; y <= end; y += increment) {
			shadow += texture(shadowMap,projectedUV + vec2(x,y) * texelSize ).x - 0.5;
		}
	}
	return clamp((shadow /= (div*div)),0.0,1.0);
}

void main() {

	//Q1a compleme the implementation of the Blinn-Phong reflection model
	//PRE-CALCS
	vec3 N = normalize(vcsNormal);
	vec3 Nt = normalize(texture(normalMap, texCoord).xyz * 2.0 - 1.0);
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));

	//AMBIENT
	vec3 light_AMB = ambientColor * kAmbient;

	//DIFFUSE
	vec3 diffuse = kDiffuse * lightColor;
	vec3 light_DFF = diffuse * max(0.0, dot(N, L));

	//SPECULAR
	
	//SHADOW
	//Q1e do the shadow mapping
	vec3 projectedLocation = vec3(lightSpaceCoords) / lightSpaceCoords.w;
	projectedLocation = (projectedLocation + 1.0) * 0.5;
	float projectedDepth = projectedLocation.z;
	vec2 projectedUV = vec2(projectedLocation.xy);
	// float inShadow = texture(shadowMap,vec2(lightSpaceCoords)).x;
	float depthTex = texture(shadowMap,projectedUV).x;
	//Q1f PCF HINTS: see calculate shadow helper function
	
	float shadow = 0.0 ;
	if (shadowOn) {
		shadow = calculateShadow(projectedUV);
	}
	// float shadow = texture(shadowMap,vec2(texCoord)*textureSize).x;
	// if ( depthTex < projectedDepth ) {shadow = 1.0; }
	// float texelSize = 0.0009;
	//Qa add diffuse and specular components
	//Q1e incorporate shadow value into the calculation
	// if (sceneHandler == 3) {
		// float end = 1.5;
		// float start = -end;
		// float increment = 0.25;
		// float div = (end - start)/increment;
		// for (float x = start; x <= end; x += increment) {
		// 	for (float y = start; y <= end; y += increment) {
		// 		shadow += texture(shadowMap,projectedUV + vec2(x,y) * texelSize ).x - 0.5;
		// 	}
		// }
		// shadow /= (div*div);
	// }
	// light_DFF *= texture(colorMap, texCoord).xyz - depth;
	// if ( depth < projectedDepth ) {
	// 	light_DFF *= texture(colorMap, texCoord).xyz + vec3(1.0,0.0,0.0);
	// } else {
	// 	light_DFF *= texture(colorMap, texCoord).xyz;
	// }

	light_DFF *= texture(colorMap, texCoord).xyz - shadow; 

	vec3 TOTAL = light_AMB + light_DFF;

	gl_FragColor = vec4(TOTAL, 1.0);
}