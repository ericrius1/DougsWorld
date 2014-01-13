(function() {
  var DougsShit;

  FW.DougsShit = DougsShit = (function() {
    function DougsShit() {
      var attributes, uniforms;
      this.dougsCrazyShit = [];
      this.startRotationSpeed = .02;
      this.endRotationSpeed = .005;
      this.zRotationStart = 0;
      this.zRotationEnd = 2 * Math.PI;
      this.startRadius = 5;
      this.endRadius = 50;
      this.numLayers = 20;
      this.startSegments = 10;
      this.endSegments = 100;
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
      var dougsCrazyGeometry, geoLayer, i, layer, layerMesh, _i, _ref, _results;
      dougsCrazyGeometry = new THREE.Geometry();
      _results = [];
      for (i = _i = 1, _ref = this.numLayers; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        console.log('wah');
        this.radius = map(i, 1, this.numLayers, this.startRadius, this.endRadius);
        this.numSegments = Math.floor(map(i, 1, this.numLayers, this.startSegments, this.endSegments));
        geoLayer = new THREE.CircleGeometry(this.radius, this.numSegments);
        layerMesh = new THREE.ParticleSystem(geoLayer, this.shaderMaterial);
        layerMesh.position.z = -100;
        layerMesh.position.y = 40;
        FW.scene.add(layerMesh);
        layer = {
          mesh: layerMesh,
          rotationSpeed: map(i, 1, this.numLayers, this.startRotationSpeed, this.endRotationSpeed)
        };
        _results.push(this.dougsCrazyShit.push(layer));
      }
      return _results;
    };

    DougsShit.prototype.update = function() {
      var layer, _i, _len, _ref, _results;
      _ref = this.dougsCrazyShit;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        layer = _ref[_i];
        _results.push(layer.mesh.rotation.z -= layer.rotationSpeed);
      }
      return _results;
    };

    return DougsShit;

  })();

}).call(this);
