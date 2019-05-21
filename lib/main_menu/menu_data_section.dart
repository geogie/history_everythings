import 'package:flutter/widgets.dart';
import 'package:history_everythings/main_menu/menu_data.dart';
import 'package:history_everythings/main_menu/menu_vignette.dart';
import "package:flare/flare_actor.dart" as flare;

/// Create by george
/// Date:2019/5/20
/// description: item
typedef NavigateTo(MenuItemData item);

class MenuSection extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color accentColor;
  final List<MenuItemData> menuOptions;
  final String assetId;
  final NavigateTo navigateTo;
  final bool isActive;

  MenuSection(this.title, this.backgroundColor, this.accentColor,
      this.menuOptions, this.navigateTo, this.isActive,
      {this.assetId, Key key})
      : super(key: key);

  @override
  _MenuSectionState createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  Animation<double> _sizeAnimation;
  AnimationController _controller;
  static final Animatable<double> _sizeTween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    /// This curve is controlled by [_controller].
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    /// [_sizeAnimation] will interpolate using this curve - [Curves.fastOutSlowIn].
    _sizeAnimation = _sizeTween.animate(curve);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.backgroundColor),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: MenuVignette(
                  gradientColor: widget.backgroundColor,
                  isActive: widget.isActive,
                  assetId: widget.assetId,
                ),
                left: 0,
                right: 0,
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 21,
                            width: 21,
                            margin: EdgeInsets.all(18),
                            child: flare.FlareActor(
                              'assets/ExpandCollapse.flr',
                              color: widget.accentColor,
                              animation: _isExpanded ? 'Collapse' : 'expand',
                            )),
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'RobotoMedium',
                              color: widget.accentColor),
                        )
                      ],
                    ),
                  ),
                  SizeTransition(
                    axisAlignment: 0,
                    axis: Axis.vertical,
                    sizeFactor: _sizeAnimation,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 56, right: 20, top: 10),
                        child: Column(
                          children: widget.menuOptions.map((item){
                            return new GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => widget.navigateTo(item),
                                child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: Text(
                                                item.label,
                                                style: TextStyle(
                                                    color: widget
                                                        .accentColor,
                                                    fontSize: 20.0,
                                                    fontFamily:
                                                    "RobotoMedium"),
                                              ))),
                                      Container(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                              "assets/right_arrow.png",
                                              color: widget.accentColor,
                                              height: 22.0,
                                              width: 22.0))
                                    ]));
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    switch (_sizeAnimation.status) {
      case AnimationStatus.completed:
        _controller.reverse();
        break;
      case AnimationStatus.dismissed:
        _controller.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }
}
