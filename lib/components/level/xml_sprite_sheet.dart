import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

class XmlSpriteSheet {
  XmlSpriteSheet(this.image, String xml) {
    final document = XmlDocument.parse(xml);
    for (final node in document.xpath('//TextureAtlas/SubTexture')) {
      final category = node.getAttribute('CATEGORY')!;
      final partName = "${node.getAttribute('PARTNAME')!}.png";
      final texName = "${node.getAttribute('TEX_NAME')!}.png";
      final x = double.parse(node.getAttribute('TEX_X')!);
      final y = double.parse(node.getAttribute('TEX_Y')!);
      final width = double.parse(node.getAttribute('TEX_WIDTH')!);
      final height = double.parse(node.getAttribute('TEX_HEIGHT')!);
      _rects[partName] = Rect.fromLTWH(x, y, width, height);
    }
  }

  final ui.Image image;
  final _rects = <String, Rect>{};

  Sprite getSprite(String name) {
    final rect = _rects[name];
    if (rect == null) {
      throw ArgumentError('Sprite $name not found');
    }
    return Sprite(
      image.clone(),
      srcPosition: rect.topLeft.toVector2(),
      srcSize: rect.size.toVector2(),
    );
  }
}
