import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

class XmlSpriteSheet {
  XmlSpriteSheet(this.images, String xml) {
    final document = XmlDocument.parse(xml);
    for (final node in document.xpath('//TextureAtlas/SubTexture')) {
      final category = node.getAttribute('CATEGORY')!;
      final partName = "${node.getAttribute('PARTNAME')!}.png";
      final texName = "${node.getAttribute('TEX_NAME')!}.png";
      final x = double.parse(node.getAttribute('TEX_X')!);
      final y = double.parse(node.getAttribute('TEX_Y')!);
      final width = double.parse(node.getAttribute('TEX_WIDTH')!);
      final height = double.parse(node.getAttribute('TEX_HEIGHT')!);

      // Associa a imagem correta ao partName
      final imageIndex = imagesMap[texName];
      if (imageIndex == null) {
        throw ArgumentError('Imagem $texName não encontrada na lista de imagens.');
      }

      _rects[partName] = Rect.fromLTWH(x, y, width, height);
      _imageMap[partName] = images[imageIndex];
    }
  }

  final List<ui.Image> images;
  final _rects = <String, Rect>{};
  final _imageMap = <String, ui.Image>{};
  final imagesMap = {
    'AltarOfHarmony_03.png': 0,
    'AltarOfHarmony_02.png': 1,
    'AltarOfHarmony_01.png': 2,
    // Adicione mais mapeamentos conforme necessário
  };

  Sprite getSprite(String name) {
    final rect = _rects[name];
    final image = _imageMap[name];
    if (rect == null || image == null) {
      throw ArgumentError('Sprite $name não encontrado.');
    }
    return Sprite(
      image,
      srcPosition: rect.topLeft.toVector2(),
      srcSize: rect.size.toVector2(),
    );
  }
}
