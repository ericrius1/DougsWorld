(function() {
  var World,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  FW.World = World = (function() {
    function World() {
      this.animate = __bind(this.animate, this);
      var light1, light2,
        _this = this;
      FW.clock = new THREE.Clock();
      this.SCREEN_WIDTH = window.innerWidth;
      this.SCREEN_HEIGHT = window.innerHeight;
      this.camFar = 200000;
      FW.width = 10000;
      FW.camera = new THREE.PerspectiveCamera(45.0, this.SCREEN_WIDTH / this.SCREEN_HEIGHT, 1, this.camFar);
      FW.camera.position.set(0, 10, 2750);
      this.controls = new THREE.OrbitControls(FW.camera);
      FW.scene = new THREE.Scene();
      FW.Renderer = new THREE.WebGLRenderer();
      FW.Renderer.setSize(this.SCREEN_WIDTH, this.SCREEN_HEIGHT);
      document.body.appendChild(FW.Renderer.domElement);
      light1 = new THREE.DirectionalLight(0xffffff, 0.5);
      light1.position.set(1, 1, 1);
      FW.scene.add(light1);
      light2 = new THREE.DirectionalLight(0xffffff, 1.5);
      light2.position.set(0, -1, 0);
      FW.scene.add(light2);
      this.generateNodes();
      window.addEventListener("resize", (function() {
        return _this.onWindowResize();
      }), false);
    }

    World.prototype.onWindowResize = function(event) {
      this.SCREEN_WIDTH = window.innerWidth;
      this.SCREEN_HEIGHT = window.innerHeight;
      FW.Renderer.setSize(this.SCREEN_WIDTH, this.SCREEN_HEIGHT);
      FW.camera.aspect = this.SCREEN_WIDTH / this.SCREEN_HEIGHT;
      return FW.camera.updateProjectionMatrix();
    };

    World.prototype.animate = function() {
      var delta, time;
      requestAnimationFrame(this.animate);
      delta = FW.clock.getDelta();
      time = Date.now();
      this.controls.update();
      return this.render();
    };

    World.prototype.render = function() {
      var delta;
      delta = FW.clock.getDelta();
      return FW.Renderer.render(FW.scene, FW.camera);
    };

    World.prototype.generateNodes = function() {
      var circleGeo, circleMat, circleMesh, dougsCrazyShit, i, numCircles, _i;
      dougsCrazyShit = new THREE.Geometry;
      numCircles = 100;
      circleGeo = new THREE.CircleGeometry(1);
      circleMat = new THREE.MeshBasicMaterial();
      for (i = _i = 0; 0 <= numCircles ? _i < numCircles : _i > numCircles; i = 0 <= numCircles ? ++_i : --_i) {
        circleMesh = new THREE.Mesh(circleGeo);
        circleMesh.position.set(rnd(-1000, 1000), rnd(-1000, 1000), 0);
        THREE.GeometryUtils.merge(dougsCrazyShit, circleMesh);
      }
      return FW.scene.add(new THREE.Mesh(dougsCrazyShit, new THREE.MeshBasicMaterial()));
    };

    return World;

  })();

}).call(this);
