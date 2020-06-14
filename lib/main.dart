import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:race_game/restart_app.dart';

import 'components/bounce_hero.dart';
import 'components/obsatcle_cars.dart';
import 'components/street.dart';

var game;

var ComponentSize = 80.0;

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;
ObstcleCar obstcleCar;
BounceHeroBike bounceHeroBike;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.images.loadAll(['car2.png', 'car5.png', 'hero.png', 'road.png']);
  var dimensions = await Flame.util.initialDimensions();
  game = new Street(dimensions);

  runApp(RestartWidget(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWrapper(game),
    ),
  ));
}

class GameWrapper extends StatelessWidget {
  final Street game;
  GameWrapper(this.game);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Race Game",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () async {
                game.component.reset();
                game.components.forEach((d) {
                  d.destroy();
                });

                main();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/road.png"),
                    fit: BoxFit.cover)),
            child: game.widget));
  }
}
