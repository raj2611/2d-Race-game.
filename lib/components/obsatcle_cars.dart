import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:race_game/components/street.dart';

import '../main.dart';
import 'bounce_hero.dart';

class ObstcleCar extends SpriteComponent {
  Size dimensions;
  int i;

  ObstcleCar(this.dimensions, this.i)
      : super.rectangle(80, 150, i % 2 == 0 ? 'car5.png' : 'car2.png');
  double maxY;
  bool remove = false;
  @override
  void update(double t) {
    y += t * game.SPEED;

    if (game.component != null) {
      bool remove =
          game.heroComponent.toRect().contains(this.toRect().bottomCenter) ||
              game.heroComponent.toRect().contains(this.toRect().bottomLeft) ||
              game.heroComponent.toRect().contains(this.toRect().bottomRight) ||
              game.heroComponent.toRect().contains(this.toRect().topCenter) ||
              game.heroComponent.toRect().contains(this.toRect().topLeft) ||
              game.heroComponent.toRect().contains(this.toRect().topRight) ||
              game.heroComponent.toRect().contains(this.toRect().center);

      // print(remove);
      if (remove) {
        game.heroComponent.explode = true;
      }
    }
    super.update(t);
  }

  reset() {
    this.y = 0.0;
    this.x = 0.0;
    this.i = 0;
    this.maxY = 0.0;
  }
  // @override
  // bool destroy() {
  //   return remove;
  // }

  @override
  void resize(Size size) {
    this.x = i % 2 == 0 ? 40 : size.width - 110;
    this.y = -120;
    this.maxY = size.height;
  }
}
