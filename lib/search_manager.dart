import 'dart:collection';

import 'package:history_everythings/timeline/timeline_entry.dart';

/// Create by george
/// Date:2019/5/17
/// description:
class SearchManager{
  static final SearchManager _searchManager = SearchManager._internal();

  factory SearchManager.init([List<TimelineEntry> entries]) {
    if (entries != null) {
      _searchManager._fill(entries);
    }
    return _searchManager;
  }

  /// Constructor definition.
  SearchManager._internal();

  _fill(List<TimelineEntry> entries) {
    /// Sanity check.
    _queryMap.clear();

    /// Fill the map with all the possible searchable substrings.
    /// This operation is O(n^2), thus very slow, and performed only once upon initialization.
    for (TimelineEntry e in entries) {
      String label = e.label;
      int len = label.length;
      for (int i = 0; i < len; i++) {
        for (int j = i + 1; j <= len; j++) {
          String substring = label.substring(i, j).toLowerCase();
          if (_queryMap.containsKey(substring)) {
            Set<TimelineEntry> labels = _queryMap[substring];
            labels.add(e);
          } else {
            _queryMap.putIfAbsent(substring, () => Set.from([e]));
          }
        }
      }
    }
  }

  final SplayTreeMap<String, Set<TimelineEntry>> _queryMap =
  SplayTreeMap<String, Set<TimelineEntry>>();

  Set<TimelineEntry> performSearch(String query) {
    if (_queryMap.containsKey(query))
      return _queryMap[query];
    else if (query.isNotEmpty) {
      return Set();
    }
    Iterable<String> keys = _queryMap.keys;
    Set<TimelineEntry> res = Set();
    for (String k in keys) {
      res.addAll(_queryMap[k]);
    }
    return res;
  }
}