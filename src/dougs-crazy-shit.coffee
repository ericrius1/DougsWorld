FW.DougsShit = class DougsShit
  constructor: ->
    @dougsCrazyShit = []
    @startRotationSpeed = .02
    @endRotationSpeed = .005
    @zRotationStart = 0
    @zRotationEnd = 2 * Math.PI
    @startRadius = 5
    @endRadius = 50
    @numLayers = 20
    @startSegments = 10
    @endSegments = 100
    @width = 1
    @height = 1
    @squareGeo = new THREE.PlaneGeometry(1, 1)
    @materials = []
    @placeNodes()


    attributes = 
        size:  type: 'f', value: [] 
        ca:    type: 'c', value: [] 

    uniforms = 
      amplitude: type: "f", value: 1.0 
      color:     type: "c", value: new THREE.Color( 0xffffff )
      texture:   type: "t", value: THREE.ImageUtils.loadTexture( "assets/square-outline.png" )

    uniforms.texture.value.wrapS = uniforms.texture.value.wrapT = THREE.RepeatWrapping

    @shaderMaterial = new THREE.ShaderMaterial
      uniforms:     uniforms
      attributes:     attributes
      vertexShader:   document.getElementById( 'vertexshader' ).textContent
      fragmentShader: document.getElementById( 'fragmentshader' ).textContent
      transparent:  true

  placeNodes: ->
    dougsCrazyGeometry = new THREE.Geometry()

    for i in [1..@numLayers]
      console.log 'wah'
      @radius = map(i, 1, @numLayers, @startRadius, @endRadius)
      @numSegments = Math.floor(map(i, 1, @numLayers, @startSegments, @endSegments))
      geoLayer = new THREE.CircleGeometry @radius, @numSegments
      layerMesh = new THREE.ParticleSystem geoLayer, @shaderMaterial
      layerMesh.position.z = -100
      layerMesh.position.y = 40
      FW.scene.add layerMesh
      layer = 
        mesh: layerMesh
        rotationSpeed: map(i, 1, @numLayers, @startRotationSpeed, @endRotationSpeed)
      @dougsCrazyShit.push layer



    
  update: ->
    for layer in @dougsCrazyShit
      layer.mesh.rotation.z -= layer.rotationSpeed 


