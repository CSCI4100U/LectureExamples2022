import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'bird.dart';
import 'obstacle.dart';
import 'scene.dart';
import 'package:flame/components.dart';

class MyGame extends FlameGame with HasCollidables, TapDetector {
  int score = 0;
  double speed = 2.3;
  double obstacleHeight = 646;
  late Bird bird;
  late TextComponent text;
  List<Obstacle> topObstacles = [];
  List<Obstacle> bottomObstacles = [];

  MyGame({bool debugMode = false}) {
    this.debugMode = debugMode;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await buildScene(this);
  }

  @override
  void update(double dt) {
    super.update(dt);

    for (var i = 0; i < topObstacles.length; i++) {
      var top = topObstacles[i];
      var bottom = bottomObstacles[i];
      top.position.add(Vector2(-1 * (speed + score / 30), 0));
      bottom.position.add(Vector2(-1 * (speed + score / 30), 0));

      if (bird.x > top.x && !top.passed) {
        top.passed = true;
        score++;
        text.text = "Score: $score";
      }

      if ((top.x + top.width) < 0 && top.passed) {
        var pair = generateObstaclePair(200);
        top.position.add(Vector2(canvasSize[0] + top.width, 0));
        bottom.position.add(Vector2(canvasSize[0] + bottom.width, 0));
        top.position.y = pair.x - obstacleHeight;
        bottom.position.y = pair.x + 850;
        top.passed = false;
      }
    }
  }

  void gameOver() {
    pauseEngine();
  }

  void reset() {
    score = 0;
    speed = 2.3;
    super.children.clear();
    super.resumeEngine();
    topObstacles.clear();
    bottomObstacles.clear();
    buildScene(this);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (paused) {
      reset();
    } else {
      bird.jump();
    }
  }

  Vector2 generateObstaclePair(double space) {
    var rng = Random();
    double x = rng.nextInt(canvasSize[1].toInt() - 400).toDouble();
    return Vector2(x, x + space);
  }
}