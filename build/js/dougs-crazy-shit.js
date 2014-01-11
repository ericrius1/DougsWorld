(function() {
  var DougsShit;

  FW.DougsShit = DougsShit = (function() {
    function DougsShit() {
      var circleGeo, circleMat, i, numCircles, _i;
      this.dougsCrazyShit = new THREE.Geometry;
      numCircles = 100;
      circleGeo = new THREE.CircleGeometry(1, 10);
      circleMat = new THREE.MeshPhongMaterial({
        side: THREE.DoubleSide
      });
      for (i = _i = 0; 0 <= numCircles ? _i < numCircles : _i > numCircles; i = 0 <= numCircles ? ++_i : --_i) {
        this.circleMesh = new THREE.Mesh(circleGeo, circleMat);
        this.circleMesh.DoubleSide = true;
        this.circleMesh.position.set(rnd(-500, 500), rnd(0, 1000) + 100, 0);
        THREE.GeometryUtils.merge(this.dougsCrazyShit, this.circleMesh);
      }
      this.dougsMesh = new THREE.Mesh(this.dougsCrazyShit, circleMat);
      FW.scene.add(this.dougsMesh);
    }

    return DougsShit;

  })();

}).call(this);
