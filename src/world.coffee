
FW.World = class World
  constructor : ->
    FW.clock = new THREE.Clock()
    @SCREEN_WIDTH = window.innerWidth
    @SCREEN_HEIGHT = window.innerHeight
    @camFar = 200000
    FW.width = 10000

    # CAMERA
    FW.camera = new THREE.PerspectiveCamera(45.0, @SCREEN_WIDTH / @SCREEN_HEIGHT, 1, @camFar)
    FW.camera.position.set  0, 600, 2200
    
    #CONTROLS
    @controls = new THREE.OrbitControls(FW.camera)

    # SCENE 
    FW.scene = new THREE.Scene()



    # RENDERER
    FW.Renderer = new THREE.WebGLRenderer()
    FW.Renderer.setSize @SCREEN_WIDTH, @SCREEN_HEIGHT
    document.body.appendChild FW.Renderer.domElement

    #LIGHTING
    light = new THREE.DirectionalLight 0xff00ff, 2
    FW.scene.add light

    #WIZARD PAINTING
    @uniforms = 
      count: type: "i", value: 1

    vertexShader = document.getElementById( 'vertexShader' ).textContent
    fragmentShader = document.getElementById( 'fragmentShader' ).textContent 
    shaderMat = new THREE.ShaderMaterial uniforms: @uniforms, vertexShader: vertexShader, fragmentShader: fragmentShader
    wizardGeo = new THREE.PlaneGeometry 100, 100
    wizardMesh = new THREE.Mesh(wizardGeo, shaderMat)
    wizardMesh.scale.set 1000, 1000, 1000
    FW.scene.add wizardMesh

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
    @uniforms.count.value++
    @water.render()
    FW.Renderer.render( FW.scene, FW.camera );

