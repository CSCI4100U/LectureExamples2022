import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Floor extends SpriteComponent with HasHitboxes, Collidable {
  Floor(Sprite sprite) {
    this.sprite = sprite;
    addHitbox(HitboxRectangle());
  }
}