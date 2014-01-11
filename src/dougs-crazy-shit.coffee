FW.DougsShit = class DougsShit
  constructor: ->
    @dougsCrazyGeo = new THREE.Geometry
    numCircles = 1000
    circleGeo = new THREE.CircleGeometry(10, 100)
    circleMat = new THREE.MeshBasicMaterial
      color: 0xff00ff
      side: THREE.DoubleSide
    for i in [0...numCircles]
      circleMesh = new THREE.Mesh circleGeo, circleMat
      circleMesh.DoubleSide = true
      circleMesh.position.set rnd(-500, 500), rnd(0, 1000) + 100, 0
      # FW.scene.add circleMesh
      THREE.GeometryUtils.merge @dougsCrazyGeo, circleMesh
    @dougsCrazyShit = new THREE.Mesh @dougsCrazyGeo, circleMat
    FW.scene.add @dougsCrazyShit

