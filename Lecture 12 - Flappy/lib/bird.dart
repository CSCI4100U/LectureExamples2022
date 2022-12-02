import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'game.dart';

class Bird extends SpriteComponent
    with HasHitboxes, Collidable, HasGameRef<MyGame> {
  final double maxSpeed = 7;
  final double minSpeed = -10;
  final double acceleration = 0.16;
  final double jumpPower = 5;
  bool isDead = false;
  double speed = 4;

  Bird(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(50.0, 50.0);
    anchor = Anchor.center;
    position = Vector2(100, 100);
    addHitbox(HitboxCircle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    speed = min(speed + acceleration, maxSpeed);
    position.add(Vector2(0.0, speed));
    angle = getAngleFromSpeed(speed);
  }

  void jump() {
    speed = max(speed - jumpPower, minSpeed);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    gameRef.gameOver();
  }

  double getAngleFromSpeed(double speed) {
    return speed / (maxSpeed - minSpeed);
  }
}