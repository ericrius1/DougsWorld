(function() {
  var Wand;

  FW.Wand = Wand = (function() {
    function Wand() {
      var texture,
        _this = this;
      this.numEmitters = 200;
      this.emitterActivateFraction = 0.2;
      this.spellEmitters = [];
      this.startingPos = new THREE.Vector3(rnd(-500, 500), 220, rnd(-500, 500));
      texture = THREE.ImageUtils.loadTexture('assets/smokeparticle.png');
      texture.magFilter = THREE.LinearMipMapLinearFilter;
      texture.minFilter = THREE.LinearMipMapLinearFilter;
      this.spellGroup = new ShaderParticleGroup({
        texture: texture,
        maxAge: 10
      });
      this.initializeSpells();
      $('body')[0].on('mousedown', function(event) {
        console.log("MOUSE X", event.clientX);
        return _this.castSpell();
      });
      $('body')[0].on('mouseup', function() {
        return _this.endSpell();
      });
      FW.scene.add(this.spellGroup.mesh);
    }

    Wand.prototype.initializeSpells = function() {
      var colorEnd, colorStart, i, spellEmitter, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = this.numEmitters; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        colorStart = new THREE.Color();
        colorStart.setRGB(Math.random(), Math.random(), Math.random());
        colorEnd = new THREE.Color();
        colorEnd.setRGB(Math.random(), Math.random(), Math.random());
        spellEmitter = new ShaderParticleEmitter({
          size: 30,
          sizeEnd: 40,
          position: this.startingPos,
          positionSpread: new THREE.Vector3(1, 1, 1),
          acceleration: new THREE.Vector3(rnd(-30, 30), rnd(-30, 30), rnd(-30, 30)),
          colorStart: colorStart,
          colorEnd: colorEnd,
          particlesPerSecond: 40,
          velocity: new THREE.Vector3(rnd(-100, 100), 0, rnd(-100, 100)),
          opacityEnd: 1
        });
        this.spellGroup.addEmitter(spellEmitter);
        this.spellEmitters.push(spellEmitter);
        _results.push(spellEmitter.disable());
      }
      return _results;
    };

    Wand.prototype.castSpell = function() {
      var playerPos, spellEmitter, _i, _len, _ref, _results;
      _ref = this.spellEmitters;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        spellEmitter = _ref[_i];
        playerPos = FW.controls.getPosition();
        if (Math.random() < this.emitterActivateFraction) {
          _results.push(spellEmitter.enable());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Wand.prototype.endSpell = function() {
      var spellEmitter, _i, _len, _ref, _results;
      _ref = this.spellEmitters;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        spellEmitter = _ref[_i];
        _results.push(spellEmitter.disable());
      }
      return _results;
    };

    Wand.prototype.update = function() {
      return this.spellGroup.tick();
    };

    return Wand;

  })();

}).call(this);
