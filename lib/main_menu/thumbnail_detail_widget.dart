import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:history_everythings/colors.dart';
import 'package:history_everythings/main_menu/thumbnail.dart';
import 'package:history_everythings/timeline/timeline_entry.dart';

/// Create by george
/// Date:2019/5/20
/// description:
typedef TapSearchResultCallback(TimelineEntry entry);

class ThumbnailDetailWidget extends StatelessWidget {
  final TimelineEntry timelineEntry;
  /// Whether to show a divider line on the bottom of this widget. Defaults to `true`.
  final bool hasDivider;
  /// Callback to navigate to the timeline (see [MainMenuWidget._tapSearchResult()]).
  final TapSearchResultCallback tapSearchResult;

  ThumbnailDetailWidget(this.timelineEntry,
      {this.hasDivider = true, this.tapSearchResult, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          if(tapSearchResult!=null){
            tapSearchResult(timelineEntry);
          }
        },
        child: Column(
          children: <Widget>[
            hasDivider?Container(
              height: 1,
              color: Color.fromRGBO(151,151,151,0.29)):Container(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ThumbnailWidget(timelineEntry),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(timelineEntry.label,
                          style: TextStyle(
                            fontFamily: 'RobotoMedium',
                            fontSize: 20,
                            color: darkText.withOpacity(darkText.opacity*0.75)),
                          ),
                          Text(timelineEntry.formatYearsAgo(),
                          style: TextStyle(fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5)),)

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
