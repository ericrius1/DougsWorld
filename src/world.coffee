
FW.World = class World
  constructor : ->
    FW.clock = new THREE.Clock()
    @SCREEN_WIDTH = window.innerWidth
    @SCREEN_HEIGHT = window.innerHeight
    @camFar = 200000
    FW.width = 10000

    # CAMERA
    FW.camera = new THREE.PerspectiveCamera(45.0, @SCREEN_WIDTH / @SCREEN_HEIGHT, 1, @camFar)
    FW.camera.position.set  0, 10, 2750
    
    #CONTROLS
    @controls = new THREE.OrbitControls(FW.camera)

    # SCENE 
    FW.scene = new THREE.Scene()



    # RENDERER
    FW.Renderer = new THREE.WebGLRenderer()
    FW.Renderer.setSize @SCREEN_WIDTH, @SCREEN_HEIGHT
    document.body.appendChild FW.Renderer.domElement

    #LIGHTING
    light1 = new THREE.DirectionalLight( 0xffffff, 0.5 );
    light1.position.set( 1, 1, 1 );
    FW.scene.add( light1 );

    light2 = new THREE.DirectionalLight( 0xffffff, 1.5 );
    light2.position.set( 0, -1, 0 );
    FW.scene.add( light2 );

    @generateNodes()

    #WATER
    waterNormals = new THREE.ImageUtils.loadTexture './assets/waternormals.jpg'
    waterNormals.wrapS = waterNormals.wrapT = THREE.RepeatWrapping
    @water = new THREE.Water FW.Renderer, FW.camera, FW.scene,
      textureWidth: 512
      textureHeight: 512
      waterNormals: waterNormals
      alpha: 1.0
      distortionScale: 20

    aMeshMirror = new THREE.Mesh(
      new THREE.PlaneGeometry FW.width, FW.width, 50, 50
      @water.material
    )
    aMeshMirror.add @water
    aMeshMirror.rotation.x = -Math.PI * 0.5
    FW.scene.add aMeshMirror

    # EVENTS
    window.addEventListener "resize", (=>
      @onWindowResize()
    ), false

  
  onWindowResize : (event) ->
    @SCREEN_WIDTH = window.innerWidth
    @SCREEN_HEIGHT = window.innerHeight
    FW.Renderer.setSize @SCREEN_WIDTH, @SCREEN_HEIGHT
    FW.camera.aspect = @SCREEN_WIDTH / @SCREEN_HEIGHT
    FW.camera.updateProjectionMatrix()

  animate : =>
    requestAnimationFrame @animate
    delta = FW.clock.getDelta()
    time = Date.now()
    @water.material.uniforms.time.value += 1.0 / 60
    @controls.update()
    @render()
  render : ->
    delta = FW.clock.getDelta()
    @water.render()
    FW.Renderer.render( FW.scene, FW.camera );

  generateNodes: ->
    triangles = 160000;

    geometry = new THREE.BufferGeometry();

    geometry.addAttribute( 'index', Uint16Array, triangles * 3, 1 );
    geometry.addAttribute( 'position', Float32Array, triangles * 3, 3 );
    geometry.addAttribute( 'normal', Float32Array, triangles * 3, 3 );
    geometry.addAttribute( 'color', Float32Array, triangles * 3, 3 );

    # # break geometry into
    # # chunks of 21,845 triangles (3 unique vertices per triangle)
    # # for indices to fit into 16 bit integer number
    # # floor(2^16 / 3) = 21845

    chunkSize = 21845;

    indices = geometry.attributes.index.array

    for i in [0...indices.length]
      indices[ i ] = i % ( 3 * chunkSize )

    positions = geometry.attributes.position.array;
    normals = geometry.attributes.normal.array;
    colors = geometry.attributes.color.array;

    color = new THREE.Color()

    n = 800 
    n2 = n/2  # triangles spread in the cube
    d = 1
    d2 = d/2 # individual triangle size

    pA = new THREE.Vector3();
    pB = new THREE.Vector3();
    pC = new THREE.Vector3();

    cb = new THREE.Vector3();
    ab = new THREE.Vector3();

    for i in [0...positions.length] by 9

      # positions

      x = Math.random() * n - n2;
      y = Math.random() * n - n2;
      z = Math.random() * n - n2;

      ax = x + Math.random() * d - d2;
      ay = y + Math.random() * d - d2;
      az = z + Math.random() * d - d2;

      bx = x + Math.random() * d - d2;
      byy = y + Math.random() * d - d2;
      bz = z + Math.random() * d - d2;

      cx = x + Math.random() * d - d2;
      cy = y + Math.random() * d - d2;
      cz = z + Math.random() * d - d2;

      positions[ i ]     = ax;
      positions[ i + 1 ] = ay;
      positions[ i + 2 ] = az;

      positions[ i + 3 ] = bx;
      positions[ i + 4 ] = byy;
      positions[ i + 5 ] = bz;

      positions[ i + 6 ] = cx;
      positions[ i + 7 ] = cy;
      positions[ i + 8 ] = cz;

      # flat face normals

      pA.set( ax, ay, az );
      pB.set( bx, byy, bz );
      pC.set( cx, cy, cz );

      cb.subVectors( pC, pB );
      ab.subVectors( pA, pB );
      cb.cross( ab );

      cb.normalize();

      nx = cb.x;
      ny = cb.y;
      nz = cb.z;

      normals[ i ]     = nx;
      normals[ i + 1 ] = ny;
      normals[ i + 2 ] = nz;

      normals[ i + 3 ] = nx;
      normals[ i + 4 ] = ny;
      normals[ i + 5 ] = nz;

      normals[ i + 6 ] = nx;
      normals[ i + 7 ] = ny;
      normals[ i + 8 ] = nz;

      # colors

      vx = ( x / n ) + 0.5;
      vy = ( y / n ) + 0.5;
      vz = ( z / n ) + 0.5;

      color.setRGB( vx, vy, vz );

      colors[ i ]     = color.r;
      colors[ i + 1 ] = color.g;
      colors[ i + 2 ] = color.b;

      colors[ i + 3 ] = color.r;
      colors[ i + 4 ] = color.g;
      colors[ i + 5 ] = color.b;

      colors[ i + 6 ] = color.r;
      colors[ i + 7 ] = color.g;
      colors[ i + 8 ] = color.b;


    geometry.offsets = [];

    offsets = triangles / chunkSize;

    for i in [0...offsets]
      offset = 
        start: i * chunkSize * 3,
        index: i * chunkSize * 3,
        count: Math.min( triangles - ( i * chunkSize ), chunkSize ) * 3
      geometry.offsets.push( offset );

    geometry.computeBoundingSphere();

    material = new THREE.MeshPhongMaterial
      color: 0xaaaaaa 
      ambient: 0xaaaaaa
      specular: 0xffffff 
      shininess: 250 
      side: THREE.DoubleSide 
      vertexColors:  THREE.VertexColors
     

    mesh = new THREE.Mesh( geometry, material) 
    FW.scene.add( mesh )

    # FW.scene.add new THREE.Mesh new THREE.SphereGeometry(), new THREE.MeshBasicMaterial()