/*
 * UBC CPSC 314
 * Assignment 3 Template
 */

// Setup the renderer
// You should look into js/setup.js to see what exactly is done here.
const { renderer, canvas } = setup();

/////////////////////////////////
//   YOUR WORK STARTS BELOW    //
/////////////////////////////////

// const triforce2Frame = new THREE.Object3D();
// const triforce3Frame = new THREE.Object3D();
// Load floor textures
// const floorColorTexture = new THREE.TextureLoader().load('texture/color.jpg');
// floorColorTexture.minFilter = THREE.LinearFilter;
// floorColorTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();

// const floorNormalTexture = new THREE.TextureLoader().load('texture/normal.png');
// floorNormalTexture.minFilter = THREE.LinearFilter;
// floorNormalTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();

const snow02Texture = new THREE.TextureLoader().load('texture/Snow02.png');
snow02Texture.minFilter = THREE.LinearFilter;
snow02Texture.anisotropy = renderer.capabilities.getMaxAnisotropy();

const snow03Texture = new THREE.TextureLoader().load('texture/Snow03.png');
snow03Texture.minFilter = THREE.LinearFilter;
snow03Texture.anisotropy = renderer.capabilities.getMaxAnisotropy();

const zap1 = new THREE.TextureLoader().load('texture/lightn1.png');
zap1.minFilter = THREE.LinearFilter;
zap1.anisotropy = renderer.capabilities.getMaxAnisotropy();

const zap2 = new THREE.TextureLoader().load('texture/lightn2.png');
zap2.minFilter = THREE.LinearFilter;
zap2.anisotropy = renderer.capabilities.getMaxAnisotropy();

const zap3 = new THREE.TextureLoader().load('texture/lightn3.png');
zap3.minFilter = THREE.LinearFilter;
zap3.anisotropy = renderer.capabilities.getMaxAnisotropy();

const zap4 = new THREE.TextureLoader().load('texture/lightn4.png');
zap4.minFilter = THREE.LinearFilter;
zap4.anisotropy = renderer.capabilities.getMaxAnisotropy();

const zap5 = new THREE.TextureLoader().load('texture/lightn5.png');
zap5.minFilter = THREE.LinearFilter;
zap5.anisotropy = renderer.capabilities.getMaxAnisotropy();




// Uniforms - Pass these into the appropriate vertex and fragment shader files
const spherePosition = { type: 'v3', value: new THREE.Vector3(0.0, 0.0, 0.0) };
const tangentDirection = { type: 'v3', value: new THREE.Vector3(0.5, 0.0, 1.0) };

const ambientColour = { type: 'c', value: new THREE.Color(0.9, 0.3, 0.0) };
const diffuseColour = { type: 'c', value: new THREE.Color(0.9, 0.6, 0.0) };
const specularColour = { type: 'c', value: new THREE.Color(1.0, 1.0, 1.0) };
const lightColour = { type: 'c', value: new THREE.Color(1.0, 1.0, 1.0) };
const toonColour = { type: 'c', value: new THREE.Color(0.88, 1.0, 1.0) };
const toonColour2 = { type: 'c', value: new THREE.Color(0.0, 1.0, 1.0) };
const outlineColour = { type: 'c', value: new THREE.Color(0.0, 0.0, 1.0) };
const vaseSpecColour = { type: 'c', value: new THREE.Color(0.5, 0.8, 1.0) };
const vaseShininess = { type: "f", value: 2.0 };

const kAmbient = { type: "f", value: 0.1 };
const kDiffuse = { type: "f", value: 0.4 };
const kSpecular = { type: "f", value: 0.9 };
const shininess = { type: "f", value: 18.0 };
const ticks = { type: "f", value: 0.0 };
const tocks = { type: "f", value: 0 };

const sphereLight = new THREE.PointLight(0xffffff, 1, 300);
const floorSize = 50.0;
const flrSz = floorSize * 0.5;

const rando = { type: "f", value: new THREE.Vector3(Math.random(),Math.random(),Math.random()) };


const triforce1Frame = new THREE.Object3D();

// Shader materials
const sphereMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition
  }
});

// const floorMaterial = new THREE.ShaderMaterial({ 
//   uniforms: {
//     spherePosition,
//     floorSize,
//     flrSz,
//     colourMap: { type: "t", value: floorColorTexture },
//     normalMap: { type: "t", value: floorNormalTexture }
//   }
// });

const phongMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition,
    ambientColour: ambientColour,
    diffuseColour: diffuseColour,
    specularColour: specularColour,
    kAmbient: kAmbient,
    kDiffuse: kDiffuse,
    kSpecular: kSpecular,
    shininess: shininess,
    rando: rando,
    ticks: ticks
  }
});

const staticMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition,
    ambientColour: ambientColour,
    diffuseColour: diffuseColour,
    specularColour: specularColour,
    kAmbient: kAmbient,
    kDiffuse: kDiffuse,
    kSpecular: kSpecular,
    shininess: shininess,
    rando: rando,
    ticks: ticks
  }
});

const anisotropicMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition,
    ambientColour: ambientColour,
    diffuseColour: diffuseColour,
    specularColour: specularColour,
    kAmbient: kAmbient,
    kDiffuse: kDiffuse,
    kSpecular: kSpecular,
    shininess: shininess,
    lightColour: lightColour,
    tangentDirection: tangentDirection
  }
});

const toonMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition,
    toonColour: toonColour,
    toonColour2: toonColour2,
    outlineColour: outlineColour
  }
});

const squaresMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition,
    ticks: ticks
  }
});

const zapMaterial = new THREE.ShaderMaterial({
  uniforms: {
    zap1: { type: "t", value: zap1 },
    zap2: { type: "t", value: zap2 },
    zap3: { type: "t", value: zap3 },
    zap4: { type: "t", value: zap4 },
    zap5: { type: "t", value: zap5 },
    spherePosition: spherePosition,
    ticks: ticks,
    tocks: tocks
  }
});

const vaseMaterial = new THREE.ShaderMaterial({
  uniforms: {
    spherePosition: spherePosition,
    ticks: ticks,
    colourMap1: { type: "t", value: snow02Texture },
    colourMap2: { type: "t", value: snow03Texture },
    spherePosition: spherePosition,
    ambientColour: ambientColour,
    diffuseColour: diffuseColour,
    specularColour: vaseSpecColour,
    kAmbient: kAmbient,
    kDiffuse: kDiffuse,
    kSpecular: kSpecular,
    shininess: vaseShininess,
    ticks: ticks,
    // uTextUnit(): textureCube,
  }
});


// Load shaders
const shaderFiles = [
  'glsl/sphere.vs.glsl',
  'glsl/sphere.fs.glsl',
  'glsl/phong.vs.glsl',
  'glsl/phong.fs.glsl',
  'glsl/toon.vs.glsl',
  'glsl/toon.fs.glsl',
  'glsl/squares.vs.glsl',
  'glsl/squares.fs.glsl',
  // 'glsl/floor.vs.glsl',
  // 'glsl/floor.fs.glsl',
  'glsl/zap.vs.glsl',
  'glsl/zap.fs.glsl',
  'glsl/vase.vs.glsl',
  'glsl/vase.fs.glsl',
  'glsl/static.vs.glsl',
  'glsl/static.fs.glsl',
];

new THREE.SourceLoader().load(shaderFiles, function (shaders) {
  sphereMaterial.vertexShader = shaders['glsl/sphere.vs.glsl'];
  sphereMaterial.fragmentShader = shaders['glsl/sphere.fs.glsl'];

  phongMaterial.vertexShader = shaders['glsl/phong.vs.glsl'];
  phongMaterial.fragmentShader = shaders['glsl/phong.fs.glsl'];

  toonMaterial.vertexShader = shaders['glsl/toon.vs.glsl'];
  toonMaterial.fragmentShader = shaders['glsl/toon.fs.glsl'];

  squaresMaterial.vertexShader = shaders['glsl/squares.vs.glsl'];
  squaresMaterial.fragmentShader = shaders['glsl/squares.fs.glsl'];

  zapMaterial.vertexShader = shaders['glsl/zap.vs.glsl'];
  zapMaterial.fragmentShader = shaders['glsl/zap.fs.glsl'];
  // floorMaterial.vertexShader = shaders['glsl/floor.vs.glsl'];
  // floorMaterial.fragmentShader = shaders['glsl/floor.fs.glsl'];

  staticMaterial.vertexShader = shaders['glsl/static.vs.glsl'];
  staticMaterial.fragmentShader = shaders['glsl/static.fs.glsl'];


  vaseMaterial.vertexShader = shaders['glsl/vase.vs.glsl'];
  vaseMaterial.fragmentShader = shaders['glsl/vase.fs.glsl'];
});

// Define the shader modes
const shaders = {
  PHONG: { key: 0, material: phongMaterial },
  TOON: { key: 1, material: toonMaterial },
  SQUARES: { key: 2, material: squaresMaterial },
  VASE: { key: 3, material: vaseMaterial },
  ZAP: { key: 4, material: zapMaterial },
  STATIC: { key: 5, material: staticMaterial }
};

let mode = shaders.PHONG.key; // Default




// Set up scenes
let scenes = [];

for (let shader of Object.values(shaders)) {
  // Create the scene
  const { scene, camera, worldFrame } = createScene(canvas);


  const cubeBG = new THREE.CubeTextureLoader();
  cubeBG.setPath( 'texture/' );
  
  const textureCube = cubeBG.load( [
    'xneg.png', 'xpos.png',
    'ypos.png', 'yneg.png',
    'zpos.png', 'zneg.png'
  ] );
  
  scene.background = textureCube;



  // Create the main sphere geometry (light source)
  // https://threejs.org/docs/#api/en/geometries/SphereGeometry
  const sphereGeometry = new THREE.SphereGeometry(1.0, 32.0, 32.0);
  const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
  sphere.position.set(0.0, 1.5, 0.0);
  sphere.parent = worldFrame;
  scene.add(sphere);

  // Look at the definition of loadOBJ to familiarize yourself with
  // how each parameter affects the loaded object.
  loadAndPlaceOBJ('obj/armadillo.obj', shader.material, function (armadillo) {
    armadillo.position.set(0.0, 0.0, -15.0);
    armadillo.rotation.y = Math.PI;
    armadillo.scale.set(10, 10, 10);
    armadillo.parent = worldFrame;
    scene.add(armadillo);
  });


  loadAndPlaceOBJ('obj/vase01.obj', shader.material, function (vase) {
    vase.position.set(-10.0, -8.0, 1.0);
    vase.rotation.y = Math.PI;
    vase.scale.set(5, 5, 5);
    vase.parent = worldFrame;
    scene.add(vase);
  });
  

  //OBJLoader.load() 
  //Object3D.clone() to ref multiple objects

  // const triforce2Frame = new THREE.Object3D();
  // triforce2Frame.position.set(-s/2.0, 0.0, 3.0);
  // scene.add(triforce2Frame);

  // const triforce3Frame = new THREE.Object3D();
  // triforce3Frame.position.set(s/2.0, 0.0, 3.0);
  // scene.add(triforce3Frame);
  var triforceHeight = 18.0;
  loadAndPlaceOBJ('obj/triforce.obj', shader.material, function (triforce1) {
    let s = 6.0;
    triforce1.scale.set(s, s, s);
    triforce1.position.set(0.0, triforceHeight+ Math.sqrt((Math.pow(s,2) - Math.pow((0.5 * s),2))), 0.0);
    triforce1.parent = worldFrame;
    scene.add(triforce1);
  });

  loadAndPlaceOBJ('obj/triforce.obj', shader.material, function (triforce2) {
    let s = 6.0;
    triforce2.scale.set(s, s, s);
    triforce2.position.set(-s/2.0, triforceHeight, 0.0);
    triforce2.parent = worldFrame;
    scene.add(triforce2);
  });

  loadAndPlaceOBJ('obj/triforce.obj', shader.material, function (triforce3) {
    let s = 6.0;
    triforce3.scale.set(s, s, s);
    triforce3.position.set(s/2.0, triforceHeight, 0.0);
    triforce3.parent = worldFrame;
    scene.add(triforce3);
  });



  // const triforce2Frame = new THREE.Object3D();
  // const triforce3Frame = new THREE.Object3D();
  //  triforce2 = triforce1.clone(); 
  //  triforce3 = triforce1.clone(); 
  // triforce2.position.set(-s/2.0, 0.0, 3.0);
  // triforce3.position.set(s/2.0, 0.0, 3.0);
  // scene.add(triforce2Frame);
  // scene.add(triforce3Frame);

  // loadAndPlaceOBJ('obj/triforce.obj', shader.material, triforce1Frame, function (triforce1) {
  //   triforce1.scale.set(s, s, s);

  // });

  // loadAndPlaceOBJ('obj/triforce.obj', shader.material, triforce2Frame, function (triforce2) {
  //   triforce2.scale.set(s, s, s);
 
  // });

  // loadAndPlaceOBJ('obj/triforce.obj', shader.material, triforce3Frame, function (triforce3) {
  //   triforce3.scale.set(s, s, s);
   
  // });


  loadAndPlaceOBJ('obj/pyramid.obj', shader.material, function (pyramid) {
    let psize = 100;
    pyramid.position.set(0.0, -7.75, 0.0);
    // pyramid.rotation.y = Math.PI * -0.5; 
    // pyramid.rotateY(Math.PI * -0.5);
    pyramid.scale.set(psize, psize, psize);
    pyramid.parent = worldFrame;
    scene.add(pyramid);
  });

  // const terrainGeometry = new THREE.BoxGeometry(floorSize, floorSize, 5);
  // const terrain = new THREE.Mesh(terrainGeometry, floorMaterial);
  // terrain.position.y = -10.4;
  // terrain.rotation.set(- Math.PI / 2, 0, 0);
  // scene.add(terrain);
  
  // scene.add(sphereLight);
  scenes.push({ scene, camera });
}


// Listen to keyboard events.
const keyboard = new THREEx.KeyboardState();
function checkKeyboard() {
  if (keyboard.pressed("1"))
    mode = shaders.PHONG.key;
  else if (keyboard.pressed("2"))
    mode = shaders.TOON.key;
  else if (keyboard.pressed("3"))
    mode = shaders.SQUARES.key;
  else if (keyboard.pressed("4"))
    mode = shaders.VASE.key;
  else if (keyboard.pressed("5"))
    mode = shaders.ZAP.key;
  else if (keyboard.pressed("6"))
    mode = shaders.STATIC.key;


  if (keyboard.pressed("W"))
    spherePosition.value.z -= 0.3;
  else if (keyboard.pressed("S"))
    spherePosition.value.z += 0.3;

  if (keyboard.pressed("A"))
    spherePosition.value.x -= 0.3;
  else if (keyboard.pressed("D"))
    spherePosition.value.x += 0.3;

  if (keyboard.pressed("E"))
    spherePosition.value.y -= 0.3;
  else if (keyboard.pressed("Q"))
    spherePosition.value.y += 0.3;

    
  sphereLight.position.set(spherePosition.value.x, spherePosition.value.y, spherePosition.value.z);

  // The following tells three.js that some uniforms might have changed
  sphereMaterial.needsUpdate = true;
  phongMaterial.needsUpdate = true;
  toonMaterial.needsUpdate = true;
  squaresMaterial.needsUpdate = true;
  // floorMaterial.needsUpdate = true;
  vaseMaterial.needsUpdate = true;
  zapMaterial.needsUpdate = true;
  staticMaterial.needsUpdate = true;
}

// clock = THREE.Clock;

// Setup update callback
function update() {
  checkKeyboard();
  ticks.value += 1 / 100.0;
  tocks.value = Math.floor(ticks.value * 4.0) % 5;
  if ( (ticks - Math.floor(ticks.value)) <= 0.1 )  {
    rando.value.x = Math.random() - 0.5;
    rando.value.y = Math.random() - 0.5;
    rando.value.z = Math.random() - 0.5;
  } 

  // triforce1.rotation.x += 0.01;
  // triforce2Frame.rotation.y += 0.01;
  // triforce3Frame.rotation.z += 0.01;
  // armadilloFrame.rotation.x += 0.01;

  // Requests the next update call, this creates a loop
  requestAnimationFrame(update);
  const { scene, camera } = scenes[mode];
  renderer.render(scene, camera);
}

// Start the animation loop.
update();
