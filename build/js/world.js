(function() {
  var World,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  FW.World = World = (function() {
    function World() {
      this.animate = __bind(this.animate, this);
      var aMeshMirror, fragmentShader, light, shaderMat, vertexShader, waterNormals, wizardGeo, wizardMesh,
        _this = this;
      FW.clock = new THREE.Clock();
      this.SCREEN_WIDTH = window.innerWidth;
      this.SCREEN_HEIGHT = window.innerHeight;
      this.camFar = 200000;
      FW.width = 10000;
      FW.camera = new THREE.PerspectiveCamera(45.0, this.SCREEN_WIDTH / this.SCREEN_HEIGHT, 1, this.camFar);
      FW.camera.position.set(0, 600, 2200);
      this.controls = new THREE.OrbitControls(FW.camera);
      FW.scene = new THREE.Scene();
      FW.Renderer = new THREE.WebGLRenderer();
      FW.Renderer.setSize(this.SCREEN_WIDTH, this.SCREEN_HEIGHT);
      document.body.appendChild(FW.Renderer.domElement);
      light = new THREE.DirectionalLight(0xff00ff, 2);
      FW.scene.add(light);
      this.uniforms = {
        count: {
          type: "i",
          value: 1
        }
      };
      vertexShader = document.getElementById('vertexShader').textContent;
      fragmentShader = document.getElementById('fragmentShader').textContent;
      shaderMat = new THREE.ShaderMaterial({
        uniforms: this.uniforms,
        vertexShader: vertexShader,
        fragmentShader: fragmentShader
      });
      wizardGeo = new THREE.PlaneGeometry(100, 100);
      wizardMesh = new THREE.Mesh(wizardGeo, shaderMat);
      wizardMesh.scale.set(1000, 1000, 1000);
      FW.scene.add(wizardMesh);
      waterNormals = new THREE.ImageUtils.loadTexture('./assets/waternormals.jpg');
      waterNormals.wrapS = waterNormals.wrapT = THREE.RepeatWrapping;
      this.water = new THREE.Water(FW.Renderer, FW.camera, FW.scene, {
        textureWidth: 512,
        textureHeight: 512,
        waterNormals: waterNormals,
        alpha: 1.0,
        distortionScale: 20
      });
      aMeshMirror = new THREE.Mesh(new THREE.PlaneGeometry(FW.width, FW.width, 50, 50), this.water.material);
      aMeshMirror.add(this.water);
      aMeshMirror.rotation.x = -Math.PI * 0.5;
      FW.scene.add(aMeshMirror);
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
      this.water.material.uniforms.time.value += 1.0 / 60;
      this.controls.update();
      return this.render();
    };

    World.prototype.render = function() {
      var delta;
      delta = FW.clock.getDelta();
      this.uniforms.count.value++;
      this.water.render();
      return FW.Renderer.render(FW.scene, FW.camera);
    };

    return World;

  })();

}).call(this);
