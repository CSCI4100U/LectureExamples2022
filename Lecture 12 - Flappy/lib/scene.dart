import 'package:flame/components.dart';
import 'bird.dart';
import 'floor.dart';
import 'game.dart';
import 'obstacle.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

buildScene(MyGame game) async {
  double width = game.canvasSize[0];
  double height = game.canvasSize[1];

  game.bird = Bird(await game.loadSprite(
    'atlas.png',
    srcPosition: Vector2(5, 981),
    srcSize: Vector2(36, 26),
  ));

  var floor = Floor(await game.loadSprite(
    'atlas.png',
    srcPosition: Vector2(585, 1),
    srcSize: Vector2(335, 110),
  ))
    ..size = Vector2(game.canvasSize[0], 110)
    ..position = Vector2(0, height * .9);

  var obstaclePair1 = game.generateObstaclePair(height * .3);
  var obstaclePair2 = game.generateObstaclePair(height * .3);

  var topObstacle1 = Obstacle(await game.loadSprite(
    'atlas.png',
    srcPosition: Vector2(113, game.obstacleHeight),
    srcSize: Vector2(50, 320),
  ))
    ..size = Vector2(120, 646)
    ..position = Vector2(width * .65, obstaclePair1.x - game.obstacleHeight);
  var bottomObstacle1 = Obstacle(await game.loadSprite(
    'atlas.png',
    srcPosition: Vector2(113, game.obstacleHeight),
    srcSize: Vector2(50, 320),
  ))
    ..size = Vector2(120, 646)
    ..position = Vector2(width * .65, obstaclePair1.y)
    ..flipVerticallyAroundCenter();
  var topObstacle2 = Obstacle(await game.loadSprite(
    'atlas.png',
    srcPosition: Vector2(113, game.obstacleHeight),
    srcSize: Vector2(50, 320),
  ))
    ..size = Vector2(120, 646)
    ..position = Vector2(width * 1.2, obstaclePair2.x - game.obstacleHeight);
  var bottomObstacle2 = Obstacle(await game.loadSprite(
    'atlas.png',
    srcPosition: Vector2(113, game.obstacleHeight),
    srcSize: Vector2(50, 320),
  ))
    ..size = Vector2(120, 646)
    ..position = Vector2(width * 1.2, obstaclePair2.y)
    ..flipVerticallyAroundCenter();

  game.topObstacles.add(topObstacle1);
  game.topObstacles.add(topObstacle2);
  game.bottomObstacles.add(bottomObstacle1);
  game.bottomObstacles.add(bottomObstacle2);

  game.add(
    SpriteComponent(
      sprite: await game.loadSprite(
        'atlas.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(286, 512),
      ),
    )..size = game.size,
  );
  game.add(game.bird);
  game.add(topObstacle1);
  game.add(bottomObstacle1);
  game.add(topObstacle2);
  game.add(bottomObstacle2);
  game.add(floor);
  game.text = TextComponent(
    text: "Score: 0",
    textRenderer: TextPaint(
      style: TextStyle(
        fontSize: 18,
        color: BasicPalette.white.color,
      ),
    ),
  )..anchor = Anchor.topLeft;
  game.add(game.text);
}