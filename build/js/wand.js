(function() {
  var Wand;

  FW.Wand = Wand = (function() {
    function Wand() {
      var _this = this;
      this.spellGroup = new ShaderParticleGroup({
        texture: THREE.ImageUtils.loadTexture('assets/smokeparticle.png')
      });
      this.initializeSpell();
      $('body')[0].on('mousedown', function() {
        _this.spellEmitter.enable();
        _this.spellEmitter.position = FW.controls.getPosition();
        return console.log(_this.spellEmitter.position);
      });
      $('body')[0].on('mouseup', function() {
        return _this.spellEmitter.disable();
      });
      FW.scene.add(this.spellGroup.mesh);
    }

    Wand.prototype.initializeSpell = function() {
      this.spellEmitter = new ShaderParticleEmitter({
        size: 100,
        particlesPerSecond: 10,
        position: new THREE.Vector3(100, 100, 100)
      });
      this.spellGroup.addEmitter(this.spellEmitter);
      return this.spellEmitter.disable();
    };

    Wand.prototype.update = function() {
      return this.spellGroup.tick(.16);
    };

    return Wand;

  })();

}).call(this);
