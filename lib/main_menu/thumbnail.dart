import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:history_everythings/article/timeline_entry_widget.dart';
import 'package:history_everythings/timeline/timeline_entry.dart';

/// Create by george
/// Date:2019/5/20
/// description:图标
class ThumbnailWidget extends StatelessWidget {
  static const double radius = 17;

  /// Reference to the entry to get the thumbnail image information.
  final TimelineEntry entry;

  ThumbnailWidget(this.entry, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimelineAsset asset = entry.asset;
    Widget thumbnail;
    if (asset is TimelineImage) {
      thumbnail = RawImage(
        image: asset.image,
      );
    } else if (asset is TimelineNima || asset is TimelineFlare) {
      thumbnail = TimelineEntryWidget(
        isActive: false,
        timelineEntry: entry,
      );
    } else {
      thumbnail = Container(
        color: Colors.transparent,
      );
    }

    return Container(
        width: radius * 2,
        height: radius * 2,
        child: ClipPath(clipper: CircleClipper(), child: thumbnail));
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
