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
    // Lista de imagens a serem carregadas
    final imagesToLoad = [
      'AltarOfHarmony_background.png',
      'AltarOfHarmony_03.png',
      'AltarOfHarmony_02.png',
      'AltarOfHarmony_01.png',
      // Adicione mais imagens conforme necessário
    ];

    // Carregar todas as imagens
    final loadedImages = await Future.wait(
      imagesToLoad.map((imageName) => images.load(imageName)),
    );

    // Verifique se todas as imagens foram carregadas
    if (loadedImages.length != imagesToLoad.length) {
      throw Exception('Nem todas as imagens foram carregadas corretamente.');
    }

    // Atribuir as imagens carregadas às variáveis correspondentes
    final backgroundImage = loadedImages[0];
    final tilesImages = loadedImages
        .sublist(1); // Pegando todas as imagens restantes para os tiles

    // Criar a instância de XmlSpriteSheet com as imagens carregadas
    tiles = XmlSpriteSheet(
      tilesImages,
      await rootBundle.loadString('assets/AltarOfHarmony_tiles.xml'),
    );

    // Adicionar o background ao mundo
    await world.add(Background(sprite: Sprite(backgroundImage)));
    await addGround();

    return super.onLoad();
  }

  Future<void> addGround() async {
    debugMode = true;

    return world.addAll([
      Ground(
        Vector2(-0.105 * 600, 0.585 * 900),
        tiles.getSprite('AltarOfHarmony_0035_1/2.png'),
      ),
      Ground(
        Vector2(-0.4425 * 600, 1.2425 * 900),
        tiles.getSprite('AltarOfHarmony_0025_B.png'),
      ),
      Ground(
        Vector2(0 * 600, 0 * 900),
        tiles.getSprite('AltarOfHarmony_Fl_A.png'),
      ),
      Ground(
        Vector2(1.5 * 600, 0 * 900),
        tiles.getSprite('AltarOfHarmony_Fl_B.png'),
      ),
      Ground(
        Vector2(3 * 600, 0 * 900),
        tiles.getSprite('AltarOfHarmony_Fl_A.png'),
      ),
      Ground(
        Vector2(1.0525 * 600, 0.3375 * 900),
        tiles.getSprite('AltarOfHarmony_0050_2/2.png'),
      ),
      Ground(
        Vector2(1.0775 * 600, 0.94 * 900),
        tiles.getSprite('AltarOfHarmony_0040_3/3.png'),
      ),
      Ground(
        Vector2(3.2725 * 600, 1.605 * 900),
        tiles.getSprite('AltarOfHarmony_0050_1/2.png'),
      ),
      Ground(
        Vector2(2.8075 * 600, 0.3825 * 900),
        tiles.getSprite('AltarOfHarmony_0035_1/2.png'),
      ),
      Ground(
        Vector2(3.07 * 600, 1.1825 * 900),
        tiles.getSprite('AltarOfHarmony_0035_1/2.png'),
      ),
      Ground(
        Vector2(3.0025 * 600, 0.805 * 900),
        tiles.getSprite('AltarOfHarmony_0050_1/2.png'),
      ),
      Ground(
        Vector2(-0.4475 * 600, 0.3075 * 900),
        tiles.getSprite('AltarOfHarmony_0050_1/2.png'),
      ),
      Ground(
        Vector2(1.125 * 600, 0.635 * 900),
        tiles.getSprite('AltarOfHarmony_0035_2/2.png'),
      ),
      Ground(
        Vector2(-0.4225 * 600, 0.9375 * 900),
        tiles.getSprite('AltarOfHarmony_0040_2/3.png'),
      ),
      Ground(
        Vector2(4.0375 * 600, 0.4325 * 900),
        tiles.getSprite('AltarOfHarmony_0035_2/2.png'),
      ),
      Ground(
        Vector2(4.3 * 600, 1.2325 * 900),
        tiles.getSprite('AltarOfHarmony_0035_2/2.png'),
      ),
    ]);
  }
}
