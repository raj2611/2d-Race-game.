import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:race_game/components/background.dart';

import '../main.dart';
import 'bounce_hero.dart';
import 'obsatcle_cars.dart';

class Street extends BaseGame with TapDetector {
  var SPEED = 600.0;
  Size dimensions;
  Street(this.dimensions) {
    intialize();
  }
  ObstcleCar component;
  BounceHeroBike heroComponent;
  Backyard backyard;
  bool bikePos = false;
  bool forceBikepos = false;
  intialize() {
    backyard = Backyard(this);
  }

  @override
  void render(Canvas canvas) {
    backyard.render(canvas);
    super.render(canvas);

    TextPainter painter;
    TextStyle textStyle;
    Offset position;

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Colors.pinkAccent,
      fontSize: 70,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Colors.white,
          offset: Offset(3, 3),
        ),
      ],
    );
    if ((painter.text?.text ?? '') != "g") {
      heroComponent.explode
          ? painter.text = TextSpan(
              text: "Game Over",
              style: textStyle,
            )
          : painter.text = TextSpan(text: "");

      painter.layout();

      position = Offset(
        (10),
        (dimensions.height / 2),
      );
    }

    painter.paint(canvas, position);
  }

  int i = 0;
  double creationTimer = 0.0;
  @override
  void update(double t) {
    super.update(t);
    creationTimer += t;
    var rng = new Random();
    int next(int min, int max) => min + rng.nextInt(max - min);
    int choice = next(1, 100);

    if (t == 0.0) {
      creationTimer = 0.0;
      print("object updateee $creationTimer");
      heroComponent = new BounceHeroBike(dimensions);
      add(heroComponent);
    }
    if (creationTimer >= 2) {
      i += 1;
      creationTimer = 0.0;
      if (choice.isEven && bikePos) {
        component = new ObstcleCar(dimensions, 3);
      } else if (choice.isOdd && bikePos) {
        component = new ObstcleCar(dimensions, 2);
      } else if (choice.isEven && !bikePos) {
        component = new ObstcleCar(dimensions, 2);
      } else if (choice.isOdd && !bikePos) {
        component = new ObstcleCar(dimensions, 3);
      }

      add(component);
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    if (details.globalPosition.dx < 170) {
      bikePos = false;
      forceBikepos = true;
    } else if (details.globalPosition.dx > 170) {
      forceBikepos = true;
      bikePos = true;
    } else {}

    touchPositionDx = details.globalPosition.dx;
    touchPositionDy = details.globalPosition.dy;
    print(
        "Player tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }

  @override
  void onTapUp(TapUpDetails details) {
    print(
        "Player tap up on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }
}
