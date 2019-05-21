import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:history_everythings/bloc_provider.dart';
import 'package:history_everythings/colors.dart';
import 'package:history_everythings/main_menu/about_page.dart';
import 'package:history_everythings/main_menu/collapsible.dart';
import 'package:history_everythings/main_menu/favorites_page.dart';
import 'package:history_everythings/main_menu/menu_data.dart';
import 'package:history_everythings/main_menu/menu_data_section.dart';
import 'package:history_everythings/main_menu/search_widget.dart';
import 'package:history_everythings/main_menu/thumbnail_detail_widget.dart';
import 'package:history_everythings/search_manager.dart';
import 'package:history_everythings/timeline/timeline_entry.dart';
import 'package:history_everythings/timeline/timeline_widget.dart';
import "package:share/share.dart";

/// Create by george
/// Date:2019/5/17
/// description:
class MainMenuWidget extends StatefulWidget {
  MainMenuWidget({Key key}) : super(key: key);

  @override
  _MainMenuWidgetState createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchTextController = TextEditingController();
  final MenuData _menu = MenuData();
  bool _isSectionActive = true;
  List<TimelineEntry> _searchResults = List<TimelineEntry>();
  Timer _searchTimer;

  navigateToTimeline(MenuItemData item) {
    print('history-item:${item.label}');
    _pauseSection();
    Navigator.of(context)
    .push(MaterialPageRoute(builder: (BuildContext context)=>TimelineWidget(item,BlocProvider.getTimeline(context)),
    ))
    .then(_restoreSection);
  }

  @override
  void initState() {
    super.initState();
    _menu.loadFromBundle("assets/menu.json").then((bool success) {
      if (success) setState(() {}); // Load the menu.
    });

    _searchTextController.addListener(() {
      updateSearch();
    });

    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode.hasFocus;
        updateSearch();
      });
    });

  }
  cancelSearch() {
    if (_searchTimer != null && _searchTimer.isActive) {
      /// Remove old timer.
      _searchTimer.cancel();
      _searchTimer = null;
    }
  }

  updateSearch() {
    cancelSearch();
    if (!_isSearching) {
      setState(() {
        _searchResults = List<TimelineEntry>();
      });
      return;
    }
    String txt = _searchTextController.text.trim();
    /// Perform search.
    ///
    /// A [Timer] is used to prevent unnecessary searches while the user is typing.
    _searchTimer = Timer(Duration(milliseconds: txt.isEmpty ? 0 : 350), () {
      Set<TimelineEntry> res = SearchManager.init().performSearch(txt);
      setState(() {
        _searchResults = res.toList();
        print('history-_searchResults:${_searchResults.length}');
      });
    });
  }

  void _tapSearchResult(TimelineEntry entry) {
    navigateToTimeline(MenuItemData.fromEntry(entry));
  }

  _restoreSection(v) => setState(() => _isSectionActive = true);

  _pauseSection() => setState(() => _isSectionActive = false);

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    List<Widget> tail = [];
    if (_isSearching) {
      for (int i = 0; i < _searchResults.length; i++) {
        tail.add(RepaintBoundary(
            child: ThumbnailDetailWidget(_searchResults[i],
                hasDivider: i != 0, tapSearchResult: _tapSearchResult)));
      }
    } else {
      tail
        ..addAll(_menu.sections // 三大模块(Birth、Life、Common )
            .map<Widget>((MenuSectionData section) => Container(
                  margin: EdgeInsets.only(top: 20),
                  child: MenuSection(
                    section.label,
                    section.backgroundColor,
                    section.textColor,
                    section.items,
                    navigateToTimeline,
                    _isSectionActive,
                    assetId: section.assetId,
                  ),
                ))
            .toList(growable: false))
        ..add(Container(
          margin: EdgeInsets.only(top: 40, bottom: 22),
          height: 1,
          color: Color.fromRGBO(151, 151, 151, 0.29),
        ))
        ..add(FlatButton(
            onPressed: () {
              _pauseSection();
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => FavoritesPage()))
                  .then(_restoreSection);
            },
            color: Colors.transparent,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 15.5),
                    child: Image.asset('assets/heart_icon.png'),
                    height: 20,
                    width: 20,),
                Text(
                  'Your Favorites',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoMedium',
                      color: Colors.black.withOpacity(0.65)),
                )
              ],
            )))
        ..add(FlatButton(
            onPressed: () => Share.share('Check out The History of Everything! '
                '${Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.twodimensions.timeline" : "itms://itunes.apple.com/us/app/apple-store/id1441257460?mt=8"}'),
            color: Colors.transparent,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 15.5),
                    child: Image.asset(
                      'assets/share_icon.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  Text(
                    'Share',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoMedium',
                        color: Colors.black.withOpacity(0.65)),
                  )
                ])))
        ..add(Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: FlatButton(
              onPressed: () {
                _pauseSection();
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) => AboutPage()))
                    .then(_restoreSection);
              },
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 15.5),
                    child: Image.asset('assets/info_icon.png'),
                    height: 20,
                    width: 20,
                  ),
                  Text(
                    'About',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoMedium',
                        color: Colors.black.withOpacity(0.65)),
                  )
                ],
              )),
        ));
    }

    return WillPopScope(
        onWillPop: _popSearch,
        child: Container(
          color: background,
          child: Padding(
            padding: EdgeInsets.only(top: devicePadding.top),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        Collapsible(
                            isCollapsed: _isSearching,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 12),
                                  child: Opacity(
                                    opacity: 0.85,
                                    child: Image.asset(
                                      'assets/twoDimensions_logo.png',
                                      height: 10.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'The History of Everything',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: darkText
                                          .withOpacity(darkText.opacity * 0.75),
                                      fontSize: 34,
                                      fontFamily: 'RobotoMedium'),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 22),
                          child: SearchWidget(
                              _searchFocusNode, _searchTextController),
                        )
                      ] +
                      tail,
                )),
          ),
        ));
  }

  Future<bool> _popSearch() {
    if (_isSearching) {
      setState(() {
        _searchFocusNode.unfocus();
        _searchTextController.clear();
        _isSearching = false;
      });
      return Future(() => false);
    } else {
      Navigator.of(context).pop(true);
      return Future(() => true);
    }
  }

}

