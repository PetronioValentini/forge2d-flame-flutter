import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:miau_game/components/level/xml_sprite_sheet.dart';
import 'background.dart';
import 'level/ground.dart';

class MyPhysicsGame extends Forge2DGame {
  MyPhysicsGame()
      : super(
          gravity: Vector2(0, 10),
          camera: CameraComponent.withFixedResolution(width: 900, height: 600),
        );

  late final XmlSpriteSheet tiles;

  @override
  Future<void> onLoad() async {
    //debugMode = true;
    final [backgroundImage, tilesImage] = await [
      images.load('AltarOfHarmony_background.png'),
      images.load('AltarOfHarmony_03.png'),
      //images.load('AltarOfHarmony_02.png'),
    ].wait;
    
    tiles = XmlSpriteSheet(tilesImage,
        await rootBundle.loadString('assets/AltarOfHarmony_tiles.xml'));
    
    await world.add(Background(sprite: Sprite(backgroundImage)));
    await addGround();

    return super.onLoad();
  }

  Future<void> addGround() async {
    return world.addAll([
      Ground(
        Vector2(camera.visibleWorldRect.left,
            (camera.visibleWorldRect.height - groundSize) / 2),
        tiles.getSprite('AltarOfHarmony_0003_B.png'),
      ),
      Ground(
        Vector2(camera.visibleWorldRect.right,
            (camera.visibleWorldRect.height - groundSize) / 2),
        // ADICIONAR LISTA DE TILES
        tiles.getSprite('AltarOfHarmony_0025_A.png'),
      ),
      Ground(
        Vector2(camera.visibleWorldRect.left + 20,
            (camera.visibleWorldRect.height - 30 - groundSize) / 2),
        tiles.getSprite('AltarOfHarmony_0003_B.png'),
      ),
    ]);
  }
}
