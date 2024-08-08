/**
* UBC CPSC 314
* Assignment 4 Template setup
*/

/**
* Sets up the THREE.js WebGL renderer and canvas
*/
function setup() {
  // Check WebGL Version
  if (!WEBGL.isWebGL2Available()) {
    document.body.appendChild(WEBGL.getWebGL2ErrorMessage());
  }

  // Get the canvas element and its drawing context from the HTML document.
  const canvas = document.getElementById('webglcanvas');
  const context = canvas.getContext('webgl2');

  // Construct a THREEjs renderer from the canvas and context.
  const container = document.createElement('div');
  document.body.appendChild( container );
  const renderer = new THREE.WebGLRenderer({ canvas, context, antialias: true });
  renderer.setClearColor(0X80CEE1); // blue background colour
  renderer.setPixelRatio( window.devicePixelRatio );
  renderer.setSize( window.innerWidth, window.innerHeight );
  container.appendChild( renderer.domElement );

  return {
    renderer,
    canvas,
  };
}

/**
 * Creates a render target to use for multi-pass rendering.
 * Depth texture enabled for shadow mapping
 */
 function setupRenderTarget(renderDepth) {

  const rt = new THREE.WebGLRenderTarget( window.innerWidth, window.innerHeight );
  rt.texture.format = THREE.RGBFormat;
  rt.texture.minFilter = THREE.NearestFilter;
  rt.texture.magFilter = THREE.NearestFilter;
  rt.texture.generateMipmaps = false;
  rt.depthBuffer = renderDepth;
  rt.depthTexture = new THREE.DepthTexture();
  return rt;
}

function altsetupRenderTarget(w, h) {
  let type = THREE.FloatType;
  if( renderer.extensions.get( 'OES_texture_float_linear' ) === null ) type = THREE.HalfFloatType;

  let renderTarget = new THREE.WebGLRenderTarget( 1, 1, {
    type,
    wrapS: THREE.ClampToEdgeWrapping,
    wrapT: THREE.ClampToEdgeWrapping,
    format: THREE.RGBAFormat,
    minFilter: THREE.NearestFilter,
    magFilter: THREE.NearestFilter,
    stencilBuffer: false,
    depthBuffer: true
  });

  renderTarget.texture.generateMipmaps = false;
  renderTarget.setSize(w, h);

  return renderTarget;
}

/**
* Creates a basic scene and returns necessary objects
* to manipulate the scene, camera and render context.
*/
function createScene(canvas) {
  // Create THREE.js scene
  const scene = new THREE.Scene();

  // Canvas params
  var w = window.innerWidth;
  var h = window.innerHeight;
  var aspect = w / h;
  
  // Set up the camera.
  const camera = new THREE.PerspectiveCamera(30.0, 1.0, 0.1, 1000.0); // view angle, aspect ratio, near, far
  camera.position.set(0.0, 30.0, 80.0);
  camera.lookAt(scene.position);
  scene.add(camera);

  // For shadow-pass
  // Smaller denom = wider camera = less pixels contain scene geometry = fewer samples for depth map = more jaggies in shadows
  const denom = 16;
  const shadowCam = new THREE.OrthographicCamera(-window.innerWidth / denom, window.innerWidth / denom, window.innerHeight / denom, -window.innerHeight / denom, 1, 1000.0);
  
  const renderTarget = setupRenderTarget(true);
  const renderTarget2 = altsetupRenderTarget(w, h);
  const renderTarget3 = altsetupRenderTarget(w, h);
  
  // Setup orbit controls for the camera.
  const controls = new THREE.OrbitControls(camera, canvas);
  controls.damping = 0.2;
  controls.autoRotate = false;
  
  // Update projection matrix based on the windows size.
  function resize() {
    renderer.setSize(window.innerWidth, window.innerHeight);
    const dpr = renderer.getPixelRatio();
    
    renderTarget.setSize( window.innerWidth * dpr, window.innerHeight * dpr );

    renderTarget2.setSize( window.innerWidth * dpr, window.innerHeight * dpr );

    renderTarget3.setSize( window.innerWidth * dpr, window.innerHeight * dpr );

    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    shadowCam.left = -window.innerWidth / denom;
    shadowCam.right = window.innerWidth / denom;
    shadowCam.top = window.innerHeight / denom;
    shadowCam.bottom = -window.innerHeight / denom;
    shadowCam.updateProjectionMatrix();
  }
  window.addEventListener('resize', resize);
  resize();
  
  // World Coordinate Frame: other objects are defined with respect to it.
  const worldFrame = new THREE.AxesHelper(1);
  scene.add(worldFrame);

  return {
    scene,
    renderTarget,
    camera,
    shadowCam,
    worldFrame,
    renderTarget2,
    renderTarget3
  };
}

/**
* Utility function that loads obj files using THREE.OBJLoader
* and places them in the scene using the given callback `place`.
* 
* The variable passed into the place callback is a THREE.Object3D.
*/
function loadAndPlaceOBJ(file, material, place) {
  const manager = new THREE.LoadingManager();
  manager.onProgress = function (item, loaded, total) {
      console.log(item, loaded, total);
  };

  const onProgress = function (xhr) {
      if (xhr.lengthComputable) {
          const percentComplete = xhr.loaded / xhr.total * 100.0;
          console.log(Math.round(percentComplete, 2) + '% downloaded');
      }
  };

  const loader = new THREE.OBJLoader(manager);
  loader.load(file, function (object) {
      object.traverse(function (child) {
          if (child instanceof THREE.Mesh) {
              child.material = material;
          }
      });
      place(object);
  }, onProgress);
}