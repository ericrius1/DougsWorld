FW.Wand = class Wand
  constructor: ->
    @numEmitters = 200
    @emitterActivateFraction = 0.2
    @spellEmitters = []
    @startingPos = new THREE.Vector3 rnd(-500, 500), 220, rnd(-500, 500)


    texture = THREE.ImageUtils.loadTexture('assets/smokeparticle.png')
    texture.magFilter = THREE.LinearMipMapLinearFilter;
    texture.minFilter = THREE.LinearMipMapLinearFilter;

    @spellGroup = new ShaderParticleGroup
      texture: texture
      maxAge: 10

    @initializeSpells()
    $('body')[0].on 'mousedown', (event)=>
      console.log "MOUSE X", event.clientX
      @castSpell()
    $('body')[0].on 'mouseup', =>
      @endSpell()
    FW.scene.add(@spellGroup.mesh)
  initializeSpells: ->
    for i in [0...@numEmitters]
      colorStart = new THREE.Color()
      colorStart.setRGB Math.random(), Math.random(), Math.random()
      colorEnd = new THREE.Color()
      colorEnd.setRGB Math.random(), Math.random(), Math.random()
      spellEmitter = new ShaderParticleEmitter
        size: 30
        sizeEnd: 40
        position: @startingPos
        positionSpread: new THREE.Vector3(1, 1, 1)
        acceleration:  new THREE.Vector3 rnd(-30, 30), rnd(-30, 30), rnd(-30, 30)
        colorStart: colorStart
        colorEnd: colorEnd
        particlesPerSecond: 40
        velocity: new THREE.Vector3 rnd(-100, 100), 0, rnd(-100, 100)
        opacityEnd: 1

      @spellGroup.addEmitter spellEmitter
      @spellEmitters.push spellEmitter
      spellEmitter.disable()

#velocity at start over accel at start is time of flight

  castSpell: ->
    for spellEmitter in @spellEmitters
      playerPos = FW.controls.getPosition()
      if Math.random() < @emitterActivateFraction
        spellEmitter.enable()

  endSpell: ->
    for spellEmitter in @spellEmitters
      spellEmitter.disable()




  update: ->
    @spellGroup.tick()




  



