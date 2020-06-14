import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:race_game/components/street.dart';

import '../main.dart';

class BounceHeroBike extends SpriteComponent {
  Size dimensions;
  bool explode = false;
  BounceHeroBike(this.dimensions) : super.rectangle(80, 150, 'hero.png');
  double maxY;
  bool remove = false;
  double pos = 40;

  @override
  void update(double t) {
    x = game.bikePos ? dimensions.width - 100 : 40;
    if (game.heroComponent.explode) {
      print("exploded");
    }
    super.update(t);
  }

  @override
  bool destroy() {
    if (game.heroComponent.explode) {
      return true;
    }
    remove = game.heroComponent.explode;
    return remove;
  }

  @override
  void resize(Size size) {
    this.x = pos;
    this.y = size.height - 150;
    this.maxY = size.height;
  }
}
