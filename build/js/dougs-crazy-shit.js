(function() {
  var DougsShit;

  FW.DougsShit = DougsShit = (function() {
    function DougsShit() {
      var circleGeo, circleMat, circleMesh, i, numCircles, _i;
      this.dougsCrazyGeo = new THREE.Geometry;
      numCircles = 1000;
      circleGeo = new THREE.CircleGeometry(10, 100);
      circleMat = new THREE.MeshBasicMaterial({
        color: 0xff00ff,
        side: THREE.DoubleSide
      });
      for (i = _i = 0; 0 <= numCircles ? _i < numCircles : _i > numCircles; i = 0 <= numCircles ? ++_i : --_i) {
        circleMesh = new THREE.Mesh(circleGeo, circleMat);
        circleMesh.DoubleSide = true;
        circleMesh.position.set(rnd(-500, 500), rnd(0, 1000) + 100, 0);
        THREE.GeometryUtils.merge(this.dougsCrazyGeo, circleMesh);
      }
      this.dougsCrazyShit = new THREE.Mesh(this.dougsCrazyGeo, circleMat);
      FW.scene.add(this.dougsCrazyShit);
    }

    return DougsShit;

  })();

}).call(this);
