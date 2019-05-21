import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:history_everythings/colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Create by george
/// Date:2019/5/20
/// description:
class AboutPage extends StatelessWidget {
  _launchUrl(String url) {
    canLaunch(url).then((bool success) {
      if (success) {
        launch(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: lightGrey,
            iconTheme: IconThemeData(color: Colors.black.withOpacity(0.54)),
            elevation: 0,
            leading: IconButton(
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.arrow_back),
                padding: EdgeInsets.only(left: 20, right: 20),
                color: Colors.black.withOpacity(0.5),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            titleSpacing: 9.0,
            title: Text('About',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'RobotoMedium',
                    fontSize: 20,
                    color: darkText.withOpacity(darkText.opacity * 0.75)))),
        body: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Text(
                'The History of \n Everything',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'RobotoMedium',
                    color: darkText.withOpacity(darkText.opacity * 0.75)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 17, bottom: 14),
                child: Text(
                  'v1.0',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      height: 1.5,
                      color: darkText.withOpacity(darkText.opacity * 0.5)),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkText
                                    .withOpacity(darkText.opacity * 0.75),
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                height: 1.5),
                            children: [
                          TextSpan(
                              text: 'The History of Everyting is built with '),
                          TextSpan(
                              text: 'Flutter',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => _launchUrl('https://www.flutter.io')),
                          TextSpan(text: ' by '),
                          TextSpan(
                              text: '2Dimensions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    _launchUrl('https://www.2dimensions.com')),
                          TextSpan(
                              text:
                                  '. The graphics and animations were created using tools by '),
                          TextSpan(
                              text: '2Dimensions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    _launchUrl('https://www.2dimensions.com')),
                          TextSpan(
                            text: ".\n\nInspired by the Kurzgesagt video ",
                          ),
                          TextSpan(
                              text: "The History & Future of Everything",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchUrl(
                                    "https://www.youtube.com/watch?v=5TbUxGZtwGI")),
                          TextSpan(
                            text: ".",
                          )
                        ]))
                  ],
                ),
              ),
              Text(
                "Designed by",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 17.0,
                    height: 1.5,
                    color: Colors.black.withOpacity(0.5)),
              ),
              GestureDetector(
                onTap: () => _launchUrl("https://www.2dimensions.com"),
                child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
                    child: Image.asset(
                      "assets/twoDimensions_logo.png",
                      height: 16.0,
                    )),
              ),
              Text(
                "Built with",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 17.0,
                    height: 1.5,
                    color: Colors.black.withOpacity(0.5)),
              ),
              GestureDetector(
                onTap: () => _launchUrl("https://www.flutter.io"),
                child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/flutter_logo.png",
                              height: 45.0, width: 37.0),
                          Container(
                            margin: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Flutter",
                              style: TextStyle(
                                  fontSize: 26.0,
                                  color: darkText
                                      .withOpacity(darkText.opacity * 0.6)),
                            ),
                          )
                        ])),
              )
            ])));
  }
}
