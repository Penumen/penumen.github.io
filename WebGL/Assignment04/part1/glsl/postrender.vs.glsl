uniform mat4 lightProjMatrix;
uniform mat4 lightViewMatrix;

out vec2 v_UV;
out vec4 lightSpaceCoords;

void main() {
    // v_UV = vec2(lightProjMatrix * lightViewMatrix * vec4(uv,1.0,1.0));  
    v_UV = uv;  
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4( position, 1.0 );
    // gl_Position = lightProjMatrix * lightViewMatrix * modelMatrix * vec4(position, 1.0);
}