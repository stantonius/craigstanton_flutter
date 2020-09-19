import 'dart:js' as js;

import '../ResponsiveLayout.dart';
import '../const_utils.dart';
import '../widgets/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  double iconSize = 24;

  double horizontalSpace = 30;

  Map<dynamic, dynamic> menuList = ConstUtils().stringUtils.menuItems;

  int clickPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: ResponsiveLayout.isSmallScreen(context)
              ? Alignment.topCenter
              : Alignment.topRight,
          child: Visibility(
            visible: ResponsiveLayout.isSmallScreen(context)
                ? clickPosition != 0 ? false : true
                : true,
            child: Container(
              margin: EdgeInsets.only(
                top: 100,
              ),
              child: ImageCarousel(),
              height: ResponsiveLayout.isSmallScreen(context)
                  ? 300
                  : ResponsiveLayout.isXLargeScreen(context) ? 1000 : 600,
              width: ResponsiveLayout.isSmallScreen(context)
                  ? 300
                  : ResponsiveLayout.isXLargeScreen(context) ? 1000 : 600,
            ),
          ),
        ),
        Align(
            alignment: ResponsiveLayout.isSmallScreen(context)
                ? Alignment.bottomCenter
                : Alignment.centerLeft,
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(
                  left: ResponsiveLayout.isSmallScreen(context) ? 0 : 250,
                  top: ResponsiveLayout.isSmallScreen(context) ? 100 : 160),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: ResponsiveLayout.isSmallScreen(context)
                      ? EdgeInsets.only(bottom: 14)
                      : EdgeInsets.only(bottom: 0),
                  child: Column(
                    crossAxisAlignment: ResponsiveLayout.isSmallScreen(context)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConstUtils().widgetUtils.menuTextWithSize(
                          context: context,
                          name: "HELLO, I’M",
                          color: Colors.white,
                          textSizeSmall: 16,
                          textSizeMedium: 22,
                          textSizeLarge: 30),
                      ConstUtils().widgetUtils.spaceVertical(20),
                      ConstUtils().widgetUtils.headingText(
                          name: ConstUtils().stringUtils.fullname,
                          color: Colors.white,
                          context: context,
                          textSizeLarge: 42,
                          textSizeMedium: 36,
                          textSizeSmall: 22),
                      ConstUtils().widgetUtils.spaceVertical(10),
                      ConstUtils().widgetUtils.contentText(
                          ConstUtils().stringUtils.bio,
                          Colors.white.withOpacity(.50),
                          18),
                      ConstUtils().widgetUtils.spaceVertical(
                          ResponsiveLayout.isSmallScreen(context) ? 50 : 100),
                      Row(
                        mainAxisAlignment:
                            ResponsiveLayout.isSmallScreen(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _launchURL(ConstUtils().stringUtils.linkGithub);
                            },
                            child: Icon(
                              FontAwesomeIcons.github,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                          ConstUtils()
                              .widgetUtils
                              .spaceHorizontal(horizontalSpace),
                          InkWell(
                            onTap: () {
                              _launchURL(ConstUtils().stringUtils.linkLinkedIn);
                            },
                            child: Icon(
                              FontAwesomeIcons.linkedin,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                          ConstUtils()
                              .widgetUtils
                              .spaceHorizontal(horizontalSpace),
                          InkWell(
                            onTap: () {
                              _launchURL(ConstUtils().stringUtils.linkTwitter);
                            },
                            child: Icon(
                              FontAwesomeIcons.twitterSquare,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                          ConstUtils()
                              .widgetUtils
                              .spaceHorizontal(horizontalSpace),
                          InkWell(
                            onTap: () {
                              _launchURL("craig.stanton2@gmail.com");
                            },
                            child: Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // Widget to embed in template
                ),
              ),
            ))
      ],
    );
  }

  _launchURL(String url) async {
    js.context.callMethod('open', [url]);
  }
}
