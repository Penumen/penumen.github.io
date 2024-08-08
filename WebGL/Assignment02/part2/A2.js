/*
 * UBC CPSC 314, 2021WT1
 * Assignment 2 Template
 */

// Setup and return the scene and related objects.
// You should look into js/setup.js to see what exactly is done here.
const {
  renderer,
  scene,
  camera,
  worldFrame,
} = setup();

/////////////////////////////////
//   YOUR WORK STARTS BELOW    //
/////////////////////////////////

// Initialize uniforms

const lightOffset = { type: 'v3', value: new THREE.Vector3(0.0, 5.0, 5.0) };
// var camPos = { type: 'v3', value: new THREE.Vector3(0.0, 30.0, 55.0)};
const toptom = {type: 'float', value: 0};
const bottom = {type: 'float', value: 0};
const time = {type: 'float', value: 0};

const tok = {type: 'bool', value: false};


// var tok = false;
var tik = 0;

// Materials: specifying uniforms and shaders
// camera.position.set(0.0, 30.0, 55.0);
// const armadTexture = new THREE.TextureLoader().load( "images/Snow03.png" );
// armadTexture.wrapS = THREE.RepeatWrapping;
// armadTexture.wrapT = THREE.RepeatWrapping;
// armadTexture.repeat.set( 4, 4 );
// var armadilloUniform = {type: 't', value: armadTexture};

const armadilloMaterial = new THREE.ShaderMaterial({
  uniforms: {
    lightOffset: lightOffset,
    toptom: toptom,
    bottom: bottom,
    // armadilloUniform: armadilloUniform,
    // camPos: camPos,
  }
});

const lpdilloMaterial = new THREE.ShaderMaterial({
  uniforms: {
  }
});

const dilloMaterial = new THREE.ShaderMaterial({
  uniforms: {
    toptom: toptom,
    bottom: bottom,
  }
});

const sphereMaterial = new THREE.ShaderMaterial({
  uniforms: {
    // HINT pass uniforms to sphere shader here
    time: time,
    tok: tok,
  }
});

const globeMaterial = new THREE.ShaderMaterial({
  uniforms: {
    time: time,
  }
});

const eyeMaterial = new THREE.ShaderMaterial();

const armadilloFrame = new THREE.Object3D();
armadilloFrame.position.set(0, 0, -8);

const lpdilloFrame = new THREE.Object3D();
lpdilloFrame.position.set(8, 0, 8);

const dilloFrame = new THREE.Object3D();
dilloFrame.position.set(-8, 0, 8);

scene.add(armadilloFrame);
scene.add(lpdilloFrame);
scene.add(dilloFrame);

const cubeBG = new THREE.CubeTextureLoader();
cubeBG.setPath( 'images/' );

const textureCube = cubeBG.load( [
	'bg_02.png', 'bg_03.png',
	'bg_00.png', 'bg_05.png',
	'bg_04.png', 'bg_01.png'
] );

scene.background = textureCube;

// const bgMaterial = new THREE.MeshBasicMaterial( { color: 0x000000, envMap: textureCube } );



// scene.background = new THREE.Color("rgb(100%, 80%, 10%)");

const transformationMatrixR = {type: 'mat4', value: new THREE.Matrix4()};
const transformationMatrixL = {type: 'mat4', value: new THREE.Matrix4()};

// Load shaders.
const shaderFiles = [
  'glsl/armadillo.vs.glsl',
  'glsl/armadillo.fs.glsl',
  'glsl/lpdillo.vs.glsl',
  'glsl/lpdillo.fs.glsl',
  'glsl/dillo.vs.glsl',
  'glsl/dillo.fs.glsl',
  'glsl/sphere.vs.glsl',
  'glsl/sphere.fs.glsl',
  'glsl/globe.vs.glsl',
  'glsl/globe.fs.glsl',
  'glsl/eye.vs.glsl',
  'glsl/eye.fs.glsl'
];

new THREE.SourceLoader().load(shaderFiles, function (shaders) {
  armadilloMaterial.vertexShader = shaders['glsl/armadillo.vs.glsl'];
  armadilloMaterial.fragmentShader = shaders['glsl/armadillo.fs.glsl'];

  dilloMaterial.vertexShader = shaders['glsl/dillo.vs.glsl'];
  dilloMaterial.fragmentShader = shaders['glsl/dillo.fs.glsl'];

  lpdilloMaterial.vertexShader = shaders['glsl/lpdillo.vs.glsl'];
  lpdilloMaterial.fragmentShader = shaders['glsl/lpdillo.fs.glsl'];

  sphereMaterial.vertexShader = shaders['glsl/sphere.vs.glsl'];
  sphereMaterial.fragmentShader = shaders['glsl/sphere.fs.glsl'];

  globeMaterial.vertexShader = shaders['glsl/globe.vs.glsl'];
  globeMaterial.fragmentShader = shaders['glsl/globe.fs.glsl'];

  eyeMaterial.vertexShader = shaders['glsl/eye.vs.glsl'];
  eyeMaterial.fragmentShader = shaders['glsl/eye.fs.glsl'];
});

// Load and place the Armadillo geometry.
loadAndPlaceOBJ('obj/armadillo.obj', armadilloMaterial, armadilloFrame, function (armadillo) {
  armadillo.rotation.y = Math.PI;
  armadillo.position.y = 5.3
  armadillo.scale.set(0.1, 0.1, 0.1);
});

let s = 0.04;
// let dilloSize = new THREE.Vector3(s,s,s);

loadAndPlaceOBJ('obj/lpdillo.obj', dilloMaterial, dilloFrame, function (dillo) {
  dillo.rotation.y = Math.PI;
  dillo.position.set(0, 2.70, 0);
  dillo.scale.set(s,s,s);
});

loadAndPlaceOBJ('obj/lpdillo.obj', lpdilloMaterial, lpdilloFrame, function (lpdillo) {
  lpdillo.rotation.y = Math.PI;
  lpdillo.position.set(0, 2.70, 0);
  lpdillo.scale.set(s,s,s);
});

// https://threejs.org/docs/#api/en/geometries/SphereGeometry
/////////////////////////////////////////////////////////////////////// SPHERE STUFF

const sphereGeometry = new THREE.SphereGeometry(1.0, 32.0, 32.0);
const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);

const sphereLight = new THREE.PointLight(0xffffff, 1, 100);
scene.add(sphereLight);
sphereLight.position.set(0, 10, 0);

const globeGeometry = new THREE.SphereGeometry(1.0, 32.0, 32.0);
const globe = new THREE.Mesh(globeGeometry, globeMaterial);

const orbitalSys = new THREE.Object3D();
const orbital = new THREE.Object3D();

scene.add(orbitalSys);
orbitalSys.add(orbital);
orbital.add(globe);
orbital.add(sphere);

orbital.position.set(0, 10, 5);
sphere.position.set(0, -3, 0);
globe.position.set(0, 2, 0);


///////////////////////////////////////////////////////////////////////// EYES
// Eyes (Q1a and Q1b)
// Create the eye ball geometry
const eyeGeometry = new THREE.SphereGeometry(1.0, 32, 32);
const eyeXDist = 0.8;
const eyeYHght = 12.0;
const eyeZDepth = 3.0;
const baseEyeSize = 0.5;

const rightEye = new THREE.Mesh(eyeGeometry, eyeMaterial);
// const rightEye = new THREE.Object3D(eyeGeometry, eyeMaterial);

rightEye.scale.set(baseEyeSize, baseEyeSize, baseEyeSize);
rightEye.position.set(-eyeXDist, eyeYHght, eyeZDepth);

// const rightEyeFrame = new THREE.Object3D();

armadilloFrame.add(rightEye);

const leftEye = new THREE.Mesh(eyeGeometry, eyeMaterial);
leftEye.scale.set(baseEyeSize, baseEyeSize, baseEyeSize);
leftEye.position.set(eyeXDist, eyeYHght, eyeZDepth);
armadilloFrame.add(leftEye);


const rotationBox1 = new THREE.Object3D();
const rotationBox2 = new THREE.Object3D();
const rotationBox3 = new THREE.Object3D();
const rotationFrames = [rotationBox1,rotationBox2,rotationBox3];
scene.add(rotationBox1);
rotationBox1.add(rotationBox2);
rotationBox2.add(rotationBox3);

const numEyes = 7;
const eyeArray = [];
const eyeArrayFrames = [];
const distTiers = 10.0;


/////////////////////////////////////////// EYE ARRAY
for (let j = 0; j < 3; j++ ){
  for (let i = 0; i < numEyes; i++ ){
    eyeArray.push( new THREE.Mesh(eyeGeometry, eyeMaterial) );
    let variation = Math.random() * baseEyeSize * 2;
    eyeArray[i+j*numEyes].scale.set(baseEyeSize + variation, baseEyeSize + variation, baseEyeSize + variation);
    eyeArray[i+j*numEyes].position.set((j+2)*distTiers * Math.cos(i*2*Math.PI/numEyes), Math.random() * distTiers + 2.0, (j+2)*distTiers * Math.sin(i*2*Math.PI/numEyes));
    eyeArrayFrames.push( new THREE.Object3D() );
    eyeArrayFrames[i+j*numEyes].add(eyeArray[i+j*numEyes]);
    rotationFrames[j].add(eyeArrayFrames[i+j*numEyes]);
  }
}


// Distance threshold beyond which the armadillo should shoot lasers at the sphere (needed for Q1c).
const LaserDistance = 10.0;

const laserGeometry = new THREE.CylinderGeometry(0.25, 0.25, 1.0);
const laserMaterial = new THREE.MeshPhongMaterial({ color: 0xff0000, wireframe: false });

const lazerR = new THREE.Mesh(laserGeometry, laserMaterial);
const lazerL = new THREE.Mesh(laserGeometry, laserMaterial);

// const quaternion = new THREE.Quaternion();
// quaternion.setFromAxisAngle( new THREE.Vector3( 1, 0, 0 ), Math.PI / 2 );
 

lazerR.position.z = (1.0);
lazerR.rotation.x = Math.PI * 0.5;

lazerL.position.z = (1.0);
lazerL.rotation.x = Math.PI * 0.5;

rightEye.add(lazerR);
leftEye.add(lazerL);

const blueLazerMaterial = new THREE.MeshPhongMaterial({ color: 0x77aeeff, wireframe: true });
const blueLazerGeometry = new THREE.CylinderGeometry(0.0, 0.25, 1.0);
const blueLazer = new THREE.Mesh(blueLazerGeometry, blueLazerMaterial);
blueLazer.rotation.x = Math.PI * 0.5;
var blueTarget = 0;


// SECONDARY CONSTs & VALs

let orb = new THREE.Vector3();
let eyeDistR = 0;
let eyeDistL = 0;
let targetEyeDist = 0;
let eyeR = new THREE.Vector3();
let eyeL = new THREE.Vector3();
let eyeT = new THREE.Vector3();
// var sphereWP= new THREE.Matrix4();
// const stretchR = new THREE.Matrix4();
const speed = 0.1;

// Listen to keyboard events.
const keyboard = new THREEx.KeyboardState();
function checkKeyboard() {

  if (keyboard.pressed("q")) {    // Vertical Down
    orbitalSys.translateY(-speed);
  }
  if (keyboard.pressed("e")) {    // Vertical Up
    orbitalSys.translateY(speed);
  }
  if (keyboard.pressed("w")) {    // in plane North
    orbitalSys.translateZ(-speed);    
  }
  if (keyboard.pressed("a")) {    // in plane West
    orbitalSys.translateX(-speed);    
  }
  if (keyboard.pressed("s")) {    // in plane South
    orbitalSys.translateZ(speed);
  }
  if (keyboard.pressed("d")) {    // in plane East
    orbitalSys.translateX(speed);
  }
  if (keyboard.pressed("space")) {    // Armadillo FWD
    armadilloFrame.translateZ(speed);
    lpdilloFrame.translateZ(-speed);
  }
  if (keyboard.pressed("v")) {      // Armadillo BCKWRD
    armadilloFrame.translateZ(-speed);
    lpdilloFrame.translateZ(speed);
  }

  armadilloMaterial.needsUpdate = true;
  lpdilloMaterial.needsUpdate = true;
  sphereMaterial.needsUpdate = true;
  eyeMaterial.needsUpdate = true;
  globeMaterial.needsUpdate = true;
  
  // orb = sphere.position;
  sphere.getWorldPosition(orb);
  rightEye.getWorldPosition(eyeR);
  leftEye.getWorldPosition(eyeL);
  eyeArray[blueTarget].getWorldPosition(eyeT);

  eyeDistR = Math.abs( orb.distanceTo(eyeR) );
  eyeDistL = Math.abs( orb.distanceTo(eyeL) );
  targetEyeDist = Math.abs( orb.distanceTo(eyeT) );

  lazerStatus();
  
}

function lazerStatus() {
  if (eyeDistR <= LaserDistance) { 
    lazerR.scale.setY(2 * eyeDistR);
    lazerR.position.z = (eyeDistR);
    lazerR.visible = true;
  } else {
    lazerR.visible = false;
  }
  if (eyeDistL <= LaserDistance) {
    lazerL.scale.setY(2 * eyeDistL);
    lazerL.position.z = (eyeDistL); 
    lazerL.visible = true;
  } else {
    lazerL.visible = false;
  }
  blueLazer.scale.setY( (targetEyeDist) / eyeArray[blueTarget].scale.x);
  blueLazer.position.z = (targetEyeDist/ (2.0 * eyeArray[blueTarget].scale.x));
}

function tiktok() {
  tik++;
  if (tik % 3600 == 0) {
    if (tok.value) {
      tok.value = false;
    } else {
      tok.value = true;
    }
  }
  if (tik % 400 == 0) {
    eyeArray[blueTarget].remove(blueLazer);
    blueTarget = Math.floor(Math.random() * eyeArray.length); 
    eyeArray[blueTarget].add(blueLazer);
  } else if (tik % 200 == 0) {
    eyeArray[blueTarget].remove(blueLazer);
  }
}

// Setup update callback
function update() {
  checkKeyboard();
  for (let j = 0; j < 3; j++) {
    rotationFrames[j].rotation.y -= (j+1)*.0001;
    // rotationFrames[j].rotation.y -= (j+1)%2*.0001 - (j+2)%2*.0003;
  }
  time.value += 1/90;   //Assumes 60 frames per second
  toptom.value = Math.cos(time.value);
  bottom.value = Math.sin(time.value);
  tiktok();
  orbital.rotation.z += 0.005;
  armadilloFrame.rotation.y += 0.005;
  lpdilloFrame.rotation.y -= 0.001;
  dilloFrame.rotation.y += 0.001;
  rightEye.lookAt(orb);
  leftEye.lookAt(orb);
  for (let i = 0; i < numEyes*3; i++) {
    eyeArrayFrames[i].translateY(0.01 * Math.cos(time.value * eyeArray[i].scale.x ));
    eyeArray[i].lookAt(orb);
  }
  // Requests the next update call, this creates a loop
  requestAnimationFrame(update);
  renderer.render(scene, camera);
}

// Start the animation loop.
update();


