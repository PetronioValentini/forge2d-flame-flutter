// ignore_for_file: invalid_use_of_internal_member

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'body_component_with_user_data.dart';

class Ground extends BodyComponentWithUserData {
  final Sprite sprite;
  late final double width;
  late final double height;
  final int padrao = 6;

  Ground(Vector2 position, this.sprite)
      : super(
          renderBody: false,
          bodyDef: BodyDef()
            ..position = position
            ..type = BodyType.static,
          fixtureDefs: [],
          children: [],
        ) {
    width = sprite.srcSize.x.toDouble() / padrao; // Obtém a largura do sprite
    height = sprite.srcSize.y.toDouble() / padrao; // Obtém a altura do sprite

    fixtureDefs?.add(
      FixtureDef(
        PolygonShape()..setAsBoxXY(width / 2, height / 2), // Usa width e height
        friction: 0.3,
      ),
    );

    children.add(
      SpriteComponent(
        anchor: Anchor.center,
        sprite: sprite,
        size: Vector2(width, height), // Define o tamanho do SpriteComponent
        position: Vector2(0, 0),
      ),
    );
  }
}
