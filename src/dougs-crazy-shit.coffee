FW.DougsShit = class DougsShit
  constructor: ->
    @dougsCrazyShit = []
    @rotationSpeed = 0.0005
    @numLayers = 10
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
      geoLayer = new THREE.CircleGeometry 3 * i, 10
      layerMesh = new THREE.ParticleSystem geoLayer, @shaderMaterial
      layerMesh.position.z = -60
      FW.scene.add layerMesh
      layer = 
        mesh: layerMesh
        rotationSpeed: @rotationSpeed * ( i * .3)
      @dougsCrazyShit.push layer



    
  update: ->
    for layer in @dougsCrazyShit
      layer.mesh.rotation.z += layer.rotationSpeed 


