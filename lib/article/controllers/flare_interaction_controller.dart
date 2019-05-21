import 'package:flare/flare.dart' as flare;
import 'package:flare/flare/math/mat2d.dart' as flare;
import 'package:flare/flare/math/vec2d.dart' as flare;

/// Create by george
/// Date:2019/5/21
/// description:
abstract class FlareInteractionController {
  void initialize(flare.FlutterActorArtboard artboard);

  bool advance(flare.FlutterActorArtboard artboard, flare.Vec2D touchPosition,
      double elapsed);
}