FW.DougsShit = class DougsShit
  constructor: ->
    @numLayers = 50
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
    geometry = new THREE.CircleGeometry(50, 100)


    @dougsCrazyShit = new THREE.ParticleSystem(geometry, @shaderMaterial)
    @dougsCrazyShit.position.z = -100

    FW.scene.add @dougsCrazyShit


    
  update: ->
    @dougsCrazyShit.rotation.x +=.01


