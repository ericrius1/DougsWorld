
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
    # waterNormals = new THREE.ImageUtils.loadTexture './assets/waternormals.jpg'
    # waterNormals.wrapS = waterNormals.wrapT = THREE.RepeatWrapping
    # @water = new THREE.Water FW.Renderer, FW.camera, FW.scene,
    #   textureWidth: 512
    #   textureHeight: 512
    #   waterNormals: waterNormals
    #   alpha: 1.0
    #   distortionScale: 20

    # aMeshMirror = new THREE.Mesh(
    #   new THREE.PlaneGeometry FW.width, FW.width, 50, 50
    #   @water.material
    # )
    # aMeshMirror.add @water
    # aMeshMirror.rotation.x = -Math.PI * 0.5
    # FW.scene.add aMeshMirror

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
    # @water.material.uniforms.time.value += 1.0 / 60
    @controls.update()
    @render()
  render : ->
    delta = FW.clock.getDelta()
    # @water.render()
    FW.Renderer.render( FW.scene, FW.camera );

  generateNodes: ->
    dougsCrazyShit = new THREE.Geometry
    numCircles = 100
    circleGeo = new THREE.CircleGeometry(1)
    circleMat = new THREE.MeshBasicMaterial()
    for i in [0...numCircles]
      circleMesh = new THREE.Mesh circleGeo
      circleMesh.position.set rnd(-1000, 1000), rnd(-1000, 1000), 0
      THREE.GeometryUtils.merge dougsCrazyShit, circleMesh
    FW.scene.add new THREE.Mesh dougsCrazyShit, new THREE.MeshBasicMaterial()




    # FW.scene.add new THREE.Mesh new THREE.SphereGeometry(), new THREE.MeshBasicMaterial()