import 'package:history_everythings/article/controllers/nima_interaction_controller.dart';
import 'package:nima/nima.dart';
import 'package:nima/nima/actor_node.dart';
import 'package:nima/nima/math/vec2d.dart';
import 'package:nima/nima/math/mat2d.dart';


/// Create by george
/// Date:2019/5/21
/// description:
class NewtonController extends NimaInteractionController{
  ActorNode _treeControl;
  /// Two vector variables are used to store the actual coordinates.
  Vec2D _lastTouchPosition;
  Vec2D _originalTranslation;

  @override
  bool advance(FlutterActor artboard, Vec2D touchPosition, double elapsed) {
    if (touchPosition != null && _lastTouchPosition != null) {
      Vec2D move = Vec2D.subtract(Vec2D(), touchPosition, _lastTouchPosition);
      Mat2D toParentSpace = Mat2D();
      /// Transform world coordinates into object space. Then evaluate the move delta
      /// and apply it to the control.
      if (Mat2D.invert(toParentSpace, _treeControl.parent.worldTransform)) {
        Vec2D localMove = Vec2D.transformMat2(Vec2D(), move, toParentSpace);
        _treeControl.translation =
            Vec2D.add(Vec2D(), _treeControl.translation, localMove);
      }
    } else {
      /// If the finger has been lifted - i.e. [_lastTouchPosition] is null
      /// set the tree's position back to its original value.
      _treeControl.translation = Vec2D.add(
          Vec2D(),
          _treeControl.translation,
          Vec2D.scale(
              Vec2D(),
              Vec2D.subtract(
                  Vec2D(), _originalTranslation, _treeControl.translation),
              (elapsed * 3.0).clamp(0.0, 1.0)));
    }
    _lastTouchPosition = touchPosition;
    return true;
  }

  @override
  void initialize(FlutterActor artboard) {
    _treeControl = artboard.getNode("ctrl_move_tree");
    if (_treeControl != null) {
      _originalTranslation = Vec2D.clone(_treeControl.translation);
    }
  }

}