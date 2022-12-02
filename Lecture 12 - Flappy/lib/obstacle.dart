import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Obstacle extends SpriteComponent with HasHitboxes, Collidable {
  bool passed = false;

  Obstacle(Sprite sprite) {
    this.sprite = sprite;
    addHitbox(HitboxRectangle());
  }
}