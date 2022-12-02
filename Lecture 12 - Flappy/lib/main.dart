import 'game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  var game = MyGame(debugMode: true);

  runApp(
    GameWidget(
      game: game,
    ),
  );
}