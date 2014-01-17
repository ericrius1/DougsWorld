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
        return _this.spellEmitter.enable();
      });
      $('body')[0].on('mouseup', function() {
        return _this.spellEmitter.disable();
      });
      FW.scene.add(this.spellGroup.mesh);
    }

    Wand.prototype.initializeSpell = function() {
      this.spellEmitter = new ShaderParticleEmitter({
        size: 100,
        particlesPerSecond: 10
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
