import 'package:nima/nima.dart' as nima;
import 'package:nima/nima/math/mat2d.dart' as nima;
import 'package:nima/nima/math/vec2d.dart' as nima;

/// Create by george
/// Date:2019/5/21
/// description:
abstract class NimaInteractionController {
  void initialize(nima.FlutterActor actor);

  bool advance(
      nima.FlutterActor actor, nima.Vec2D touchPosition, double elapsed);
}
