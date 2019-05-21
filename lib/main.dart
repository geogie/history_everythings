import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:history_everythings/bloc_provider.dart';
import 'package:history_everythings/colors.dart';
import 'package:history_everythings/main_menu/main_menu.dart';

void main() => runApp(TimelineApp());

class TimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocProvider(
      child: MaterialApp(
        title: 'History & Future of Everything',
        theme: ThemeData(
            backgroundColor: background, scaffoldBackgroundColor: background),
        home: MenuPage(),
      ),
      platform: Theme.of(context).platform,
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null, body: MainMenuWidget());
  }
}