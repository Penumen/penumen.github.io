// Textures are passed in as uniforms
uniform sampler2D colourMap;
uniform sampler2D floorColourTexture;
in vec2 texCoord;
in vec2 vertUV;
in vec3 vertexNormal;
in vec3 lightDirection;

// in float specular;
void main() {
    // vec3 colour = (colorMap,texCoord,0.0);
    // fragCoord/iResolution.xy
    // vec3 colour = vec3(texCoord,0.0);
    // vec3 colour = texture(colorMap,texCoord);
    // vec3 colour = colorMap(texCoord);

  
  
    // gl_FragColor = color;
    float intensity = clamp(dot(vertexNormal,lightDirection),0.0,1.0); 

    vec3 colour = vec3(texture2D(colourMap,vertUV));  //or text coord to map straight through
    // vec3 colour = texture2D(floorColorTexture,texCoord);
   
    // texture2D(tex,gl_TexCoord[0].st);
    // vec4 color = texture2D(tex,gl_TexCoord[0].st);

    // gl_FragColor = vec4(vertUV,0.0,1.0);
    // gl_FragColor = vec4(texCoord,0.0,1.0);
    gl_FragColor = vec4(colour * intensity ,1.0);
}