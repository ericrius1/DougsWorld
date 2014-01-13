(function() {
  var DougsShit;

  FW.DougsShit = DougsShit = (function() {
    function DougsShit() {
      var attributes, uniforms;
      this.numLayers = 50;
      this.width = 1;
      this.height = 1;
      this.squareGeo = new THREE.PlaneGeometry(1, 1);
      this.materials = [];
      this.placeNodes();
      attributes = {
        size: {
          type: 'f',
          value: []
        },
        ca: {
          type: 'c',
          value: []
        }
      };
      uniforms = {
        amplitude: {
          type: "f",
          value: 1.0
        },
        color: {
          type: "c",
          value: new THREE.Color(0xffffff)
        },
        texture: {
          type: "t",
          value: THREE.ImageUtils.loadTexture("assets/square-outline.png")
        }
      };
      uniforms.texture.value.wrapS = uniforms.texture.value.wrapT = THREE.RepeatWrapping;
      this.shaderMaterial = new THREE.ShaderMaterial({
        uniforms: uniforms,
        attributes: attributes,
        vertexShader: document.getElementById('vertexshader').textContent,
        fragmentShader: document.getElementById('fragmentshader').textContent,
        transparent: true
      });
    }

    DougsShit.prototype.placeNodes = function() {
      var geometry;
      geometry = new THREE.CircleGeometry(50, 100);
      this.dougsCrazyShit = new THREE.ParticleSystem(geometry, this.shaderMaterial);
      this.dougsCrazyShit.position.z = -100;
      return FW.scene.add(this.dougsCrazyShit);
    };

    DougsShit.prototype.update = function() {
      return this.dougsCrazyShit.rotation.x += .01;
    };

    return DougsShit;

  })();

}).call(this);
