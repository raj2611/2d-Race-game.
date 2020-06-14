import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:race_game/components/street.dart';

class Backyard {
  final Street game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('road.png');
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.dimensions.width,
      game.dimensions.height,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
