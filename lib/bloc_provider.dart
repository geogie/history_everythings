import 'package:flutter/widgets.dart';
import 'package:history_everythings/blocs/favorites_bloc.dart';
import 'package:history_everythings/search_manager.dart';
import 'package:history_everythings/timeline/timeline.dart';
import 'package:history_everythings/timeline/timeline_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Create by george
/// Date:2019/5/17
/// description:
class BlocProvider extends InheritedWidget {
  final FavoritesBloc favoritesBloc;
  final Timeline timeline;

  BlocProvider(
      {Key key,
        FavoritesBloc fb,
        Timeline t,
        @required Widget child,
        TargetPlatform platform = TargetPlatform.iOS})
      : timeline = t ?? Timeline(platform),
        favoritesBloc = fb ?? FavoritesBloc(),
        super(key: key, child: child) {
    timeline
        .loadFromBundle("assets/timeline.json")
        .then((List<TimelineEntry> entries) {
      timeline.setViewport(
          start: entries.first.start * 2.0,
          end: entries.first.start,
          animate: true);
      /// Advance the timeline to its starting position.
      timeline.advance(0.0, false);

      /// All the entries are loaded, we can fill in the [favoritesBloc]...
      favoritesBloc.init(entries);
      /// ...and initialize the [SearchManager].
      SearchManager.init(entries);
    });
  }

  static BlocProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider;
  }

  @override
  bool updateShouldNotify(BlocProvider old)=>true;

  static Timeline getTimeline(BuildContext context) {
    BlocProvider bp =
    (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
    Timeline bloc = bp?.timeline;
    return bloc;
  }

  static FavoritesBloc favorites(BuildContext context) {
    BlocProvider bp =
    (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
    FavoritesBloc bloc = bp?.favoritesBloc;
    return bloc;
  }

}