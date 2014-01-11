FW.DougsShit = class DougsShit
  constructor: ->
    @dougsCrazyShit = new THREE.Geometry
    numCircles = 100
    circleGeo = new THREE.CircleGeometry(1, 10)
    circleMat = new THREE.MeshPhongMaterial
      side: THREE.DoubleSide
    for i in [0...numCircles]
      @circleMesh = new THREE.Mesh circleGeo, circleMat
      @circleMesh.DoubleSide = true
      @circleMesh.position.set rnd(-500, 500), rnd(0, 1000) + 100, 0

      THREE.GeometryUtils.merge @dougsCrazyShit, @circleMesh
    @dougsMesh = new THREE.Mesh @dougsCrazyShit, circleMat
    FW.scene.add @dougsMesh

