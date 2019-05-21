import 'package:flare/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:history_everythings/bloc_provider.dart';
import 'package:history_everythings/colors.dart';
import 'package:history_everythings/main_menu/menu_data.dart';
import 'package:history_everythings/main_menu/thumbnail_detail_widget.dart';
import 'package:history_everythings/timeline/timeline_entry.dart';
import 'package:history_everythings/timeline/timeline_widget.dart';

/// Create by george
/// Date:2019/5/20
/// description:
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> favorites = [];
    List<TimelineEntry> entries = BlocProvider.favorites(context).favorites;

    for (int i = 0; i < entries.length; i++) {
      TimelineEntry entry = entries[i];
      favorites.add(ThumbnailDetailWidget(
        entry,
        hasDivider: i != 0,
        tapSearchResult: (TimelineEntry entry) {
          MenuItemData item = MenuItemData.fromEntry(entry);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  TimelineWidget(item, BlocProvider.getTimeline(context))));
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: lightGrey,
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.54),
          ),
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.arrow_back),
              padding: EdgeInsets.only(left: 20, right: 20),
              color: Colors.black.withOpacity(0.5),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          titleSpacing: 9,
          title: Text(
            'Your Favorites',
            style: TextStyle(
                fontFamily: 'RobotoMedium',
                fontSize: 20,
                color: darkText.withOpacity(darkText.opacity * 0.75)),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: favorites.isEmpty
            ? new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                          width: 128,
                          height: 114,
                          margin: EdgeInsets.only(bottom: 30),
                          child: FlareActor(
                            'assets/Broken Heart.flr',
                            animation: 'Heart Break',
                            shouldClip: false,
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 21),
                        width: 250,
                        child: Text('You haven’t favorited anything yet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'RobotoMedium',
                                color: darkText
                                    .withOpacity(darkText.opacity * 0.75),
                                height: 1.2)),
                      ),
                      Container(
                          width: 270,
                          margin: EdgeInsets.only(bottom: 114),
                          child: Text(
                              'Browse to an event in the timeline and tap on the heart icon to save something in this list.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                  height: 1.5,
                                  color: Colors.black.withOpacity(0.75))))
                    ],
                  )
                ],
              )
            : ListView(
                children: favorites,
              ),
      ),
    );
  }
}
